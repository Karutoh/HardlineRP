local function CheckPlyDir(ply)
    local b = CheckDir()
    local d = "HRP/player_data/" .. ply:SteamID64()

    if !file.Exists(d, "DATA") then
        file.CreateDir(d)
        b = false
    end

    return b
end

local function DeleteSave(ply)
    file.Write("HRP/player_data/" .. ply:SteamID64() .. "/player_data.txt", "")
end

local function Save(ply)
    CheckPlyDir(ply)

    hook.Call("HRP_SavePlayerData", nil, ply)

    if !SaveData(ply.data) then
        return false
    end

    return true
end

local function Load(ply)
    if !CheckPlyDir(ply) then
        return false
    end

    local d = ply.data

    ply.data = LoadData(ply.data)

    if !DatabaseEquals(d, ply.data) then
        return false
    end

    hook.Call("HRP_LoadPlayerData", nil, ply)

    return true
end

hook.Add("PlayerInitialSpawn", "HRP_SavePlayerData", function (ply)
    ply.data = Database("HRP/player_data/" .. ply:SteamID64() .. "/player_data.txt")

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

function GetPlayerData(steamID)
    if !CheckDir() then
        return nil
    end

    local oldData = Database("hrp/player_data/" .. steamID .. "/player_data.txt")

    local data = LoadData(oldData)

    if DatabaseEquals(oldData, data) then
        return nil
    end

    return data
end

function GetAllPlayerData(offlineOnly)
    local files, directories = file.Find("hrp/player_data/*", "DATA")
    local playerData = {}

    for i = 1, #directories do
        if offlineOnly then
            if !player.GetBySteamID64(directories[i]) then
                local data = Database("hrp/player_data/" .. directories[i] .. "/player_data.txt")

                table.insert(player_data, {directories[i], LoadData(data)})
            end
        else
            local data = Database("hrp/player_data/" .. directories[i] .. "/player_data.txt")

            table.insert(player_data, {directories[i], LoadData(data)})
        end
    end
end