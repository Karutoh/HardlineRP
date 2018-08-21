HRP.CmdInitiator = CreateConVar("hrp_cmdinitiator", "/", FCVAR_ARCHIVE)

local cmds = {}

function HRP.Command(identifier)
    return {
        identifier = identifier,
        cb = nil
    }
end

function HRP.AddCommand(cmd)
    if !cmd.cb then
        return false
    end

    for i = 1, #cmds do
        if cmds[i].identifier == cmd.identifier then
            return false
        end
    end

    table.insert(cmds, cmd)
    return true
end

function HRP.GetCommand(identifier)
    for i = 1, #cmds do
        if cmds.identifier == identifier then
            return cmds[i]
        end
    end

    return nil
end