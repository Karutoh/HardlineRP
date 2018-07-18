local function CheckPlyDir(ply)
    local b = TRP.CheckDir()
    local d = "trp/player_data/" .. ply:SteamID64()

    if !file.Exists(d, "DATA") then
        file.CreateDir(d)
        b = false
    end

    return b
end

local function DeleteSave(ply)
    file.Write("trp/player_data/" .. ply:SteamID64() .. "/player_data.txt", "")
end

local function Save(ply)
    local fName = "trp/player_data/" .. ply:SteamID64() .. "/player_data.txt"

    CheckPlyDir(ply)

    local f = file.Open(fName, "wb", "DATA")

    if !f then
        if file.Exists(fName, "DATA") then
            ply:ChatPrint("Server - Failed to save your player data because another application currently has it open.")

            return false
        end

        file.Write(fName, "")

        return Save(ply)
    end

    local adminR = ply:GetNWString("adminRank")
    f:WriteULong(string.len(adminR))
    f:Write(adminR)

    hook.Call("TRP_SavePlayerData", nil, f, ply)

    f:Flush()
    f:Close()

    return true
end

local function Load(ply)
    if !CheckPlyDir(ply) then
        return false
    end

    local f = file.Open("trp/player_data/" .. ply:SteamID64() .. "/player_data.txt", "rb", "DATA")

    if !f then
        return false
    end

    if f:Size() == 0 then
        f:Close()

        return false
    end

    if !TRP.SetPlayerAdminRank(ply, f:Read(f:ReadULong()) or "") then
        ply:ChatPrint("Server - Loaded admin rank, but it does not exist.")
    end

    hook.Call("TRP_LoadPlayerData", nil, f, ply)

    f:Close()

    return true
end

hook.Add("PlayerInitialSpawn", "TRP_SavePlayerData", function (ply)
    hook.Call("TRP_InitPlayerData", nil, ply)

    if Load(ply) then
        net.Start("TRP_Loaded")
        net.WriteString(ply:GetNWString("rpName"))
        net.Send(ply)
    else
        net.Start("TRP_New")
        net.Send(ply)
    end
end)

hook.Add("PlayerDeath", "TRP_NewLife", function (v, i, a)
    DeleteSave(v)

    net.Start("TRP_New")
    net.Send(v)
end)

net.Receive("TRP_RpName", function ()
    local ply = player.GetBySteamID64(net.ReadString())
    if !ply then
        return
    end

    ply:SetNWString("rpName", net.ReadString())

    Save(ply)
end)