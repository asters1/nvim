vim.g.mapleader = " "

--map
local mode_nv = { "n", "v" }
--visual
local mode_v = { "v" }
--insert
local mode_i = { "i" }
--跳转行首与行尾
vim.cmd([[
map , 0
map . $
]])
local nmappings = {
	-- --------------  map  ---------- ---
	--移动
	{ from = "j", to = "l", mode = mode_nv },
	{ from = "l", to = "j", mode = mode_nv },
	{ from = "H", to = "7h", mode = mode_nv },
	{ from = "J", to = "7l", mode = mode_nv },
	{ from = "K", to = "7k", mode = mode_nv },
	{ from = "L", to = "7j", mode = mode_nv },
	-- ---------- INSERT模式 ---------- ---
	{ from = "<C-S>", to = "<ESC>:w<CR>a", mode = mode_i },
	{ from = "<C-X>", to = "<ESC>:lua AutoKuoHao()<CR>i", mode = mode_i },
	-- ---------- VISUAL模式 ---------- ---
	{ from = "#", to = "<ESC>Vgc", mode = mode_v },
	-- ---------- NORMAL模式 ---------- ---
	--退出与保存
	{ from = "<C-S>", to = ":w<CR>" },
	{ from = "<C-q>", to = "<ESC>:q!<CR>" },
	{ from = "q", to = "ZZ" },
	{ from = "Q", to = "ZZ" },

	{ from = "#", to = "gcc" },
	--R重新加载init.lua
	{ from = "R", to = "<ESC>:w<CR>:so<CR>" },

	-- 标签页
	{ from = "tn", to = ":tabe<CR>" },
	{ from = "t,", to = ":-tabnext<CR>" },
	{ from = "t/", to = ":-tabnext<CR>" },
	{ from = "t.", to = ":+tabnext<CR>" },

	--格式化代码
	{ from = "ff", to = "gg=Ggi<ESC>" },

	--录制宏
	{ from = "z", to = "q" },
	--查找下一个居中
	{ from = "n", to = "nzz" },
	{ from = "N", to = "Nzz" },
	--取消搜索高亮
	{ from = "<LEADER><CR>", to = ":nohlsearch<CR>" },
	--单个字小写变大写
	{ from = "U", to = "vU" },
	--窗口
	{ from = "sh", to = ":set nosplitright<CR>:vsplit<CR>" },
	{ from = "sj", to = ":set splitright<CR>:vsplit<CR>" },
	{ from = "sk", to = ":set nosplitbelow<CR>:split<CR>" },
	{ from = "sl", to = ":set splitbelow<CR>:split<CR>" },
	{ from = "<C-n>", to = ":lua IsEnableNum()<CR>" },
	--窗口移动
	{ from = "<C-h>", to = "<C-w>h" },
	{ from = "<C-j>", to = "<C-w>l" },
	{ from = "<C-l>", to = "<C-w>j" },
	{ from = "<C-k>", to = "<C-w>k" },
	{ from = "<LEADER><up>", to = ":res +5<CR" },
	{ from = "<LEADER><down>", to = ":res -5<CR>" },
	{ from = "<LEADER><left>", to = " :vertical resize-5<CR>" },
	{ from = "<LEADER><right>", to = ":vertical resize+5<CR>" },

	{ from = "<LEADER>s", to = ":lua AutoRun()<CR>" },
	{ from = "gt", to = ":lua GoTest()<CR>" },
}

for _, mapping in ipairs(nmappings) do
	vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end

local function run_vim_shortcut(shortcut)
	local escaped_shortcut = vim.api.nvim_replace_termcodes(shortcut, true, false, true)
	vim.api.nvim_feedkeys(escaped_shortcut, "n", true)
end
