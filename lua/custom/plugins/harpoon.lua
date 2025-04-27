return {
	{'ThePrimeagen/harpoon',
  config = function()
    require('harpoon').setup() -- Optional: you can configure it if needed
    vim.keymap.set('n', '<leader>mo', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true, desc = 'Open harpoon UI' })
    vim.keymap.set('n', '<leader>ma', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true, desc = 'Open harpoon UI' })
  end,
  },
}
