hook.Add("TRP_SavePlayerData", "TRP_CacheAdminRank", function (f, ply)
    local adminRank = ply:GetNWString("adminRank")
    f:WriteULong(string.len(adminRank))
    f:Write(adminRank)
end)

hook.Add("TRP_LoadPlayerData", "TRP_CacheAdminRank", function (f, ply)
    ply:SetNWString("adminRank", f:Read(f:ReadULong()))
end)

hook.Add("TRP_InitPlayerData", "TRP_InitAdminRank", function (ply)
    ply:SetNWString("adminRank", "")
end)

local ranks = {}

local function Load()
    if !TRP.CheckDir() then
        return false
    end

    local f = file.Open("trp/admin_ranks.txt", "rb", "DATA")

    if !f then
        return false
    end

    if f:Size() == 0 then
        f:Close()

        return false
    end

    local size = f:ReadULong()
    for i = 1, size do
        local rank = TRP.AdminRank(f:Read(f:ReadULong()))
        rank.color = {
            f:ReadByte(),
            f:ReadByte(),
            f:ReadByte(),
            f:ReadByte()
        }
        local cmds = f:ReadULong()
        for c = 1, cmds do
            table.insert(rank.availableCmds, f:Read(f:ReadULong()))
        end

        table.insert(ranks, rank)
    end
    f:Close()

    return true
end

local function Save()
    local fName = "trp/admin_ranks.txt"

    TRP.CheckDir()

    local f = file.Open(fName, "wb", "DATA")

    if !f then
        if file.Exists(fName, "DATA") then
            ply:ChatPrint("Server - Failed to save your player data because another application currently has it open.")

            return false
        end

        file.Write(fName, "")

        return Save(ply)
    end

    f:WriteULong(#ranks)
    for i = 1, #ranks do
        f:WriteULong(string.len(ranks[i].title))
        f:Write(ranks[i].title)
        f:WriteByte(ranks[i].color.r)
        f:WriteByte(ranks[i].color.g)
        f:WriteByte(ranks[i].color.b)
        f:WriteByte(ranks[i].color.a)
        f:WriteULong(#ranks[i].availableCmds)
        for c = 1, #ranks[i].availableCmds do
            f:WriteULong(string.len(ranks[i].availableCmds[c]))
            f:Write(ranks[i].availableCmds[c])
        end
    end

    f:Flush()
    f:Close()

    return true
end

function TRP.AdminRank(title)
    return {
        title = title,
        color = Color(255, 255, 255, 255),
        availableCmds = {}
    }
end

function TRP.SetPlayerAdminRank(ply, adminRank)
    if string.len(adminRank) == 0 then
        ply:SetNWString("adminRank", "")
        return true
    end

    for r = 1, #ranks do
        if ranks[r] == adminRank then
            ply:SetNWString("adminRank", adminRank)
            return true
        end
    end

    return false
end

function TRP.AddAdminRank(adminRank)
    for r = 1, #ranks do
        if ranks[r].title == adminRank.title then
            return false
        end
    end

    table.insert(ranks, adminRank)

    Save()

    return true
end

function TRP.GetAdminRanks()
    return ranks
end

hook.Add("Initialize", "TRP_LoadAdminRanks", function ()
    Load()
end)