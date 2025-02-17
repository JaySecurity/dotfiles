-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_user_command("PreviewMD", function()
  local file = vim.fn.expand("%:p") -- Get full path of current buffer
  if file == "" then
    print("No file found")
    return
  end
  vim.fn.system("tmux split-window -h 'glow -p " .. file .. "'")
end, {})

-- vim.api.nvim_create_user_command("Help", function(opts)
--   -- Insert your custom help command logic here
--   if opts.args == "" then
--     opts.args = "help"
--   end
--   vim.print(opts)
--   vim.cmd({ cmd = "help", args = { opts.args } })
-- end, { bang = true, nargs = "*" })
--
-- vim.cmd(":command! Help help")
-- vim.api.nvim_create_autocmd("BufEnter", {
--   desc = 'Disable completions in Telescope Prompts',
--   group = vim.api.nvim_create_augroup("telescope-prevent-completion", {clear = false})
-- })
--
--
--
-- vim.api.nvim_create_autocmd("TermOpen", {
--   group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
--   callback = function()
--     vim.opt.number = false
--     vim.opt.relativenumber = false
--   end,
-- })
--
-- local job_id = 0
-- vim.keymap.set("n", "<space>to", function()
--   vim.cmd.vnew()
--   vim.cmd.term()
--   vim.cmd.wincmd("L")
--   vim.api.nvim_win_set_width(0, 100)
--
--   job_id = vim.bo.channel
-- end)
--
-- local current_command = ""
-- vim.keymap.set("n", "<space>te", function()
--   current_command = vim.fn.input("Command: ")
-- end)
--
-- vim.keymap.set("n", "<space>tr", function()
--   if current_command == "" then
--     current_command = vim.fn.input("Command: ")
--   end
--
--   vim.fn.chansend(job_id, { current_command .. "\r\n" })
-- end)
