
// heatsets
// see https://cnckitchen.store/products/made-for-voron-gewindeeinsatz-threaded-insert-m3x5x4-100-stk-pcs
m3_heatset_diameter = 4.4;
m3_heatset_depth = 7;
m3_heatset_wall_thickness = 2;

m2dot5_heatset_diameter = 3.6;
m2dot5_heatset_depth = 4;
m2dot5_heatset_wall_thickness = 1.6;
m2dot5_heatset_mount_min_diameter = m2dot5_heatset_diameter + 2*m2dot5_heatset_wall_thickness;

// screws
m2dot5_screw_diameter = 2.75;
m2dot5_shcs_head_diameter = 4.8;
m2dot5_shcs_head_depth = 2.5;

m2_screw_diameter = 2.4;
m2_shcs_head_diameter = 3.8;
m2_shcs_head_depth = 2.0;

// magnets
m6_magnet_diameter = 6;
m6_magnet_thickness = 3;

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
    // this still somehow has a bug (now when the angle=360, there is 1 fewer instance)
    increment = angle/(count);
    for(theta = [0:increment:angle-.001])  // .001 is to avoid a duplicate at the top
    {
        translate([-radius*sin(theta), radius*cos(theta), 0])
            rotate([0, 0, theta])
                children();
    }
}

module rectangle_array(x_count, y_count, x_length=0, y_length=0, x_spacing=0, y_spacing=0)
{
    if(x_length>0)
    {
        x_spacing = x_length/(x_count);
    }
    if(y_length>0)
    {
        y_spacing = y_length/(y_count);
    }
    
    for(x=[0:x_spacing:x_spacing*(x_count)])
    {
        for(y=[0:y_spacing:y_spacing*(y_count)])
        {
            translate([x, y, 0])
            {
                children();
            }
        }
    }
}

module mirror_copy(vector)
{
    children();
    mirror(vector)
        children();
}

module rounded_rectangle(width, length, corner_radius)
{
    hull()
    {
        four_corner_array(width/2-corner_radius,length/2-corner_radius)
        {
            circle(r=corner_radius);
        }
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

module m6_magnet()
{
    cylinder(d=m6_magnet_diameter, h=m6_magnet_thickness);
}