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
    'Vigemus/iron.nvim',
    config = function()
      local iron = require 'iron.core'
      iron.setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            python = {
              command = { 'uv', 'run', '--with', 'ipython', 'ipython', '--no-autoindent' },
              format = require('iron.fts.common').bracketed_paste_python,
            },
          },
          repl_open_cmd = 'belowright 15 split',
        },
        keymaps = {
          send_motion = '<leader>rc',
          visual_send = '<leader>rc',
          send_line = '<leader>rl',
          send_file = '<leader>rf',
          send_mark = '<leader>rm',
          cr = '<leader>r<cr>',
          interrupt = '<leader>ri',
          exit = '<leader>rq',
          clear = '<leader>rx',
        },
        ignore_blank_lines = true,
      }

      -- Send the current # %% cell to the REPL
      vim.keymap.set('n', '<leader>rk', function()
        -- Find the start of the current cell (current line or above)
        local start_line = vim.fn.search('^# %%', 'bcnW')
        if start_line == 0 then
          start_line = 1
        end

        -- Find the end of the current cell (next cell marker or EOF)
        local end_line = vim.fn.search('^# %%', 'nW')
        if end_line == 0 then
          end_line = vim.fn.line '$'
        else
          end_line = end_line - 1
        end

        -- Trim leading/trailing blank lines within range
        local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
        -- Remove the cell marker line itself if it's the first line
        if lines[1] and lines[1]:match '^# %%' then
          table.remove(lines, 1)
        end
        local code = table.concat(lines, '\n')
        iron.send('python', vim.split(code, '\n'))
      end, { desc = '[R]EPL send cell' })

      -- Open / focus the REPL window
      vim.keymap.set('n', '<leader>ro', '<cmd>IronRepl<cr>', { desc = '[R]EPL [O]pen/focus' })
      vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>', { desc = '[R]EPL [H]ide' })
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
