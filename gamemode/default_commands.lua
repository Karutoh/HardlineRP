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


local DropBlackList = {
	"weapon_physgun",
	"weapon_physcannon",
	"gmod_tool",
	"gmod_camera"
}

HRP.AddCommand("dropweapon", "Allows you to drop your current weapon.", function(ply, args) 

	isDroppable = true

	if ply:GetActiveWeapon().isDroppable != nil then
		isDroppable = ply:GetActiveWeapon().isDroppable
	end

	if isDroppable then
		InBlackList = false
		for i = 1, #DropBlackList do
			if DropBlackList[i] == ply:GetActiveWeapon():GetClass() then
				InBlackList = true
			end
		end

		if !InBlackList then
			HRP.NotifyPlayer(ply, "You have dropped your current weapon!", 2, "hint")
			ply:DropWeapon(ply:GetActiveWeapon())
		end
	end

end)