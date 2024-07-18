--自动跳转到上次关闭处上一行
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
--自动关闭搜索高亮
vim.cmd([[exec "nohlsearch"]])

--自动加载模板
-- local temp = GetAllFile(HOME .. "/.config/nvim/lua/config/template")
-- print(HOME .. "\\lua\\config\\template")
local temp = GetAllFile(HOME .. "\\lua\\config\\template")
-- print(temp)
local auto_temp = [[
    augroup python_template
    autocmd!
]]

for _, f in pairs(temp) do

  local f_type = string.match(f, "[^\\]+$")
  auto_temp = auto_temp .. [[

    autocmd BufNewFile *.]] .. f_type .. [[ 0r ]] .. f
end
auto_temp = auto_temp .. [[

    augroup END
]]
-- print(auto_temp)
vim.api.nvim_exec(auto_temp, true)
