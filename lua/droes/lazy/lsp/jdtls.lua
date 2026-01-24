local List = require("droes.utils.list")
local path = require("droes.utils.path")
local file = require("droes.utils.file")
local mason = require("droes.utils.mason")

local plug_jar_map = {
  ["java-test"] = {
    "junit-jupiter-api_*.jar",
    "junit-jupiter-engine_*.jar",
    "junit-jupiter-migrationsupport_*.jar",
    "junit-jupiter-params_*.jar",
    "junit-platform-commons_*.jar",
    "junit-platform-engine_*.jar",
    "junit-platform-launcher_*.jar",
    "junit-platform-runner_*.jar",
    "junit-platform-suite-api_*.jar",
    "junit-platform-suite-commons_*.jar",
    "junit-platform-suite-engine_*.jar",
    "junit-vintage-engine_*.jar",
    "org.apiguardian.api_*.jar",
    "org.eclipse.jdt.junit4.runtime_*.jar",
    "org.eclipse.jdt.junit5.runtime_*.jar",
    "org.opentest4j_*.jar",
    "com.microsoft.java.test.plugin-*.jar",
  },
  ["java-debug-adapter"] = { "*.jar" },
  ["spring-boot-tools"] = { "jars/*.jar" },
}

local get_plugin_paths = function(plugin_names)
  return List:new(plugin_names)
    :map(function(plugin_name)
      local root = mason.get_shared_path(plugin_name)
      return file.resolve_paths(root, plug_jar_map[plugin_name])
    end)
    :flatten()
end

local get_workspace_path = function()
  local project_path = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
  local project_path_hash = string.gsub(project_path, "[/\\:+-]", "_")

  local nvim_cache_path = vim.fn.stdpath("cache")
  return path.join(nvim_cache_path, "jdtls", "workspaces", project_path_hash)
end

local get_jdtls_config_path = function()
  return path.join(vim.fn.stdpath("cache"), "jdtls", "config")
end

local jdtls_root = mason.get_shared_path("jdtls")
local jdtls_config = path.join(jdtls_root, "config")
local lombok_path = path.join(jdtls_root, "lombok.jar")
local equinox_launcher = path.join(jdtls_root, "plugins", "org.eclipse.equinox.launcher.jar")

local list_plugin = { "java-debug-adapter" }
local plugin_path = get_plugin_paths(list_plugin)

return {
  cmd = {"jdtls"},
  -- cmd = {
  --   "java",
  --   "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  --   "-Dosgi.bundles.defaultStartLevel=4",
  --   "-Declipse.product=org.eclipse.jdt.ls.core.product",
  --   "-Dosgi.checkConfiguration=true",
  --   "-Dosgi.sharedConfiguration.area=" .. jdtls_config,
  --   "-Dosgi.sharedConfiguration.area.readOnly=true",
  --   "-Dosgi.configuration.cascaded=true",
  --   -- "-Xms1G",
  --   "-Xms256m",
  --   "-Xmx1024m",
  --   "-XX:+UseZGC",
  --   "-XX:SoftMaxHeapSize=768m",
  --   "--add-modules=ALL-SYSTEM",
  --   "--add-opens",
  --   "java.base/java.util=ALL-UNNAMED",
  --   "--add-opens",
  --   "java.base/java.lang=ALL-UNNAMED",
  --   "-javaagent:" .. lombok_path,
  --   "-jar",
  --   equinox_launcher,
  --   "-configuration",
  --   get_jdtls_config_path(),
  --   "-data",
  --   get_workspace_path(),
  -- },
  -- -- init_options = {
  -- --   extendedClientCapabilities = {
  -- --     actionableRuntimeNotificationSupport = true,
  -- --     advancedExtractRefactoringSupport = true,
  -- --     advancedGenerateAccessorsSupport = true,
  -- --     advancedIntroduceParameterRefactoringSupport = true,
  -- --     advancedOrganizeImportsSupport = true,
  -- --     advancedUpgradeGradleSupport = true,
  -- --     classFileContentsSupport = true,
  -- --     clientDocumentSymbolProvider = true,
  -- --     clientHoverProvider = false,
  -- --     executeClientCommandSupport = true,
  -- --     extractInterfaceSupport = true,
  -- --     generateConstructorsPromptSupport = true,
  -- --     generateDelegateMethodsPromptSupport = true,
  -- --     generateToStringPromptSupport = true,
  -- --     gradleChecksumWrapperPromptSupport = true,
  -- --     hashCodeEqualsPromptSupport = true,
  -- --     inferSelectionSupport = {
  -- --       "extractConstant",
  -- --       "extractField",
  -- --       "extractInterface",
  -- --       "extractMethod",
  -- --       "extractVariableAllOccurrence",
  -- --       "extractVariable",
  -- --     },
  -- --     moveRefactoringSupport = true,
  -- --     onCompletionItemSelectedCommand = "editor.action.triggerParameterHints",
  -- --     overrideMethodsPromptSupport = true,
  -- --   },
  -- --   bundles = plugin_path,
  -- -- },
  -- settings = {
  --   java = {
  --     completion = {
  --       maxResults = 20, -- default can be large; reduce candidate set
  --     },
  --     format = {
  --       enabled = false, -- let an external formatter (e.g., google-java-format) run on demand
  --     },
  --     contentProvider = { preferred = "fernflower" }, -- faster decompiler than CFR in many cases
  --     referencesCodeLens = { enabled = false }, -- code lens can be expensive on large workspaces
  --     -- signatureHelp = { enabled = false }, -- if you don’t rely on it (optional)
  --     import = {
  --       gradle = { enabled = true },
  --       maven = { enabled = true },
  --       exclusions = {
  --         "**/node_modules/**",
  --         "**/.git/**",
  --         "**/build/**",
  --         "**/target/**",
  --         "**/.gradle/**",
  --         "**/.mvn/**",
  --         "**/.idea/**",
  --         "**/.vscode/**",
  --       },
  --     },
  --     project = {
  --       resourceFilters = {
  --         "node_modules",
  --         ".git",
  --         "build",
  --         "target",
  --         ".gradle",
  --         ".idea",
  --         ".vscode",
  --       },
  --     },
  --     -- autobuild = { enabled = false }, -- disable continuous autobuild; build manually
  --     sources = {
  --       organizeImports = {
  --         starThreshold = 9999,
  --         staticStarThreshold = 9999,
  --       },
  --     },
  --     codeGeneration = {
  --       toString = {
  --         template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
  --       },
  --       hashCodeEquals = {
  --         useJava7Objects = true,
  --       },
  --       useBlocks = true,
  --     },
  --     configuration = {
  --       runtimes = {
  --         { name = "JavaSE-1.8", path = "C:\\Program Files\\Java\\jdk1.8.0_301" },
  --         { name = "JavaSE-21", path = "C:\\Projects\\Program\\graalvm-jdk-21" },
  --       },
  --     },
  --   },
  -- },
  -- server_capabilities = {
  --   semanticTokensProvider = vim.NIL,
  -- },
}
