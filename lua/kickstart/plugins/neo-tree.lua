-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>te', ':Neotree toggle<CR>', desc = '[T]oggle [E]xplorer', silent = true },
  },
  opts = {
    window = {
      position = 'right',
    },
    filesystem = {
      filtered_items = {
        visible = true, -- show gitignored/hidden files dimmed; toggle with `H`
        hide_gitignored = false,
        hide_hidden = false,
      },
      use_libuv_file_watcher = true, -- auto-refresh on filesystem changes (e.g. after git commands)
      follow_current_file = { enabled = true }, -- keep tree focused on current file
    },
  },
}
