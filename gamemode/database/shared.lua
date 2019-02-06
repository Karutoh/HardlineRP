DatabaseType = {
    BYTE = 0, --Single Byte
    BOOL = 1, --Boolean
    STR = 2, --String
    UL = 3, --Unsigned Long
    L = 4, --Long
    US = 5, --Unsigned Short
    S = 6, --Short
    D = 7, --Double
    F = 8 --Float
}

function Database(fileName)
    return {
        fileName = fileName,
        data = {}
    }
end

function DatabaseEquals(a, b)
    if a.fileName != b.fileName then
        return false
    end

    if #a.data != #b.data then
        return false
    end

    for i = 1, #a.data do
        if a.data[i].type != b.data[i].type then
            return false
        end

        if a.data[i].id != b.data[i].id then
            return false
        end

        if a.data[i].v != b.data[i].v then
            return false
        end
    end

    return true
end

function ReadVar(database, type, id, default)
    default = default or 0

    for i = 1, #database.data do
        if database.data[i].type == type then
            if database.data[i].id == id then
                return database.data[i].v
            end
        end
    end

    return default
end

function WriteVar(database, type, id, v)
    PrintMessage(HUD_PRINTTALK, tostring(type) .. " " .. id .. " " .. v)

    for i = 1, #database.data do
        if database.data[i].type == type then
            if database.data[i].id == id then
                database.data[i].v = v

                return false
            end
        end
    end

    table.insert(database.data, {type = type, id = id, v = v})

    return true
end

function LoadData(database)
    local f = file.Open(database.fileName, "rb", "DATA")

    if !f then
        return database
    end

    if !f:Size() then
        f:Close()

        return database
    end

    local type = f:ReadByte()

    while type != nil do
        local id = f:Read(f:ReadULong())

        local v = nil

        if type == DatabaseType.BYTE then
            v = f:ReadByte()
        elseif type == DatabaseType.BOOL then
            v = f:ReadBool()
        elseif type == DatabaseType.STR then
            v = f:Read(f:ReadULong()) or ""
        elseif type == DatabaseType.UL then
            v = f:ReadULong()
        elseif type == DatabaseType.L then
            v = f:ReadLong()
        elseif type == DatabaseType.US then
            v = f:ReadUShort()
        elseif type == DatabaseType.S then
            v = f:ReadShort()
        elseif type == DatabaseType.D then
            v = f:ReadDouble()
        elseif type == DatabaseType.F then
            v = f:ReadFloat()
        end

        table.insert(database.data, {type = type, id = id, v = v})

        type = f:ReadByte()
    end

    f:Close()

    return database
end

function SaveData(database)
    local f = file.Open(database.fileName, "wb", "DATA")

    if !f then
        if file.Exists(database.fileName, "DATA") then
            return false
        end

        file.Write(database.fileName, "")

        return SaveData(database)
    end

    for i = 1, #database.data do
        f:WriteByte(database.data[i].type)
        f:WriteULong(string.len(database.data[i].id))
        f:Write(database.data[i].id)

        if database.data[i].type == DatabaseType.BYTE then
            f:WriteByte(database.data[i].v)
        elseif database.data[i].type == DatabaseType.BOOL then
            f:WriteBool(database.data[i].v)
        elseif database.data[i].type == DatabaseType.STR then
            f:WriteULong(string.len(database.data[i].v))
            f:Write(database.data[i].v)
        elseif database.data[i].type == DatabaseType.UL then
            f:WriteULong(database.data[i].v)
        elseif database.data[i].type == DatabaseType.L then
            f:WriteLong(database.data[i].v)
        elseif database.data[i].type == DatabaseType.US then
            f:WriteUShort(database.data[i].v)
        elseif database.data[i].type == DatabaseType.S then
            f:WriteShort(database.data[i].v)
        elseif database.data[i].type == DatabaseType.D then
            f:WriteDouble(database.data[i].v)
        elseif database.data[i].type == DatabaseType.F then
            f:WriteFloat(database.data[i].v)
        end
    end

    f:Flush()
    f:Close()

    return true
end