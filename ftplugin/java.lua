local home = "C:/Users/idrus^kaafi"
local root_markers = { 'gradlew', 'mvnw', '.git', 'pom.xml' }
local root_dir = require('jdtls.setup').find_root(root_markers)
-- local root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" })

-- local workspace_folder = "~/.local/share/eclipse/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {
    settings = {
        java = {
            contentProvider = { preferred = 'fernflower' }, -- Use fernflower to decompile library code
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
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
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = "C:/Projects/Program/java/jdk-21.0.1",
                    },
                    {
                        name = "JavaSE-1.8",
                        path = "C:\\Users\\idrus^kaafi\\Projects\\java\\jdk1.8.0_432"
                    },
                }
            }
        }
    },
    cmd = {
        -- 'C:/Users/idrus^kaafi/AppData/Local/nvim-data/mason/bin/jdtls',
        -- "C:/Projects/Program/lsp/jdt_ls/bin/jdtls.bat",
        "C:/Projects/Program/java/jdk-21.0.1/bin/java",
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:C:/Projects/Program/lsp/lombok/lombok.jar', -- Ensure this path is correct
        '-jar', vim.fn.glob('C:/Projects/Program/lsp/jdt_ls/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration', 'C:/Projects/Program/lsp/jdt_ls/config_win',
        '-data', workspace_folder
    },
    root_dir = root_dir
}

require('jdtls').start_or_attach(config)
-- print("open java file")

-- local filepath = vim.fn.expand('%:p')
-- print(filepath)
