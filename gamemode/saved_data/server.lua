local function CheckDir()
    if !file.Exists("TRP_PlayerData", "DATA") then
        file.CreateDir("TRP_PlayerData")

        return false
    end

    return true
end

local function DeleteSave(ply)
    file.Write("TRP_PlayerData/" .. ply:SteamID64() .. ".txt", "")
end

local function Load(ply)
    if !CheckDir() then
        return false
    end

    local f = file.Open("TRP_PlayerData/" .. ply:SteamID64() .. ".txt", "rb", "DATA")

    if !f then
        return false
    end

    if f:Size() == 0 then
        f:Close()

        return false
    end

    ply:SetNWString("rpName", f:Read(f:ReadULong()))

    hook.Call("TRP_LoadPlayerData", f, ply)

    f:Close()

    return true
end

local function Save(ply)
    local fName = "TRP_PlayerData/" .. ply:SteamID64() .. ".txt"

    CheckDir()

    local f = file.Open(fName, "wb", "DATA")

    if !f then
        if file.Exists(fName, "DATA") then
            ply:ChatPrint("Server - Failed to save your player data because another application currently has it open.")

            return false
        end

        file.Write(fName, "")

        return Save(ply)
    end

    local n = ply:GetNWString("rpName")

    f:WriteULong(string.len(n))
    f:Write(n)

    hook.Call("TRP_SavePlayerData", f, ply)

    f:Flush()
    f:Close()

    return true
end

hook.Add("PlayerInitialSpawn", "TRP_SavePlayerData", function (ply)
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