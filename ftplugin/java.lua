local home = vim.fn.expand("$HOME")
local root_markers = { "gradlew", "mvnw", ".git", "pom.xml" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- for installation jdtls via mason should change JAVA_HOME to java >=17
-- my JAVA_HOME in windows using java 1.8
local javaPath = os.getenv("JAVA_HOME") and "C:/Projects/Program/java/jdk-21.0.1" or "/usr/lib/jvm/java-21-openjdk-amd64"
local lombokJar = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
local launcherJar = vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
local configPath = os.getenv("JAVA_HOME") and vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_win"
	or vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux"

local java_runtimes = {
	{ name = "JavaSE-21", path = javaPath },
}
if not vim.g.platform:match("Linux") then
	vim.list_extend(java_runtimes, {
		{
			name = "JavaSE-1.8",
			path = os.getenv("JAVA_HOME"),
		},
	})
end
local config = {
	settings = {
		java = {
			contentProvider = { preferred = "fernflower" }, -- Use fernflower to decompile library code
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
				runtimes = java_runtimes,
			},
		},
	},
	cmd = {
		javaPath .. "/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. lombokJar, -- Ensure this path is correct
		"-jar",
		vim.fn.glob(launcherJar),
		"-configuration",
		configPath,
		"-data",
		workspace_folder,
	},
	root_dir = root_dir,
}

require("jdtls").start_or_attach(config)
