/*
AAF forces have taken over a medical and chemical factory and have begun manufacturing what we suspect may be chemical or biological weapons. Your tasking is as follows:

1. Infiltrate the factory compound.
2. Find and destroy any device or devices AAF may be working on.
3. Send a strong message to AAF: Do not involve medical facilities in the conflict. Eliminate AAF troops with extreme prejudice.
4. Exfiltrate to LZ Houseplant for heli pickup.
*/

// Create briefing entries:

briefing = player createDiaryRecord ["diary",["Briefing","AAF forces have taken over a medical and chemical factory and have begun manufacturing what we suspect may be chemical or biological weapons. <br/><br/>Your tasking is as follows: <br/><br/>1. Infiltrate the factory compound.<br/>2. Find and destroy any device or devices AAF may be working on.<br/>3. Send a strong message to AAF: Do not involve medical facilities in the conflict. Eliminate AAF troops with extreme prejudice.<br/>4. Exfiltrate to LZ Houseplant for heli pickup.<br/><br/>Note: Avoid Topolia, as we have reports of a 30+ man force there and we do not need to engage them."]];

sleep 5;

// once all opFor in the area are dead, we will flip this to "false"
opForAlive = "true";

/*
BIS_fnc_taskCreate Usage

0: BOOL or OBJECT or GROUP or SIDE or ARRAY - Task owner(s)
1: STRING or ARRAY - Task name or array in the format [task name, parent task name]
2: ARRAY or STRING - Task texts in the format ["description", "title", "marker"] or CfgTaskDescriptions class
3: OBJECT or ARRAY or STRING - Task destination (use [object,true] to always show marker on the object, even if player doesn't 'knowsAbout' it)
4: BOOL or NUMBER or STRING - Task state (or true to set as current)
5: NUMBER - Task priority (when automatically selecting a new current task, higher priority is selected first)
6: BOOL - Show notification (default: true)
7: STRING - Task type as defined in the CfgTaskTypes
8: BOOL - Task always visible in 3D (default: false)
*/

// Advance to point ALPHA
[
	west, // 0: BOOL or OBJECT or GROUP or SIDE or ARRAY - Task owner(s)
	["task_a"], // STRING or ARRAY - Task name or array in the format [task name, parent task name]
	[
		"Advance to point Alpha",
		"ADVANCE TO POINT ALPHA",
		"taskmarker_a"
	], // ARRAY or STRING - Task texts in the format ["description", "title", "marker"] or CfgTaskDescriptions class
	getMarkerPos "taskmarker_a", // OBJECT or ARRAY or STRING - Task destination (use [object,true] to always show marker on the object, even if player doesn't 'knowsAbout' it)
	"CREATED", // BOOL or NUMBER or STRING - Task state (or true to set as current)
	20, // NUMBER - Task priority (when automatically selecting a new current task, higher priority is selected first)
	true, // BOOL - Show notification (default: true)
	"move", // STRING - Task type as defined in the CfgTaskTypes: https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul#Appendix
	false // 8: BOOL - Task always visible in 3D (default: false)
] call BIS_fnc_taskCreate;

triggerPointAlpha = {
	["task_a", "SUCCEEDED", true] call BIS_fnc_taskSetState;
	["task_b", "ASSIGNED", true] call BIS_fnc_taskSetState;
	titleText ["<t color='#ffffff' size='2'>ADVANCE TO POINT BRAVO.</t>", "PLAIN", 5, true, true];
	titleFadeOut 2;
	saveGame;
};

// Advance to point BRAVO
[
	west,
	["task_b"],
	[
		"Advance to point Bravo.",
		"ADVANCE TO POINT BRAVO",
		"taskmarker_b"
	],
	getMarkerPos "taskmarker_b",
	"CREATED",
	19, 
	false,
	"move",
	false
] call BIS_fnc_taskCreate;

triggerPointBravo = {
	["task_b", "SUCCEEDED", true] call BIS_fnc_taskSetState;
	["task_c", "ASSIGNED", true] call BIS_fnc_taskSetState;
	titleText ["<t color='#ffffff' size='2'>ELIMINATE GARRISON 1.</t>", "PLAIN", 5, true, true];
	titleFadeOut 2;
	saveGame;
};

// Assault Garrison 1
[
	west,
	["task_c"],
	[
		"Assault garrison 1.",
		"ASSAULT GARRISON 1",
		"taskmarker_c"
	],
	getMarkerPos "taskmarker_c",
	"CREATED",
	18, 
	true,
	"destroy",
	false
] call BIS_fnc_taskCreate;

triggerPointCharlie = {
	["task_c", "SUCCEEDED", true] call BIS_fnc_taskSetState;
	["task_d", "ASSIGNED", true] call BIS_fnc_taskSetState;
	titleText ["<t color='#ffffff' size='2'>ASSAULT GARRISON 2.</t>", "PLAIN", 5, true, true];
	titleFadeOut 2;
	saveGame;
};

// Assault Garrison 2
[
	west,
	["task_d"],
	[
		"Assault garrison 2.",
		"ASSAULT GARRISON 2",
		"taskmarker_d"
	],
	getMarkerPos "taskmarker_d",
	"CREATED",
	17, 
	true,
	"destroy",
	false
] call BIS_fnc_taskCreate;

triggerPointDelta = {
	["task_d", "SUCCEEDED", true] call BIS_fnc_taskSetState;
	["task001", "ASSIGNED", true] call BIS_fnc_taskSetState;
	titleText ["<t color='#ffffff' size='2'>INFILTRATE FACTORY COMPOUND</t>", "PLAIN", 5, true, true];
	titleFadeOut 2;
	saveGame;
};

// The meat and potatoes

// Infiltrate compound
[
	west,
	["task001"],
	[
		"Infiltrate Factory Compound. Beware of sentries and patrols. Dispatch if necessary.",
		"INFILTRATE COMPOUND",
		"taskmarker001"
	],
	getMarkerPos "taskmarker001",
	"CREATED",
	16,
	true,
	"move",
	false
] call BIS_fnc_taskCreate;

triggerPoint001 = {
	["task001", "SUCCEEDED", true] call BIS_fnc_taskSetState;
	["task002", "ASSIGNED", true] call BIS_fnc_taskSetState;
	titleText ["<t color='#ffffff' size='1'>INFILTRATION SUCCESSFUL</t><br/><t color='#ffffff' size='1'>DESTROY DEVICES</t>", "PLAIN", 5, true, true];
	titleFadeOut 2;
	saveGame;
};

// Destroy Device
[
	west,
	["task002"],
	[
		"Find and destroy any device or devices AAF may be working on.",
		"DESTROY DEVICE(S)",
		"taskmarker002"
	],
	getMarkerPos "taskmarker002",
	"CREATED",
	15,
	true, 
	"destroy",
	false
] call BIS_fnc_taskCreate;

triggerPoint002 = {
	["task002", "SUCCEEDED", true] call BIS_fnc_taskSetState;
	["task003", "ASSIGNED", true] call BIS_fnc_taskSetState;
	titleText ["<t color='#ffffff' size='1'>DEVICE DESTROYED</t><br/><t color='#ffffff' size='1'>ELIMINATE REMAINING AAF FORCES</t>", "PLAIN", 5, true, true];
	titleFadeOut 2;
	saveGame;
};

// Kill all AAF
[
	west,
	["task003"],
	[
		"Send a strong message to AAF: Do not involve medical facilities in the conflict. Eliminate AAF troops with extreme prejudice.",
		"ELIMINATE AAF FORCES",
		"taskmarker003"
	],
	getMarkerPos "taskmarker003",
	"CREATED",
	14,
	true, 
	"kill",
	false
] call BIS_fnc_taskCreate;

triggerPoint003 = {
	["task003", "SUCCEEDED", true] call BIS_fnc_taskSetState;
	["task004", "ASSIGNED", true] call BIS_fnc_taskSetState;
	opForAlive = "false";
	titleText ["<t color='#ffffff' size='1'>AAF FORCES DESTROYED</t><br/><t color='#ffffff' size='1'>EXFIL TO LZ HOUSEPLANT</t>", "PLAIN", 5, true, true];
	titleFadeOut 2;
	saveGame;
};

// Exfil to LZ Houseplant
[
	west,
	["task004"],
	[
		"Exfiltrate to LZ Houseplant for heli pickup.",
		"EXFILTRATE",
		"taskmarker004"
	],
	getMarkerPos "taskmarker004",
	"CREATED",
	13,
	true,
	"heli",
	false
] call BIS_fnc_taskCreate;

triggerPoint004 = {
	if (opForAlive == "false") then {
		endMission "END1";
	} else {
		[
			west,
			["task005"],
			[
				"Aircraft cannot land with enemy that close. Make your way to LZ PAPERCLIP for heli pickup.",
				"MOVE TO LZ PAPERCLIP",
				"taskmarker005"
			],
			getMarkerPos "taskmarker005",
			"CREATED",
			14,
			true, 
			"kill",
			false
		] call BIS_fnc_taskCreate;
		
		["task004", "SUCCEEDED", true] call BIS_fnc_taskSetState;
		["task003", "CANCELED", true] call BIS_fnc_taskSetState;
		["task003", "ASSIGNED", true] call BIS_fnc_taskSetState;
		
		titleText ["<t color='#ffffff' size='1'>AAF FORCES REMAIN AT FACTORY</t><br/><t color='#ffffff' size='1'>CANNOT LAND AT YOUR LOCATION</t><br/><t color='#ffffff' size='1'>PROCEED TO LZ PAPERCLIP</t>", "PLAIN", 5, true, true];
		
		titleFadeOut 2;
		
		saveGame;
	}
};


triggerPoint005 = {
		
	titleText ["<t color='#ffffff' size='1'>EXFIL INBOUND</t><br/>\
	<t color='#ffffff' size='1'>The helkicopter is on the way, ETA, 5 mikes.</t><br/>\
	<t color='#ffffff' size='1'>Good attempt soldier, prepare for debriefing, it looks like we misjudged the enemy forces in this place.</t>", "PLAIN", 5, true, true];
	
	titleFadeOut 2;
	
	endMission "END2";
	
};








// Once all the waypoints are done, show the player
titleText ["<t color='#ffffff' size='2' align='left'>1. INFILTRATE FACTORY COMPOUND<br/>2. DESTROY DEVICE<br/>3. ELIMINATE REMAINING AAF FORCES<br/>4. EXFIL TO LZ HOUSEPLANT</t>", "PLAIN", 2, true, true];
titleFadeOut 2;
