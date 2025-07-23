hs.hotkey.bind({ "cmd" }, "B", function()
	local command = os.getenv("BROWSER")
	if command and #command > 0 then
		hs.execute("open -n -a " .. command)
	else
		print("TERMINAL variable not found")
	end
end)
