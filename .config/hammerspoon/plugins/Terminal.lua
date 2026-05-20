local fn = function()
	local path = os.getenv("HOME") .. "/.local/state/terminal"
	if not hs.fs.attributes(path) then
		print("Terminal config file not found: " .. path)
		return
	end
	local file = io.open(path)

	local terminal = file:read("*l")
	file:close()
	if terminal and #terminal > 0 then
		hs.execute("open -n -a " .. terminal)
	else
		print("Terminal executable not found")
	end
end
hs.hotkey.bind({ "cmd" }, "return", fn)
hs.hotkey.bind({ "cmd" }, "t", fn)
