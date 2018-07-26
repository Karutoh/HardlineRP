if !HRP.defaultJobs then return false end

HRP.AddJobCategory("Police Department",
    "The police department is responsible for taking care of crime and providing justice to society."
)

HRP.AddJobTitle("Police Department", "Police Officer", "PO",
    "The police officer is responsible for enforcing the law onto it's citizens."
)

HRP.AddJobTitle("Police Department", "SWAT", "SWAT",
    "Highly trained paramilitary units that tackle situations beyond the capability of conventional police forces."
)

local trooper = HRP.JobRank("Trooper")
trooper.description = "Still a recruit but less limited."
trooper.dailySalary = 300
trooper.loadout = {
    "handcuffs",
    "ticketer",
    "pistol",
    "tazer"
}

local cadet = HRP.JobRank("Cadet")
cadet.description = "A recruit."
cadet.dailySalary = 250
cadet.loadout = {
    "ticketer",
    "tazer"
}
cadet.promotions = {
    trooper
}

HRP.AddJobRank("Police Department", "Police Officer", cadet)
HRP.AddJobRank("Police Department", "SWAT", cadet)

--------------------------------------------------------------------------------------------------------------------------------------------------------

HRP.AddJobCategory("Miscellaneous",
    "Random jobs that do not fit anywhere else!"
)

HRP.AddJobTitle("Miscellaneous", "Admin On Duty", "AOD",
    "Admin on duty. Player is not allowed to roleplay in this role!"
)

local emptyRank = HRP.JobRank("Empty")
emptyRank.description = "Empty Rank"
emptyRank.dailySalary = 0
emptyRank.loadout = {}

HRP.AddJobRank("Miscellaneous", "Admin On Duty", emptyRank)