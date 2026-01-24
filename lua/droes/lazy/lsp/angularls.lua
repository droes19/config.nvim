return {
  flags = { debounce_text_changes = 250 },
  on_new_config = function(new_config, root_dir)
    -- Avoid scanning the whole monorepo by restricting file globs
    new_config.settings = vim.tbl_deep_extend("force", new_config.settings or {}, {
      angular = {
        suggest = { enabled = true },
        -- Reduce template diagnostics while typing for perf:
        -- (Angular LS applies template type-checking; turning these off trims CPU)
        inlayHints = { includeInlayAngularTemplateContext = false }, -- if available
      },
      files = {
        exclude = { "**/.git/**", "**/node_modules/**", "**/dist/**", "**/build/**" },
      },
    })
  end,
}
