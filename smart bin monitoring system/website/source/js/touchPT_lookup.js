const circle_r = 5;
const default_coords = [
    { lat: 77.78174593052022, lng: 48.08326112068523 },
    { lat: 57.27564927611034, lng: 95.4594154601839 },
    { lat: 102.53048327204938, lng: 135.05739520663056 },
    { lat: 7.071067811865475, lng: 156.270598642227 },
    { lat: 61.51828996322963, lng: 176.06958851545033 },
];

var lookUp_floor_image_coords = {
    USYD: {
        J01: [default_coords, default_coords, default_coords],
        J02: [default_coords, default_coords, default_coords],
        J03: [
            [
                { lat: 40.5, lng: 117 },
                { lat: 41.5, lng: 25 },
                { lat: 92, lng: 38.5 },
                { lat: 94.5, lng: 106 },
                { lat: 10.5, lng: 134 },
            ],
            default_coords,
            default_coords,
            default_coords,
            default_coords,
        ],
        J04: [default_coords, default_coords, default_coords],
        J05: [default_coords, default_coords, default_coords],
        J06: [default_coords, default_coords, default_coords],

        F03: [default_coords, default_coords, default_coords],
        F07: [default_coords, default_coords, default_coords],
        F09: [default_coords, default_coords, default_coords],
        F11: [default_coords, default_coords, default_coords],
        F13: [default_coords, default_coords, default_coords],
        F19: [default_coords, default_coords, default_coords],
    },
    Stations: {
        Central: [default_coords],
        Townhall: [default_coords],
        Wynyard: [default_coords],
        Newtown: [default_coords],
        MacdonaldTown: [default_coords],
        Redfern: [default_coords],
    },
};

// fill up all blank floor plan touch points
for (const [key, value] of Object.entries(lookUp_floor_image_coords)) {
    for (const [key_value, value_value] of Object.entries(value)) {
        if (value_value[0] === "") {
            lookUp_floor_image_coords[key][key_value][0] = default_coords;
        }
    }
}

{
    /* default
<map name="image-map">
    <area target="" alt="" title="" href="" coords="248,331,22" shape="circle">
    <area target="" alt="" title="" href="" coords="460,427,22" shape="circle">
    <area target="" alt="" title="" href="" coords="735,678,22" shape="circle">
    <area target="" alt="" title="" href="" coords="576,206,22" shape="circle">
    <area target="" alt="" title="" href="" coords="941,143,22" shape="circle">
</map> */
}

{
    /* <map name="EEbuilding.drawio(1).png" id="EEbuilding.drawio(1).png">
  <area shape="circle" coords="58,540,20" nohref alt="" />
  <area shape="circle" coords="357,565,20" nohref alt="" />
  <area shape="circle" coords="585,566,20" nohref alt="" />
  <area shape="circle" coords="178,306,20" nohref alt="" />
  <area shape="circle" coords="484,295,20" nohref alt="" />
</map>; */
}
