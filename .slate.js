/*global S:false*/

// Monitors
var monDesk = "1920x1200";
var monLap = "1680x1050";

var topLeft = S.op("move", {
    "screen": monLap,
    "x": "100-screenSizeX",
    "y": "screenOriginY+3",
    "width": 350,
    "height": 475
});
var topRight = S.op("move", {
    "x": "600-screenSizeX",
    "y": "screenOriginY+3",
    "width": 1080,
    "height": 650,
    "screen": monLap
});
var bottomLeft = S.op("move", {
    "x": "0-screenSizeX",
    "y": "screenOriginY+500",
    "width": 980,
    "height": 520,
    "screen": monLap
});
var bottomRight = S.op("move", {
    "x": "975-screenSizeX",
    "y": "screenOriginY+620",
    "width": 700,
    "height": 400,
    "screen": monLap
});
var topLeftTall = topLeft.dup({
    "height": 850
});
var hideExtras = S.op("hide", {
    "app": ["Mail", "Calendar", "Microsoft Communicator", "Messages"]
});
var showExtras = S.op("show", {
    "app": ["Mail", "Calendar", "Microsoft Communicator", "Messages"]
});
var deskLayout = S.lay("desk", {
    "_before_": { "operations": showExtras },
    "Microsoft Communicator": {
        "operations": [topLeft],
        "main-first": true
    },
    "Mail": {
        "operations": [topRight],
        "main-first": true
    },
    "Calendar": {
        "operations": [bottomLeft],
        "main-first": true
    },
    "Messages": {
        "operations": [bottomRight],
        "main-first": true
    },
    "Twitter": {
        "operations": [topLeftTall]
    }
});
var singleLayout = S.lay("single", {
    "_before_": { "operations": hideExtras }
});

/*
var grid = S.op("grid", {
    "grids": {
        "1680x1050": {
            "width": 16,
            "height": 9
        },
        "1920x1200": {
            "width": 16,
            "height": 9
        }
    }
});
*/

S.bnd("j:ctrl", S.op("relaunch"));

S.bnd("l:ctrl", S.op("layout", { "name": deskLayout }));
S.bnd("k:ctrl", hideExtras);
S.def([monLap,monDesk], deskLayout);
S.def(1, singleLayout);

