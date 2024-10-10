-- lua/notes.lua

local M = {}

-- Function to open or create a notes file
function M.open_notes()
  local notes_dir = vim.fn.expand '~/notes'
  if vim.fn.isdirectory(notes_dir) == 0 then
    vim.fn.mkdir(notes_dir, 'p')
  end

  vim.ui.select({ 'Search existing notes', 'Create new note', 'View recent notes', 'Search by tag' }, {
    prompt = 'Choose an action:',
  }, function(choice)
    if choice == 'Search existing notes' then
      require('telescope.builtin').find_files {
        prompt_title = '< Notes >',
        cwd = notes_dir,
        find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            local selection = require('telescope.actions.state').get_selected_entry()
            require('telescope.actions').close(prompt_bufnr)
            if selection then
              M.edit_note(notes_dir .. '/' .. selection.value)
            end
          end)
          return true
        end,
      }
    elseif choice == 'Create new note' then
      M.create_new_note(notes_dir)
    elseif choice == 'View recent notes' then
      M.view_recent_notes(notes_dir)
    elseif choice == 'Search by tag' then
      M.search_notes_by_tag(notes_dir)
    end
  end)
end

-- Function to edit an existing note
function M.edit_note(file_path)
  -- Open the file in a new buffer
  vim.cmd('edit ' .. vim.fn.fnameescape(file_path))

  -- Set buffer-local options for Markdown editing
  vim.api.nvim_buf_set_option(0, 'filetype', 'markdown')
  vim.api.nvim_buf_set_option(0, 'textwidth', 80)
  vim.api.nvim_buf_set_option(0, 'wrap', true)
  vim.api.nvim_buf_set_option(0, 'linebreak', true)

  -- Set up Markdown-specific keybindings
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>mp', ':MarkdownPreviewToggle<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>mt', 'yypVr=', { noremap = true, desc = 'Create Markdown h1 title' })
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ms', 'yypVr-', { noremap = true, desc = 'Create Markdown h2 title' })
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>mb', 'ciw**<C-r>"**<Esc>', { noremap = true, desc = 'Make word bold' })
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>mi', 'ciw*<C-r>"*<Esc>', { noremap = true, desc = 'Make word italic' })
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>nt', ':lua require("notes").add_tag()<CR>', { noremap = true, desc = 'Add tag to note' })

  -- Set up autocommand to save the file on buffer leave
  vim.api.nvim_create_autocmd('BufLeave', {
    pattern = file_path,
    callback = function()
      if vim.bo.modified then
        vim.cmd 'write'
        print('Note updated: ' .. vim.fn.fnamemodify(file_path, ':t'))
      end
    end,
  })
end

-- Function to create a new note
function M.create_new_note(notes_dir)
  vim.ui.input({ prompt = 'Enter note name (without extension): ' }, function(input)
    if input then
      local filename = input .. '.md'
      local file_path = notes_dir .. '/' .. filename

      -- Create the file
      vim.fn.writefile({}, file_path)

      -- Open the new file for editing
      M.edit_note(file_path)

      print('Created new note: ' .. filename)
    end
  end)
end

-- Function to view recent notes
function M.view_recent_notes(notes_dir)
  require('telescope.builtin').find_files {
    prompt_title = '< Recent Notes >',
    cwd = notes_dir,
    find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*', '--sort', 'modified' },
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        require('telescope.actions').close(prompt_bufnr)
        if selection then
          M.edit_note(notes_dir .. '/' .. selection.value)
        end
      end)
      return true
    end,
  }
end

-- Function to search notes by tag
function M.search_notes_by_tag(notes_dir)
  vim.ui.input({ prompt = 'Enter tag to search for: ' }, function(input)
    if input then
      require('telescope.builtin').grep_string {
        prompt_title = '< Notes with tag: ' .. input .. ' >',
        cwd = notes_dir,
        search = '#' .. input,
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            local selection = require('telescope.actions.state').get_selected_entry()
            require('telescope.actions').close(prompt_bufnr)
            if selection then
              M.edit_note(selection.filename)
            end
          end)
          return true
        end,
      }
    end
  end)
end

-- Function to add a tag to a note
function M.add_tag()
  vim.ui.input({ prompt = 'Enter tag (without #): ' }, function(input)
    if input then
      local tag = '#' .. input
      local line = vim.api.nvim_get_current_line()
      local new_line = line .. ' ' .. tag
      vim.api.nvim_set_current_line(new_line)
      print('Added tag: ' .. tag)
    end
  end)
end

return M
