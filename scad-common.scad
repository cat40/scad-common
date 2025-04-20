
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
m2dot5_shcs_head_diameter = 4.8;
m2dot5_shcs_head_depth = 2.5;

m2_screw_diameter = 2.4;
m2_shcs_head_diameter = 3.8;
m2_shcs_head_depth = 2.0;


module four_corner_array(length, width)
{
    for(coordinates = [[-width,-length], [width,-length], [width,length], [-width,length]])
    {
        translate([coordinates[0], coordinates[1], 0])
            children();
    }
}

module circle_array(count, radius, angle=360)
{
    increment = angle/(count-1);
    for(theta = [0:increment:angle])
    {
        translate([-radius*sin(theta), radius*cos(theta), 0])
            rotate([0, 0, theta])
                children();
    }
}

module m2dot5_heatset()
{
    cylinder(h=m2dot5_heatset_depth, d=m2dot5_heatset_diameter);
}

module m2dot5_clearance_hole(length, head=true)
{
    if(head)
    {
        cylinder(h=m2dot5_shcs_head_depth, d=m2dot5_shcs_head_diameter);
        translate([0, 0, m2dot5_shcs_head_depth])
            cylinder(h=length, d=m2dot5_screw_diameter);
    }
    else
    {
        cylinder(h=length, d=m2dot5_screw_diameter);
    }
}