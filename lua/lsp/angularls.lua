-- local path_separator = nil
--
-- if vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1 then
--   path_separator = "\\"
-- else
--   path_separator = "/"
-- end
--
-- ---@param ... string paths to join
-- ---@return string # joined path
-- local function join(...)
--   return table.concat({ ... }, path_separator)
-- end

local get_workspace_path = function()
  local project_path = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
  local project_path_hash = string.gsub(project_path, "[\\]", "/")
  return project_path_hash
end
vim.print(get_workspace_path())

vim.lsp.config("angularls", {
  -- server_capabilities = {
  --   semanticTokensProvider = vim.NIL,
  -- },

  -- cmd = {
  --   "ngserver",
  --   "--stdio",
  --   "--tsProbeLocations",
  --   get_workspace_path() .. "/node_modules/typescript/lib",
  --   "--ngProbeLocations",
  --   get_workspace_path() .. "/node_modules/@angular/language-server/bin",
  -- },
})
vim.lsp.enable("angularls")
