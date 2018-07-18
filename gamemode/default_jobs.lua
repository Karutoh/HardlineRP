if !TRP.defaultJobs then return false end

TRP.AddJobCategory("Police Department",
    "The police department is responsible for taking care of crime and providing justice to society."
)

TRP.AddJobTitle("Police Department", "Police Officer", "PO",
    "The police officer is responsible for enforcing the law onto it's citizens."
)

local trooper = TRP.JobRank("Trooper")
trooper.description = "Still a recruit but less limited."
trooper.dailySalary = 300
trooper.loadout = {
    "handcuffs",
    "ticketer",
    "pistol",
    "tazer"
}

local cadet = TRP.JobRank("Cadet")
cadet.description = "A recruit."
cadet.dailySalary = 250
cadet.loadout = {
    "ticketer",
    "tazer"
}
cadet.promotions = {
    trooper
}

TRP.AddJobRank("Police Department", "Police Officer", cadet)