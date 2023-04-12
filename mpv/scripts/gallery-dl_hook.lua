local utils = require 'mp.utils'
local msg = require 'mp.msg'
	
local function exec(args)
    local ret = utils.subprocess({args = args})
    return ret.status, ret.stdout, ret
end

mp.add_hook("on_load", 15, function()
    local url = mp.get_property("stream-open-filename", "")
    if (url:find("gallery%-dl://") ~= 1) then
        msg.debug("not a gallery-dl:// url: " .. url)
        return
    end
    local url = string.gsub(url,"gallery%-dl://","")

    local es, urls, result = exec({"gallery-dl", "-g", url})
    if (es < 0) or (urls == nil) or (urls == "") then
        msg.error("failed to get album list.")
    end

    mp.commandv("loadlist", "memory://" .. urls)
end)