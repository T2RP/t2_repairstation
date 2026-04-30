Config = {}

Config.Debug = false          -- true = show zone outlines
Config.InteractDistance = 4.5 -- distance to show E prompt

Config.RepairPrice    = 1200  -- cost of a full repair
Config.RepairDuration = 14000 -- progress bar duration (ms)

Config.RepairLocations = {
    {
        name     = 'Glass Heroes Auto Repair',
        coords   = vector3(-200.013, -1380.952, 31.258),
        size     = vector3(6.0, 6.0, 3.0),
        heading  = 70.0,
        blip = { sprite = 446, colour = 71, scale = 0.5 }
    },
    {
        name     = 'Sandy Shores Auto Repair',
        coords   = vector3(1774.973, 3333.608, 41.318),
        size     = vector3(6.0, 6.0, 3.0),
        heading  = 0.0,
        blip = { sprite = 446, colour = 71, scale = 0.5 }
    },
    {
        name     = 'Paleto Bay Auto Repair',
        coords   = vector3(110.670, 6626.182, 31.787),
        size     = vector3(5.5, 5.5, 3.0),
        heading  = 45.0,
        blip = { sprite = 446, colour = 71, scale = 0.5 }
    },
    {
        name     = 'Davis Auto Repair',
        coords   = vector3(153.50, -1675.94, 29.11),
        size     = vector3(5.5, 5.5, 3.0),
        heading  = 45.0,
        blip = { sprite = 446, colour = 71, scale = 0.5 }
    },
    {
        name     = 'Auto Exotics Auto Repair',
        coords   = vector3(540.17, -176.77, 53.86),
        size     = vector3(6.0, 6.0, 3.0),
        heading  = 0.0,
        blip = { sprite = 446, colour = 71, scale = 0.5 }
    },
    -- add more locations here
}
