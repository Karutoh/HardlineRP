cmds = {}
cmds.Identifier = "/"

function HRP.AddCommand(name, desc, func)
	
	for i = 1, #cmds do
		if cmds[i].name == name then
			return false
		end
	end

	table.insert(cmds, {name = name, desc = desc, func = func})

	return true
end

function GM:PlayerSay(sender, text, teamChat)
	text = string.Trim(string.lower(text))

	if !string.StartWith(text, cmds.Identifier) then return end

	split = string.Split(text, " ")

	if #split[1] <= 1 then return end

	cmdName = string.sub(split[1], 2, #split[1])

	args = {}

	if #split > 1 then
		args = split
		table.remove(args, 1)
	end
	
	for i = 1, #cmds do
		
		if cmds[i].name == cmdName then
			
			cmds[i].func(sender, args)

		end

	end
	return false
end


HRP.AddCommand("dropweapon", "Allows you to drop your current weapon.", function(ply, args) 

	ply:DropWeapon(ply:GetActiveWeapon())

end)