local function CheckPlyDir(ply)
    local b = HRP.CheckDir()
    local d = "HRP/player_data/" .. ply:SteamID64()

    if !file.Exists(d, "DATA") then
        file.CreateDir(d)
        b = false
    end

    return b
end

local function DataEquals(oldData, newData)
    if oldData.fileName != newData.fileName then
        return false
    end

    if #oldData.data != #newData.data then
        return false
    end

    for i = 1, #newData.data do
        if oldData.data[i].type != newData.data[i].type then
            return false
        end

        if oldData.data[i].id != newData.data[i].id then
            return false
        end

        if oldData.data[i].v != newData.data[i].v then
            return false
        end
    end

    return true
end

local function DeleteSave(ply)
    file.Write("HRP/player_data/" .. ply:SteamID64() .. "/player_data.txt", "")
end

local function Save(ply)
    CheckPlyDir(ply)

    hook.Call("HRP_SavePlayerData", nil, ply)

    if !HRP.SaveData(ply.data) then
        return false
    end

    return true
end

local function Load(ply)
    if !CheckPlyDir(ply) then
        return false
    end

    local d = ply.data

    ply.data = HRP.LoadData(ply.data)

    if !DataEquals(d, ply.data) then
        return false
    end

    hook.Call("HRP_LoadPlayerData", nil, ply)

    return true
end

hook.Add("PlayerInitialSpawn", "HRP_SavePlayerData", function (ply)
    ply.data = HRP.Database("HRP/player_data/" .. ply:SteamID64() .. "/player_data.txt")

    hook.Call("HRP_InitPlayerData", nil, ply)

    if Load(ply) then
        net.Start("HRP_Loaded")
        net.WriteString(ply:GetNWString("rpName"))
        net.Send(ply)
    else
        net.Start("HRP_New")
        net.Send(ply)
    end
end)

hook.Add("PlayerDeath", "HRP_NewLife", function (v, i, a)
    DeleteSave(v)

    net.Start("HRP_New")
    net.Send(v)
end)

net.Receive("HRP_RpName", function ()
    local ply = player.GetBySteamID64(net.ReadString())
    if !ply then
        return
    end

    ply:SetNWString("rpName", net.ReadString())

    Save(ply)
end)