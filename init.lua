vim.g.mapleader=" "

-- 全局变量
HOME = os.getenv("HOME")
gh = "https://ggh.wisteria.cf/"
-- gh = "https://github.com/"
-- print(HOME)
--基础

require('util.func')
require('setup')
require('core')
