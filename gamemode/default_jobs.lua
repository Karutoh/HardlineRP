defaultJobs = CreateConVar("hrp_defaultjobs", 1, FCVAR_ARCHIVE)

if !defaultJobs then return false end

AddJobCategory("Police Department",
    "The police department is responsible for taking care of crime and providing justice to society."
)

AddJobTitle("Police Department", "Police Officer", "PO",
    "The police officer is responsible for enforcing the law onto it's citizens."
)

AddJobTitle("Police Department", "SWAT", "SWAT",
    "Highly trained paramilitary units that tackle situations beyond the capability of conventional police forces."
)

local trooper = JobRank("Trooper")
trooper.description = "Still a recruit but less limited."
trooper.dailySalary = 300
trooper.loadout = {
    "handcuffs",
    "ticketer",
    "pistol",
    "tazer"
}

local cadet = JobRank("Cadet")
cadet.description = "A recruit."
cadet.dailySalary = 250
cadet.loadout = {
    "ticketer",
    "tazer"
}
cadet.promotions = {
    trooper
}

AddJobRank("Police Department", "Police Officer", cadet)
AddJobRank("Police Department", "SWAT", cadet)

--------------------------------------------------------------------------------------------------------------------------------------------------------

AddJobCategory("Miscellaneous",
    "Random jobs that do not fit anywhere else!"
)

AddJobTitle("Miscellaneous", "Admin On Duty", "AOD",
    "Admin on duty. Player is not allowed to roleplay in this role!"
)

local emptyRank = JobRank("Empty")
emptyRank.description = "Empty Rank"
emptyRank.dailySalary = 0
emptyRank.loadout = {}

AddJobRank("Miscellaneous", "Admin On Duty", emptyRank)