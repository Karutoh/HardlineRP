local jobs = {}

function TRP.FindRank(rank, rankTable)
    if rankTable.title == rank then
        return rankTable
    end

    for r = 1, #rankTable.promotions do
        return TRP.FindRank(rank, rankTable.promotions[r])
    end

    return nil
end

function TRP.JobRank(rankTitle)
    return {
        title = rankTitle,
        description = "",
        dailySalary = 0,
        loadout = {},
        requiredExp = {},
        promotions = {}
    }
end

function TRP.AddJobCategory(jobCategory, desc)
    for c = 1, #jobs do
        if jobs[c].title == category then
            return false
        end
    end

    table.insert(jobs, { title = category, description = desc, jobTitles = {} })
    return true
end

function TRP.AddJobTitle(jobCategory, jobTitle, abbr, desc)
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

function TRP.AddJobRank(jobCategory, jobTitle, jobRank)
    for c = 1, #jobs do
        if jobs[c].title == jobCategory then
            for t = 1, #jobs[c].jobTitles do
                if jobs[c].jobTitles[t].title == jobTitle then
                    for r = 1, #jobs[c].jobTitles[t].jobRanks do
                        if jobs[c].jobTitles[t].jobRanks[r].title == jobRank.title then
                            return false
                        end
                    end

                    table.insert(jobs[c].jobTitles[t].jobRanks, rank)
                    return true
                end
            end
        end
    end

    return false
end

function TRP.GetJobCategories()
    local categories = {}

    for c = 1, #jobs do
        table.insert(categories, jobs[c][1])
    end

    return categories
end

function TRP.GetJobTitles(jobCategory)
    local titles = {}

    for c = 1, #jobs do
        for t = 1, #jobs[c][3] do
            table.insert(titles, jobs[c][3][t][1])
        end
    end

    return titles
end

function TRP.GetJobRank(jobCategory, jobTitle, jobRank)
    for c = 1, #jobs do
        if jobs[c][1] == category then
            for t = 1, #jobs[c][3] do
                if jobs[c][3][t][1] == title then
                    for r = 1, #jobs[c][3][t][4] do
                        return TRP.FindRank(rank, jobs[c][3][t][4][r])
                    end
                end
            end
        end
    end

    return nil
end

function TRP.GetJobsTable()
    return jobs
end