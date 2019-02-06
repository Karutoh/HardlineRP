cmds = {}
cmds.Identifier = "/"

function AddCommand(name, desc, func)
	
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

AddCommand("dropweapon", "Allows you to drop your current weapon.", function(ply, args) 

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
			NotifyPlayer(ply, "You have dropped your current weapon!", 2, "hint")
			ply:DropWeapon(ply:GetActiveWeapon())
		end
	end

end)

AddCommand("dropmoney", "Allows you to drop a certain amount of money.", function(ply, args) 
	if !args[1] then return end

	local amount = tonumber(args[1])

	if !isnumber(amount) then return end
	
	if amount > ply:GetNWInt("money") then
		NotifyPlayer(ply, "You do not have enough money to drop that much!", 2, "hint")
		return
	end

	if amount <= 0 then
		NotifyPlayer(ply, "You must drop a higher amount!", 2, "hint")
		return
	end

	ply:SetNWInt("money", ply:GetNWInt("money") - amount)

	local money = ents.Create("hrp_money")
	money:SetNWInt("amount", amount)
	money:SetModel("models/props/cs_assault/money.mdl")

	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)
	
	money:SetPos(tr.HitPos)

	money:Spawn()
	money:DropToFloor()

end)