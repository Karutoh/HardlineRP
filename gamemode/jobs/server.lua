local jobs = {}

local function TRP.FindRank(rank, rankTable)
    if rankTable[1] == rank then
        return rankTable
    end

    for r = 1, #rankTable[5] do
        return TRP.FindRank(rank, rankTable[5][r])
    end

    return nil
end

function TRP.AddJobCategory(category, desc)
    table.insert(jobs, { category, desc, {} })
end

function TRP.AddJobTitle(category, title, abbreviation, desc)
    for i = 1, #jobs do
        if jobs[i][1] == category then
            for t = 1, #jobs[i][3] do
                if jobs[i][3][t][1] == title then
                    return false
                end
            end

            table.insert(jobs[i][3], { title, abbreviation, desc, {} })
            return true
        end
    end

    return false
end

function TRP.AddRank(category, title, rank)
    for c = 1, #jobs do
        if jobs[i][1] == category then
            for t = 1, #jobs[i][3] do
                if jobs[i][3][t][1] == title then
                    for r = 1, #jobs[i][3][t][4] do
                        if jobs[i][3][t][4][r][1] == rank[1] then
                            return false
                        end
                    end

                    table.insert(jobs[i][3][t][4], rank)
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

function TRP.GetJobTitles(category)
    local titles = {}

    for c = 1, #jobs do
        for t = 1, #jobs[c][3] do
            table.insert(titles, jobs[c][3][t][1])
        end
    end

    return titles
end

function TRP.GetRank(category, title, rank)
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