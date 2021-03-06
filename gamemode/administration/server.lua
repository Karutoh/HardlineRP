local cmdName = "menu"

hook.Add("PlayerSay", "HRP_Commands", function(ply, txt, teamChat)
    if txt[1] == CmdInitiator:GetString() then
        local args = string.Split(string.sub(txt, 2), " ")

        local cmd = GetCommand(args[1])
        if !cmd then
            ply:ChatPrint("That is not a valid command.")
            return ""
        end

        if !CanUseCmd(ply:GetNWString("adminRank"), args[1]) then
            ply:ChatPrint("You do not have rights to use this command.")
            return ""
        end

        cmd.cb(ply, args)

        return ""
    end

    return txt
end)

hook.Add("HRP_SavePlayerData", "HRP_CacheAdminRank", function (ply)
    WriteVar(ply.data, DatabaseType.STR, "adminRank", ply:GetNWString("adminRank"))
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheAdminRank", function (ply)
    ply:SetNWString("adminRank", ReadVar(ply.data, DatabaseType.STR, "adminRank", ""))
end)

hook.Add("HRP_InitPlayerData", "HRP_InitAdminRank", function (ply)
    ply:SetNWString("adminRank", "")
end)

local ranks = {}

local function Load()
    if !CheckDir() then
        return false
    end

    local f = file.Open("HRP/admin_ranks.txt", "rb", "DATA")

    if !f then
        return false
    end

    if f:Size() == 0 then
        f:Close()

        return false
    end

    local size = f:ReadULong()
    for i = 1, size do
        local rank = AdminRank(f:Read(f:ReadULong()))
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
        rank.viewAdminMenu = f:ReadBool()
        rank.editAdminRanks = f:ReadBool()

        table.insert(ranks, rank)
    end
    f:Close()

    return true
end

local function Save()
    local fName = "HRP/admin_ranks.txt"

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
        f:WriteBool(ranks[i].viewAdminMenu)
        f:WriteBool(ranks[i].editAdminRanks)
    end

    f:Flush()
    f:Close()

    return true
end

function AdminRank(title)
    return {
        title = title,
        color = Color(255, 255, 255, 255),
        availableCmds = {},
        viewAdminMenu = false,
        editAdminRanks = false
    }
end

function SetPlayerAdminRank(ply, adminRank)
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

function AddAdminRank(adminRank)
    for r = 1, #ranks do
        if ranks[r].title == adminRank.title then
            return false
        end
    end

    table.insert(ranks, adminRank)

    Save()

    return true
end

function GetAdminRanks()
    return ranks
end

function CanUseCmd(adminRank, cmdIdentifier)
    for i = 1, #ranks do
        if ranks[i].title == adminRank then
            for c = 1, #ranks[i].availableCmds do
                if ranks[i].availableCmds[c] == ranks[i].availableCmds then
                    return true
                end
            end
        end
    end

    return false
end

hook.Add("Initialize", "HRP_LoadAdminRanks", function ()
    Load()
end)