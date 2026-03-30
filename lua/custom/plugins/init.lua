-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    opts = {
      options = {
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Explorer',
            highlight = 'Directory',
            separator = true,
          },
        },
        custom_filter = function(buf_number)
          return vim.bo[buf_number].buftype ~= 'terminal'
        end,
      },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = 15,
      open_mapping = [[<leader>tt]],
      insert_mappings = false,
      terminal_mappings = false,
      direction = 'horizontal',
      shade_terminals = true,
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)
      vim.keymap.set('n', '<leader>t1', '<cmd>1ToggleTerm<cr>', { desc = 'Terminal 1' })
      vim.keymap.set('n', '<leader>t2', '<cmd>2ToggleTerm<cr>', { desc = 'Terminal 2' })
      vim.keymap.set('n', '<leader>t3', '<cmd>3ToggleTerm<cr>', { desc = 'Terminal 3' })
      vim.keymap.set('n', '<leader>st', '<cmd>TermSelect<cr>', { desc = '[S]earch [T]erminals' })
    end,
  },
  {
    'lervag/vimtex',
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = 'zathura'
    end,
  },
}
