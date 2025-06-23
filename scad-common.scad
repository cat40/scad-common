
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

function bool_to_int(bool) = bool ? 1 : 0;

module four_corner_array(length, width, do_mirror=false)
{
    for(coordinates = [[-width,-length], [width,-length], [width,length], [-width,length]])
    {
        translate([coordinates[0], coordinates[1], 0])
            if (do_mirror)
            {
                mirror([bool_to_int(sign(coordinates[0])>0), bool_to_int(sign(coordinates[1])>0), 0])
                    children();
            }
            else
            {
                children();
            }
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

module right_triangle(width, height)
{
    polygon(points=[[width, 0], [0, 0], [0, height]]);
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

module m2dot5_heatset_mount(length, hole_depth=0, cutoff_angle=0)
{
//    length = length-tan(cutoff_angle)*m2dot5_heatset_mount_min_diameter;
    difference()
    {
        cylinder(d=m2dot5_heatset_mount_min_diameter, h=length);
        translate([0, 0, length-m2dot5_heatset_depth])
            m2dot5_heatset();
        translate([0, 0, length-m2dot5_heatset_depth-hole_depth])
            cylinder(h=hole_depth, d=m2dot5_screw_diameter);
//        translate([0, 0, -length/2+(tan(cutoff_angle)*m2dot5_heatset_mount_min_diameter)/2])
//        translate([-(length*sqrt(2)/2-m2dot5_heatset_mount_min_diameter/2), 0, 0])
//        cutter_size = m2dot5_heatset_mount_min_diameter/cos(cutoff_angle);
//        hypotonus = cutter_size/2 * sqrt(2);
//        z_translate = -0*hypotonus*sin(cutoff_angle)/2;
//        x_translate = (m2dot5_heatset_mount_min_diameter/2)*tan(cutoff_angle);
//                translate([x_translate, 0, z_translate])
//                    rotate([0, -cutoff_angle, 0])
//                    #cube(cutter_size, center=true);
        if (cutoff_angle > 0 && cutoff_angle < 90)
        {
            translate([-m2dot5_heatset_mount_min_diameter/2, m2dot5_heatset_mount_min_diameter/2, 0])
                rotate([90, 0, 0])
                    #linear_extrude(m2dot5_heatset_mount_min_diameter)
                        right_triangle(m2dot5_heatset_mount_min_diameter, m2dot5_heatset_mount_min_diameter/tan(cutoff_angle));
        }
    }
}

module m6_magnet()
{
    cylinder(d=m6_magnet_diameter, h=m6_magnet_thickness);
}