local function NewBufVertical()
  local buf_num = vim.api.nvim_create_buf(true, false)
  vim.cmd("vsplit | enew")
end

local function toggle_quickfix()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end

vim.fn.ToggleRealativeNumbers = function()
  vim.o.rnu = not vim.o.rnu
end

local opts = { noremap = true, silent = true }

-- Normal Mode

-- Toggles
vim.keymap.set("n", "<Leader>tr", vim.fn.ToggleRealativeNumbers, { desc = "[T]oggle [R]elative Numbers" })
vim.keymap.set("n", "<Leader>tq", toggle_quickfix, { desc = "[T]oggle [Q]uickfix Window" })
vim.keymap.set("n", "<Leader>tt", "<CMD>ToggleTerm<CR>", { desc = "[T]oggle [T]erminal" })
vim.keymap.set({ "n", "t", "i" }, "<C-`>", "<CMD>ToggleTerm<CR>", { desc = "[T]oggle [T]erminal" })
vim.keymap.set("n", "<Leader>te", "<CMD>Neotree toggle <CR>", { desc = "[T]oggle [E]xplorer" })
vim.keymap.set("n", "<Leader>tc", "<CMD>ColorizerToggle <CR>", { desc = "[T]oggle [C]olorizer" })
vim.keymap.set("n", "<Leader>tC", "<CMD>CloakToggle <CR>", { desc = "[T]oggle [C]loak" })
vim.keymap.set("n", "<Leader>tdb", "<CMD>DBUIToggle <CR>", { desc = "[T]oggle [D]ad[B]od UI" })

-- Launchers
vim.keymap.set("n", "<Leader>la", "<CMD>Alpha<CR>", { desc = "[L]aunch [A]lpha" })
vim.keymap.set("n", "<Leader>ll", "<CMD>Lazy<CR>", { desc = "[L]aunch [L]azy" })
vim.keymap.set("n", "<Leader>lm", "<CMD>Mason<CR>", { desc = "[L]aunch [M]ason" })
vim.keymap.set("n", "<Leader>ldb", "<CMD>DBUI<CR>", { desc = "[L]aunch [D]ad[B]od UI" })

vim.keymap.set("n", "<Leader><Leader>x", "<CMD>source %<CR>", { desc = "Source File" })
vim.keymap.set("n", "<Leader>x", ":.lua<CR>")
vim.keymap.set("v", "<Leader>x", ":lua<CR>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Next/Prev search and center
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)

-- Buffer commands
-- vim.keymap.set("n", "<Leader>bN", "<CMD>enew<CR>", { desc = "[B]uffer [N]ew" })
vim.keymap.set("n", "<Leader>bN", NewBufVertical, { desc = "[B]uffer [N]ew Vertical" })
vim.keymap.set("n", "<Leader>bd", "<CMD>bd<CR>", { desc = "[B]uffer [D]elete" })
-- vim.keymap.set("n", "<Tab>", "<CMD>bNext<CR>", { desc = "Next Buffer" })
-- vim.keymap.set("n", "<S-Tab>", "<CMD>bprevious<CR>", { desc = "Previous Buffer" })

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
-- vim.keymap.set("n", "<Leader>to", ":tabnew<CR>", vim.tbl_extend("force", opts, { desc = "New Tab" }))     -- open new tab
-- vim.keymap.set("n", "<Leader>tx", ":tabclose<CR>", vim.tbl_extend("force", opts, { desc = "Close Tab" })) -- close current tab
-- vim.keymap.set("n", "<Leader>tn", ":tabn<CR>", vim.tbl_extend("force", opts, { desc = "Next Tab" }))      --  go to next tab
-- vim.keymap.set("n", "<Leader>tp", ":tabp<CR>", vim.tbl_extend("force", opts, { desc = "Previous Tab" }))  --  go to previous tab

-- Toggle line wrapping
vim.keymap.set(
  "n",
  "<Leader>tlw",
  "<CMD>set wrap!<CR>",
  vim.tbl_extend("force", opts, { desc = "[T]oggle [L]ine [W]rap" })
)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- vim.keymap.set("i", "jkl", "<Esc>", { desc = "Exit Insert Mode" })
vim.keymap.set({ "v", "i" }, "jk", "<Esc>", { desc = "Exit Insert Mode" })
vim.keymap.set({ "i", "n", "v" }, "<C-s>", "<CMD>w<CR>", { desc = "Save File" })
vim.keymap.set({ "i", "n", "v" }, "<C-M-s>", "<CMD>wa<CR>", { desc = "Save All Files" })
