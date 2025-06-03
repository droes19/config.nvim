local lsp = require "droes.plugin.lsp_linux".lsp
local ensure_installed = require "droes.plugin.lsp_linux".ensure_installed

-- Set the command for lua_ls on Windows
lsp.lua_ls.cmd = { "C:/Users/idrus^kaafi/Projects/lsp/lua_ls/bin/lua-language-server" }
lsp.lua_ls.manual_install = true

-- Set manual_install for gopls
lsp.gopls.manual_install = true

-- Set manual_install for rust_analyzer
lsp.rust_analyzer = { manual_install = true }

lsp.html = {
    cmd = { "vscode-html-language-server.cmd", "--stdio" }
}

lsp.gradle_ls = {
    cmd = { "C:/Projects/Program/lsp/gradle_ls/gradle_lsp.bat" },
    manual_install = true
}
table.remove(ensure_installed, 1)
lsp.vtsls = {
    cmd = { "vtsls.cmd", "--stdio" }
}
lsp.tailwindcss.cmd = {"tailwindcss-language-server.cmd", "--stdio"}
lsp.yamlls.cmd = {"yaml-language-server.cmd", "--stdio"}

lsp.jsonls.cmd = { "vscode-json-language-server.cmd", "--stdio" }

local jdtls = require('java-core.ls.servers.jdtls')
local utils = require('java-core.ls.servers.jdtls.utils')
local config = jdtls.get_config({
    root_markers = { "settings.gradle", "settings.gradle.kts", "pom.xml", "build.gradle", "mvnw", "gradlew", "build.gradle", "build.gradle.kts", ".git" },
    jdtls_plugins = {},
    use_mason_jdk = false,
})
local mason = require('java-core.utils.mason')
local jdtls_root = mason.get_shared_path('jdtls')
local path = require('java-core.utils.path')
local jdtls_config = path.join(jdtls_root, 'config')
local lombok_root = mason.get_shared_path('lombok-nightly')
local lombok_path = path.join(lombok_root, 'lombok.jar')
local equinox_launcher = path.join(jdtls_root, 'plugins', 'org.eclipse.equinox.launcher.jar')
-- if you got error incubator, delete the cache jdtls
config.cmd = {
    'C:\\Projects\\Program\\graalvm-jdk-21\\bin\\java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dosgi.checkConfiguration=true',
    '-Dosgi.sharedConfiguration.area=' .. jdtls_config,
    '-Dosgi.sharedConfiguration.area.readOnly=true',
    '-Dosgi.configuration.cascaded=true',
    '-Xms1G',
    '--add-modules=ALL-SYSTEM',

    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',

    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    '-javaagent:' .. lombok_path,

    '-jar',
    equinox_launcher,

    '-configuration',
    utils.get_jdtls_config_path(),

    '-data',
    utils.get_workspace_path(),
}
config.settings = {
    java = {
        contentProvider = { preferred = "fernflower" },     -- Use fernflower to decompile library code
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
            filteredTypes = {
                "com.sun.*",
                "io.micrometer.shaded.*",
                "java.awt.*",
                "jdk.*",
                "sun.*",
            },
        },
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            hashCodeEquals = {
                useJava7Objects = true,
            },
            useBlocks = true,
        },
        configuration = {
            runtimes = {
                { name = "JavaSE-21",  path = "C:\\Projects\\Program\\graalvm-jdk-21" },
                { name = "JavaSE-1.8", path = "C:\\Program Files\\Java\\jdk1.8.0_301" }
            }
        },
    },
}
lsp.jdtls = config
-- local output = run_command("java -version")
-- if string.find(output, "1.8") then
--     lsp.jdtls = config
--     print(config.root_dir)
-- else
--     print("no")
-- end

return {
    lsp = lsp,
    ensure_installed = ensure_installed
}
