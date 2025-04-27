return {
  -- Plugin for github actions
  'tpope/vim-fugitive',
  config = function()
    function DeleteGitBranchUnderCursor()
      local line = vim.api.nvim_get_current_line()
      local branch = line:gsub('^%*', ''):match '^%s*(.-)%s*$'

      if branch == 'main' or branch == 'master' then
        vim.notify('Refusing to delete branch: ' .. branch, vim.log.levels.WARN)
        return
      end

      if branch == '' then
        vim.notify('No branch found under cursor', vim.log.levels.ERROR)
        return
      end

      vim.ui.input({ prompt = "delete branch '" .. branch .. "'? (Default=n) (y/n): " }, function(input)
        if input and input:lower() == 'y' then
          vim.fn.jobstart({ 'git', 'branch', '-D', branch }, {
            on_stdout = function(_, data)
              if data then
                vim.notify(table.concat(data, '\n'))
              end
            end,
            on_stderr = function(_, data)
              if data then
                vim.notify(table.concat(data, '\n'), vim.log.levels.ERROR)
              end
            end,
            stdout_buffered = true,
            stderr_buffered = true,
            on_exit = function()
              -- Close the current `:Git branch` window and reopen it to refresh the list
              -- This is where we reload the `:Git branch` window
              vim.cmd 'bdelete' -- Close the current buffer
              vim.cmd 'Git branch' -- Reopen the `:Git branch` window
            end,
          })
        else
          vim.notify 'Canceled'
        end
      end)
    end

    function CheckoutGitBranchUnderCursor()
      local line = vim.api.nvim_get_current_line()
      local branch = line:gsub('^%*', ''):match '^%s*(.-)%s*$'

      if branch == '' then
        vim.notify('No branch found under cursor', vim.log.levels.ERROR)
        return
      end

      vim.ui.input({ prompt = "Checkout to branch '" .. branch .. "'? (Default=y) (y/n): " }, function(input)
        if input == '' or input:lower() == 'y' then
          vim.fn.jobstart({ 'git', 'checkout', branch }, {
            on_stdout = function(_, data)
              if data then
                vim.notify(table.concat(data, '\n'))
              end
            end,
            on_stderr = function(_, data)
              if data then
                vim.notify(table.concat(data, '\n'), vim.log.levels.ERROR)
              end
            end,
            stdout_buffered = true,
            stderr_buffered = true,
            on_exit = function()
              -- Close the current `:Git branch` window and reopen it to refresh the list
              -- This is where we reload the `:Git branch` window
              vim.cmd 'bdelete' -- Close the current buffer
              vim.cmd 'Git branch' -- Reopen the `:Git branch` window
            end,
          })
        else
          vim.notify 'Canceled'
        end
      end)
    end

    local function gitSquashMerge()
      local line = vim.api.nvim_get_current_line()
      local branch = line:gsub('^%*', ''):match '^%s*(.-)%s*$'

      local handle = io.popen 'git rev-parse --abbrev-ref HEAD 2>/dev/null'
      local current_branch = handle:read '*a'
      handle:close()
      current_branch = current_branch:gsub('%s+', '') -- remove newline

      if branch == '' then
        vim.notify('No branch found under cursor', vim.log.levels.ERROR)
        return
      end

      vim.ui.input({ prompt = "Squash merge branch '" .. branch .. "' into '" .. current_branch .. "' ? (Default=n) (y/n): " }, function(input)
        if input and input:lower() == 'y' then
          vim.fn.jobstart({ 'git', 'merge', '--squash', branch }, {
            on_stdout = function(_, data)
              if data then
                vim.notify(table.concat(data, '\n'))
              end
            end,
            on_stderr = function(_, data)
              if data then
                vim.notify(table.concat(data, '\n'), vim.log.levels.ERROR)
              end
            end,
            stdout_buffered = true,
            stderr_buffered = true,
            on_exit = function()
              -- Close the current `:Git branch` window and reopen it to refresh the list
              -- This is where we reload the `:Git branch` window
              vim.cmd 'bdelete' -- Close the current buffer
              vim.cmd 'Git branch' -- Reopen the `:Git branch` window
            end,
          })
        else
          vim.notify 'Canceled'
        end
      end)
    end

    local function gitDiffFileToBranch()
      vim.ui.input({ prompt = 'Diff current file against which branch? (Default=main): ', default = '' }, function(input)
        local cmd
        if input == '' then
          cmd = string.format 'Gvdiffsplit main'
        else
          cmd = string.format('Gvdiffsplit %s', input)
        end
        -- Run Gvdiffsplit
        vim.cmd(cmd)
      end)
    end

    local function gitDiffBranch()
      vim.ui.input({ prompt = 'Diff current branch against which branch? (Default=main): ', default = '' }, function(input)
        local cmd
        if input == '' then
          cmd = string.format 'Git diff main'
        else
          cmd = string.format('Git diff %s', input)
        end
        -- Run Git diff
        vim.cmd(cmd)
        vim.cmd 'only'
      end)
    end

    vim.keymap.set('n', '<leader>gO', ':G<CR>', { noremap = true, silent = true, desc = 'Open fugitive terminal' })
    vim.keymap.set('n', '<leader>go', ':G<CR><C-w>o', { noremap = true, silent = true, desc = 'Open fugitive terminal full screen' })
    vim.keymap.set('n', '<leader>gb', ':Git branch<CR>', { noremap = true, silent = true, desc = 'Get all branches' })
    vim.keymap.set('n', '<leader>gd', gitDiffFileToBranch, { noremap = true, silent = true, desc = 'Diff file from current branch to input' })
    vim.keymap.set('n', '<leader>gD', gitDiffBranch, { noremap = true, silent = true, desc = 'Diff project from current branch to input' })
    vim.keymap.set('n', '<leader>gs', ':Gitsigns stage_hunk<CR>', { noremap = true, silent = true, desc = 'Stage a hunk' })
    vim.keymap.set('n', '<leader>gu', ':Gitsigns reset_hunk<CR>', { noremap = true, silent = true, desc = 'Unstage a hunk' })
    vim.keymap.set('n', '<leader>gv', ':lua require("gitsigns").preview_hunk()<CR>', { noremap = true, silent = true, desc = 'Preview a hunk' })
    vim.keymap.set('n', '<leader>gpb', function()
      vim.api.nvim_feedkeys(':Git branch ', 'n', false)
    end, { noremap = true, silent = true, desc = 'Populate :Git branch' })
    vim.keymap.set('n', '<leader>gpc', function()
      vim.cmd 'Git branch'
      vim.api.nvim_feedkeys(':Git checkout ', 'n', false)
    end, { noremap = true, silent = true, desc = 'Populate :Git checkout' })
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf = args.buf
        local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
        local buf_name = vim.api.nvim_buf_get_name(buf)

        if first_line and first_line:match '^%s*[%*%w]' and buf_name:find 'private' then
          vim.keymap.set('n', 'd', DeleteGitBranchUnderCursor, {
            buffer = true,
            desc = 'Delete Git branch under cursor',
          })
          vim.keymap.set('n', 'c', CheckoutGitBranchUnderCursor, {
            buffer = true,
            desc = 'Checkout Git branch under cursor',
          })
          vim.keymap.set('n', 'M', gitSquashMerge, {
            buffer = true,
            desc = 'Squash merge branch under cursor into current branch',
          })
          vim.keymap.set('n', 'n', function()
            -- Set a one-time autocmd for when the command line is exited
            vim.api.nvim_create_autocmd('CmdlineLeave', {
              once = true,
              callback = function()
                vim.defer_fn(function()
                  vim.cmd 'bdelete' -- close the current buffer (Git checkout prompt buffer)
                  vim.cmd 'Git branch' -- reopen updated branch list
                end, 100) -- slight delay just in case
              end,
            })

            -- Trigger the command prompt for creating a branch
            vim.api.nvim_feedkeys(':Git checkout -b ', 'n', false)
          end, {
            buffer = true,
            desc = 'Checkout Git branch under cursor',
          })
        end
      end,
    })
  end,
}
