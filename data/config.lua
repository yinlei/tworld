-------------------------------------------------------------------------------
-- xml配置文件读取
-------------------------------------------------------------------------------
local assert = assert
local io_open = io.open
local io_close = io.close

local xml = require("lib.xmlSimple").newParser()

local root_path = "./data/config/"

local function load(filename)
	filename = root_path .. filename
	local f = assert(io_open(filename , "rb"))
	local buffer = f:read "*a"

	io_close(f)
	return xml:ParseXmlText(buffer)
end

return {
	Load = load
}
