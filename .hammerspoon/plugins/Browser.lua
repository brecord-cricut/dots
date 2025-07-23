hs.hotkey.bind({ "cmd" }, "B", function()
	local path = os.getenv("HOME") .. "/.config/user/browser"
	if not hs.fs.attributes(path) then
		print("Browser config file not found: " .. path)
		return
	end
	local file = io.open(path)
	local browser = file:read("*l")
	file:close()
	if browser and #browser > 0 then
		hs.execute("open -n -a " .. browser)
	else
		print("Browser executable not found")
	end
end)
