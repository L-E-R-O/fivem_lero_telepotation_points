Config = {}

-- Marker-Typen
Config.MarkerTypeVerticalCylinder = 1
Config.MarkerTypeCarSymbol = 36

Config.TeleportPoints = {
    -- Casino Garage Standard 
    {
        name = "Casino Garage Eingang",                            -- Name des Teleportationspunktes (für Debugging/Logs)
        from = vector3(934.430786, -1.674724, 77.5),        -- Koordinaten WO der Marker erscheinen soll (Startpunkt)
        to = vector3(1341.705444, 183.454940, -49.2),        -- Koordinaten WOHIN teleportiert wird (Zielpunkt)
        heading = 270.0,                                     -- Blickrichtung/Fahrzeugausrichtung nach Teleport (0-360 Grad)
        markerSize = {x = 1.5, y = 1.5, z = 1.0},   -- Größe des Markers (Breite, Tiefe, Höhe)
        markerColor = {r = 255, g = 0, b = 255, a = 100}, -- Farbe des Markers (Rot, Grün, Blau, Transparenz 0-255)
        drawDistance = 50.0,                        -- Distanz in Metern, ab der der Marker sichtbar wird
        interactDistance = 7,                     -- Distanz in Metern, ab der man teleportieren kann (E-Taste)
        twoWay = false,                              -- true = automatischer Rückweg wird erstellt, false = nur Einweg
        ipls = {"vw_casino_carpark", "vw_casino_garage"}  -- BEIDE IPLs benötigt!
    },

    {
        name = "Casino Garage Ausgang",                            -- Name des Teleportationspunktes (für Debugging/Logs)
        from = vector3(1341.758300, 190.945054, -49.2),        -- Koordinaten WO der Marker erscheinen soll (Startpunkt)
        to = vector3(934.430786, -1.674724, 77.5),        -- Koordinaten WOHIN teleportiert wird (Zielpunkt)
        heading =  144.5,                                     -- Blickrichtung/Fahrzeugausrichtung nach Teleport (0-360 Grad)
        markerSize = {x = 1.5, y = 1.5, z = 1.0},   -- Größe des Markers (Breite, Tiefe, Höhe)
        markerColor = {r = 255, g = 0, b = 255, a = 100}, -- Farbe des Markers (Rot, Grün, Blau, Transparenz 0-255)
        drawDistance = 50.0,                        -- Distanz in Metern, ab der der Marker sichtbar wird
        interactDistance = 7,                     -- Distanz in Metern, ab der man teleportieren kann (E-Taste)
        twoWay = false,                              -- true = automatischer Rückweg wird erstellt, false = nur Einweg
        ipls = {"vw_casino_carpark", "vw_casino_garage"}  -- Auch beim Ausgang laden für Sicherheit
    },

    -- Casino Garage VIP
    {
        name = "Casino Garage VIP Eingang",                            -- Name des Teleportationspunktes (für Debugging/Logs)
        from = vector3(1408.285766, 183.745056, -50.5),        -- Koordinaten WO der Marker erscheinen soll (Startpunkt)
        to = vector3(1256.597778, 222.804398, -48.060792),        -- Koordinaten WOHIN teleportiert wird (Zielpunkt)
        heading =   272.1,                                     -- Blickrichtung/Fahrzeugausrichtung nach Teleport (0-360 Grad)
        markerSize = {x = 1.5, y = 1.5, z = 1.0},   -- Größe des Markers (Breite, Tiefe, Höhe)
        markerColor = {r = 255, g = 0, b = 255, a = 100}, -- Farbe des Markers (Rot, Grün, Blau, Transparenz 0-255)
        drawDistance = 50.0,                        -- Distanz in Metern, ab der der Marker sichtbar wird
        interactDistance = 7,                     -- Distanz in Metern, ab der man teleportieren kann (E-Taste)
        twoWay = false,                              -- true = automatischer Rückweg wird erstellt, false = nur Einweg
        ipls = {"vw_casino_carpark", "vw_casino_garage"}  -- Beide laden
    },

    {
        name = "Casino Garage VIP Ausgang",                            -- Name des Teleportationspunktes (für Debugging/Logs)
        from = vector3(1256.795654, 230.162644, -49),        -- Koordinaten WO der Marker erscheinen soll (Startpunkt)
        to = vector3(1400.729614, 190.800004, -49.004394),        -- Koordinaten WOHIN teleportiert wird (Zielpunkt)
        heading =    93.5,                                     -- Blickrichtung/Fahrzeugausrichtung nach Teleport (0-360 Grad)
        markerSize = {x = 1.5, y = 1.5, z = 1.0},   -- Größe des Markers (Breite, Tiefe, Höhe)
        markerColor = {r = 255, g = 0, b = 255, a = 100}, -- Farbe des Markers (Rot, Grün, Blau, Transparenz 0-255)
        drawDistance = 50.0,                        -- Distanz in Metern, ab der der Marker sichtbar wird
        interactDistance = 7,                     -- Distanz in Metern, ab der man teleportieren kann (E-Taste)
        twoWay = false,                              -- true = automatischer Rückweg wird erstellt, false = nur Einweg
        ipls = {"vw_casino_carpark", "vw_casino_garage"}
    },

    {
        name = "Casino Loading Bay Eingang",                            -- Name des Teleportationspunktes (für Debugging/Logs)
        from = vector3(1000.509888, -55.226372, 74),        -- Koordinaten WO der Marker erscheinen soll (Startpunkt)
        to = vector3(2642.162598, -332.690124, -66),        -- Koordinaten WOHIN teleportiert wird (Zielpunkt)
        heading = 48.188972,                                     -- Blickrichtung/Fahrzeugausrichtung nach Teleport (0-360 Grad)
        markerSize = {x = 1.5, y = 1.5, z = 1.0},   -- Größe des Markers (Breite, Tiefe, Höhe)
        markerColor = {r = 255, g = 0, b = 255, a = 100}, -- Farbe des Markers (Rot, Grün, Blau, Transparenz 0-255)
        drawDistance = 50.0,                        -- Distanz in Metern, ab der der Marker sichtbar wird
        interactDistance = 7,                     -- Distanz in Metern, ab der man teleportieren kann (E-Taste)
        twoWay = false,                              -- true = automatischer Rückweg wird erstellt, false = nur Einweg
        ipls = {"vw_casino_garage"},
        allowedJobs = {"casino"} -- Nur Casino-Job erlaubt
    },

    {
        name = "Casino Loading Bay Ausgang",                            -- Name des Teleportationspunktes (für Debugging/Logs)
        from = vector3(2642.162598, -332.690124, -66),        -- Koordinaten WO der Marker erscheinen soll (Startpunkt)
        to = vector3(1000.707702, -56.175824, 74),        -- Koordinaten WOHIN teleportiert wird (Zielpunkt)
        heading =  116.220474,                                     -- Westen
        markerSize = {x = 1.5, y = 1.5, z = 1.0},   -- Größe des Markers (Breite, Tiefe, Höhe)
        markerColor = {r = 255, g = 0, b = 255, a = 100}, -- Farbe des Markers (Rot, Grün, Blau, Transparenz 0-255)
        drawDistance = 50.0,                        -- Distanz in Metern, ab der der Marker sichtbar wird
        interactDistance = 7,                     -- Distanz in Metern, ab der man teleportieren kann (E-Taste)
        twoWay = false,                              -- true = automatischer Rückweg wird erstellt, false = nur Einweg
        ipls = {"vw_casino_garage"},
    },

    {
        name = "Casino Music Locker",
        from = vector3(987.995606, 80.400002, 79.975098),
        to = vector3(1578.065918, 253.476928, -47.005126),
        -- alternate club: -1604.664 -3012.583 -78.000
        heading =  116.220474,
        markerSize = {x = 1.5, y = 1.5, z = 1.0},
        markerColor = {r = 255, g = 0, b = 255, a = 100},
        drawDistance = 50.0,
        interactDistance = 2,
        twoWay = true,
        ipls = {},
        allowedJobs = {"casino"}
    },

    {
        name = "Casino Penthouse",
        from = vector3(968.057128, 63.507690, 111.2),
        to = vector3(970.588990, 63.112088, 111.2),
        heading =  240.0,
        markerSize = {x = 1.5, y = 1.5, z = 1.0},
        markerColor = {r = 255, g = 0, b = 255, a = 100},
        drawDistance = 50.0,
        interactDistance = 2,
        twoWay = true,
        ipls = {},
        allowedJobs = {"casino"}
    },
}

-- Tastenbelegung
Config.InteractKey = 38 -- E-Taste
