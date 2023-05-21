var lookUp_floor_image_path = {
    USYD: {
        J01: [
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
        J02: [
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
        J03: [
            "/images/floor_plan/USYD/J03/1-761x761.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
        J04: [
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
        J05: [
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
        J06: [
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
        F03: [
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
        F07: [
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
        F09: [
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
        F11: [
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
        F13: [
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
        F19: [
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
            "/images/floor_plan/default-983x712.png",
        ],
    },
    Stations: {
        Newtown: ["/images/floor_plan/default-983x712.png"],
        MacdonaldTown: ["/images/floor_plan/default-983x712.png"],
        Redfern: ["/images/floor_plan/default-983x712.png"],
        Central: ["/images/floor_plan/default-983x712.png"],
        Townhall: ["/images/floor_plan/default-983x712.png"],
        Wynyard: ["/images/floor_plan/default-983x712.png"],
    },
};

// fill up all blank floor plan paths
for (const [key, value] of Object.entries(lookUp_floor_image_path)) {
    for (const [key_value, value_value] of Object.entries(value)) {
        if (value_value[0] === "") {
            lookUp_floor_image_path[key][key_value][0] = "/images/floor_plan/default-983x712.png";
        }
    }
}
