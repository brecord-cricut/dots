hs.hotkey.bind({ "cmd" }, "return", function()
	local command = os.getenv("TERMINAL")
	if command and #command > 0 then
		hs.execute("open -n -a " .. command)
	else
		print("TERMINAL variable not found")
	end
end)
