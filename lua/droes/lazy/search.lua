return {
  "kevinhwang91/nvim-hlslens",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "n",
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
      desc = "Next search result (centered with hlslens)",
    },
    {
      "N",
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
      desc = "Previous search result (centered with hlslens)",
    },
  },
}
