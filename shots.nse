description = [[
Does screenshots
]]

author = "Cory Michal"
license = "Same as Nmap--See http://nmap.org/book/man-legal.html"
categories = {"default", "safe"}

local stdnse = require "stdnse"
local shortport = require "shortport"

-- Decide if we want to run the screen shot action based on port number and state being open
portrule = function (host,port) 
	return port.protocol == "tcp" 
		and port.state == "open"
		and port.number ~= 21 
		and port.number ~= 22 
		and port.number ~= 53 
end

action = function(host, port)
        -- Look for SSL 
        local isssl = shortport.ssl(host,port)

        -- Set default prefix http 
        local prefix = "http"

        -- If SSL is set on the port, switch the prefix to https
        if isssl then
                prefix = "https"
        end
        
	if (host.targetname) then
                starget = host.targetname
        else
                starget = host.ip
        end

	-- Set a file name for screenshot with target and port
	local filename = "shot-"..starget.."."..port.number..".png"
        
	-- Set the command to run phantom JS screenshot.js script to get the screenshot for us. Timeout is set to 5 seconds in script
	local cmd = "phantomjs --ignore-ssl-errors=yes /usr/local/share/nmap/scripts/screenshot.js " .. prefix .. "://" .. starget .. ":" .. port.number .. " " .. filename .. " 2> /dev/null   >/dev/null"
	
	-- Do the thing!
	local ret = os.execute(cmd)

	local result = "Failed "
        if ret then
                result = "Wrote screenshot file"..filename
        end 
	return stdnse.format_output(true,  result)
end
