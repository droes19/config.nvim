local default_conf = require("java.config")
local Manager = require("pkgm.manager")
local path = require("java-core.utils.path")
local system = require("java-core.utils.system")
local lsp_utils = require("java-core.utils.lsp")
local err = require("java-core.utils.errors")

local jdtls_root = Manager:get_install_dir("jdtls", default_conf.jdtls.version)
local jdtls_config = path.join(jdtls_root, system.get_config_suffix())
local lombok_root = Manager:get_install_dir("lombok", default_conf.lombok.version)
local lombok_path = vim.fn.glob(path.join(lombok_root, "lombok*.jar"))

local cwd = vim.fn.getcwd()
local launcher_reg = path.join(jdtls_root, "plugins", "org.eclipse.equinox.launcher_*.jar")
local equinox_launcher = vim.fn.glob(path.join(jdtls_root, "plugins", "org.eclipse.equinox.launcher_*.jar"))
if equinox_launcher == "" then
  -- stylua: ignore
  local msg = string.format("JDTLS equinox launcher not found. Expected path: %s. ", launcher_reg)
  err.throw(msg)
end

vim.lsp.config("jdtls", {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dosgi.checkConfiguration=true",
    "-Dosgi.sharedConfiguration.area=" .. jdtls_config,
    "-Dosgi.sharedConfiguration.area.readOnly=true",
    "-Dosgi.configuration.cascaded=true",
    "-Xms256m",
    "-Xmx1g",
    "-XX:+UseG1GC",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. lombok_path,
    "-jar",
    equinox_launcher,
    "-configuration",
    lsp_utils.get_jdtls_cache_conf_path(),
    "-data",
    lsp_utils.get_jdtls_cache_data_path(cwd),
  },
  settings = {
    java = {
      completion = {
        guessMethodArguments = false,
        maxResults = 20, -- default can be large; reduce candidate set
      },
      format = {
        enabled = false, -- let an external formatter (e.g., google-java-format) run on demand
      },
      contentProvider = { preferred = "fernflower" }, -- faster decompiler than CFR in many cases
      referencesCodeLens = { enabled = false }, -- code lens can be expensive on large workspaces
      signatureHelp = { enabled = false }, -- if you don’t rely on it (optional)
    },
  },
  server_capabilities = {
    semanticTokensProvider = vim.NIL,
  },
})
vim.lsp.enable("jdtls")
