local jobs = {}

hook.Add("HRP_SavePlayerData", "HRP_CacheJob", function (ply)
    WriteVar(ply.data, DatabaseType.STR, "jobCategory", ply:GetNWString("jobCategory"))
    WriteVar(ply.data, DatabaseType.STR, "jobTitle", ply:GetNWString("jobTitle"))
    WriteVar(ply.data, DatabaseType.STR, "jobRank", ply:GetNWString("jobRank"))
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheSkills", function (ply)
    ply:SetNWString("jobCategory", ReadVar(ply.data, DatabaseType.STR, "jobCategory", ""))
    ply:SetNWString("jobTitle", ReadVar(ply.data, DatabaseType.STR, "jobTitle", ""))
    ply:SetNWString("jobRank", ReadVar(ply.data, DatabaseType.STR, "jobRank", ""))
end)

hook.Add("HRP_InitPlayerData", "HRP_InitJobInfo", function (ply)
    ply:SetNWString("jobCategory", "")
    ply:SetNWString("jobTitle", "")
    ply:SetNWString("jobRank", "")
end)

function FindRank(rank, rankTable)
    if rankTable.title == rank then
        return rankTable
    end

    for r = 1, #rankTable.promotions do
        return FindRank(rank, rankTable.promotions[r])
    end

    return nil
end

function JobRank(rankTitle)
    return {
        title = rankTitle,
        description = "",
        dailySalary = 0,
        loadout = {},
        plyMdls = {},
        requiredExp = {},
        promotions = {}
    }
end

function SetPlayerJob(ply, jobCategory, jobTitle, jobRank)
    for c = 1, #jobs do
        if jobs[c].title == jobCategory then
            for t = 1, #jobs[c].jobTitles do
                if jobs[c].jobTitles[t].title == jobTitle then
                    for r = 1, #jobs[c].jobTitles[t].jobRanks do
                        if jobs[c].jobTitles[t].jobRanks[r].title == jobRank then
                            ply:SetNWString("jobCategory", jobCategory)
                            ply:SetNWString("jobTitle", jobTitle)
                            ply:SetNWString("jobRank", jobRank)

                            return true
                        end
                    end
                end
            end
        end
    end

    return false
end

function AddJobCategory(jobCategory, desc)
    for c = 1, #jobs do
        if jobs[c].title == jobCategory then
            return false
        end
    end

    table.insert(jobs, { title = jobCategory, description = desc, jobTitles = {} })
    return true
end

function AddJobTitle(jobCategory, jobTitle, abbr, desc)
    for c = 1, #jobs do
        if jobs[c].title == jobCategory then
            for t = 1, #jobs[c].jobTitles do
                if jobs[c].jobTitles[t].title == title then
                    return false
                end
            end

            table.insert(jobs[c].jobTitles, { title = jobTitle, abbreviation = abbr, description = desc, jobRanks = {} })
            return true
        end
    end

    return false
end

function AddJobRank(jobCategory, jobTitle, jobRank)
    for c = 1, #jobs do
        if jobs[c].title == jobCategory then
            for t = 1, #jobs[c].jobTitles do
                if jobs[c].jobTitles[t].title == jobTitle then
                    for r = 1, #jobs[c].jobTitles[t].jobRanks do
                        if jobs[c].jobTitles[t].jobRanks[r].title == jobRank.title then
                            return false
                        end
                    end

                    table.insert(jobs[c].jobTitles[t].jobRanks, jobRank)

                    return true
                end
            end
        end
    end

    return false
end

function GetJobCategories()
    local categories = {}

    for c = 1, #jobs do
        table.insert(categories, jobs[c].title)
    end

    return categories
end

function GetJobTitles(jobCategory)
    local titles = {}

    for c = 1, #jobs do
        for t = 1, #jobs[c].jobTitles do
            table.insert(titles, jobs[c].jobTitles[t].tite)
        end
    end

    return titles
end

function GetJobRank(jobCategory, jobTitle, jobRank)
    for c = 1, #jobs do
        if jobs[c].title == jobCategory then
            for t = 1, #jobs[c].jobTitles do
                if jobs[c].jobTitles[t].title == title then
                    for r = 1, #jobs[c].jobTitles[t].jobRanks do
                        return FindRank(rank, jobs[c].jobTitles[t].jobRanks[r])
                    end
                end
            end
        end
    end

    return nil
end

function GetJobsTable()
    return jobs
end