
// heatsets
// see https://cnckitchen.store/products/made-for-voron-gewindeeinsatz-threaded-insert-m3x5x4-100-stk-pcs
m3_heatset_diameter = 4.4;
m3_heatset_depth = 7;
m3_heatset_wall_thickness = 2;

m2dot5_heatset_diameter = 3.6;
m2dot5_heatset_depth = 4;
m2dot5_heatset_wall_thickness = 1.6;

// screws
m2dot5_screw_diameter = 2.75;


module four_corner_array(length, width)
{
    for(coordinates = [[-width,-length], [width,-length], [width,length], [-width,length]])
    {
        translate([coordinates[0], coordinates[1], 0])
            children();
    }
}

module m2dot5_heatset()
{
    cylinder(h=m2dot5_heatset_depth, d=m2dot5_heatset_diameter);
}