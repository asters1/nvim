local opt = vim.opt

-- 文本格式为utf-8
opt.encoding = "utf-8"
-- 行号
opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- 光标下划线
opt.cursorline = true

-- 自动换行
opt.wrap = true

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索大小写...
opt.ignorecase = true
opt.smartcase = true

--上下行保持8行
opt.scrolloff = 8
--禁用鼠标
opt.mouse = ""


-- 外观,第一行终端真颜色，第二个"yes"为多一列
opt.termguicolors = true
opt.signcolumn = "yes"
