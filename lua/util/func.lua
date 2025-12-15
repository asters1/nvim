-- 遍历文件夹下的所有文件，并返回路径列表
function GetAllFile(path)
	local file_paths = {} -- 文件路径列表
	local cmd = string.format("find %q -type f", path) -- shell 命令
	local handle = io.popen(cmd) -- 执行 shell 命令并获取输出
	local result = handle:read("*a") -- 读取输出
	handle:close()
	for file_path in result:gmatch("[^\n]+") do
		table.insert(file_paths, file_path)
	end
	return file_paths
end

--判断文件或者文件夹是否存在
IsExists = function(path)
	local file = io.open(path, "rb")
	if file then
		io.close(file)
		return true
	else
		return false
	end
end

IsEnableNum = function()
	if vim.o.number == true then
		vim.o.relativenumber = false
		vim.o.number = false
		vim.o.signcolumn = "no"
		vim.cmd([[:DisableHL]])
	else
		vim.o.number = true
		vim.o.relativenumber = true
		vim.o.signcolumn = "yes"
		vim.cmd([[:EnableHL]])
	end
end

GoTest = function()
	vim.cmd([[
  call setreg('z',"\<ESC>ggdGipackage main\n\nimport (\n\"testing\"\n\"fmt\"\n)\nfunc TestMain(t *testing.T) {\nfmt.Println(\"Test\")\n}\<ESC>:w <CR>")
  normal @z
  ]])
end
-- 自动括号
AutoKuoHao = function()
	vim.cmd([[
  call setreg('z',"\<ESC>ciw<>\<ESC>hpja</>\<ESC>hpyiwhh")
  normal @z
  ]])
end

AutoRun = function()
	-- print("hhh")
	--
	vim.cmd([[
  exec "w"
  set splitbelow
  :sp
  ]])
	local filetype = vim.bo.filetype
	local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
	-- print(filename)
	if IsExists("./run.sh") then
		vim.cmd([[:term bash ./run.sh]])
	else
		if filetype == "go" then
			if string.len(filename) > 8 and string.sub(filename, -8) == "_test.go" then
				-- print(string.sub(filename, -8))
				vim.cmd([[:term go test]])
			else
				vim.cmd([[:term go run .]])
			end
		elseif filetype == "sh" then
			vim.cmd([[:term bash %]])
		elseif filetype == "java" then
			vim.cmd([[:term javac % && java %<]])
		elseif filetype == "c" then
			vim.cmd([[:term gcc % -o %< && ./%<]])
		elseif filetype == "cpp" then
			vim.cmd([[:term g++ % -o %< && ./%<]])
		elseif filetype == "python" then
			vim.cmd([[:term python3 %]])
		elseif filetype == "javascript" then
			vim.cmd([[:term node %]])
		elseif filetype == "html" then
			vim.cmd([[
      :q
      :silent !microsoft-edge-stable %
      ]])
		end
	end
end
