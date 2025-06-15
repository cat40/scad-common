include <scad-common.scad>

// a bunch of stuff useful for making enclosures for Adafruit Feathers

// see https://learn.adafruit.com/adafruit-feather/feather-specification
feather_length = 2*25.4;
feather_width = 0.9*25.4;
feather_hole_diameter = 0.1*25.4;
feather_hole_distance_from_center_length = 1.8*25.4/2;
feather_hole_distance_from_center_width = 0.7*25.4/2;
feather_standoff_radius = m2dot5_heatset_diameter/2 + m2dot5_heatset_wall_thickness;
feather_standoff_default_height = m2dot5_heatset_depth*1.5;

// usb is center-left
// USB height are relative to the *bottom* of the host feather PCB
feather_usb_connector_height = 1.5;
feather_usb_connector_thickness = 2.75;
feather_usb_connector_width = 6.6 + 0.8;
feather_usb_connector_offset = 10;

// 2200mAh lion battery
2200_battery_radius = 18/2;
2200_battery_length = 69;

// ring of 12 neopixels
12_pixel_ring_inner_diameter = 23.5;
12_pixel_ring_outer_diameter = 37.5+0.5;
12_pixel_ring_crosssection = (12_pixel_ring_outer_diameter-12_pixel_ring_inner_diameter)/2;
12_pixel_ring_thickness = 4.5;
12_pixel_ring_pcb_thickness = 2.75;

// slide potentiometer
45mm_slide_pot_length = 45.5;
45mm_slide_pot_width = 10;
45mm_slide_pot_hole_spacing = 41 + 0.5;
45mm_slide_pot_hole_size = m2_screw_diameter;
45mm_slide_pot_travel = 30;
45mm_slide_pot_slider_length = 5;
45mm_slide_pot_slider_width = 2.4;
45mm_slide_pot_slot_length = 45mm_slide_pot_travel + 45mm_slide_pot_slider_length;
45mm_max_mount_thickness = 4.5;

// matrix keypad
3x4_keypad_width = 46;
3x4_keypad_length = 57;
3x4_keypad_radius = 3.5;
3x4_keypad_hole_radius = 2/2;
3x4_keypad_clearance_length = 69;
3x4_keypad_clearance_width = 51;
3x4_keypad_clearance_depth = 3.1;
3x4_keypad_protrusion = 3.3;
3x4_keypad_clearance_offset = 3.5;

module feather_standoffs(length=feather_standoff_default_height)
{
    four_corner_array(feather_hole_distance_from_center_length, feather_hole_distance_from_center_width)
            feather_standoff(length);
}

module feather_standoff(length)
{
    difference()
    {
        cylinder(r=feather_standoff_radius, h=length);
        cylinder(h=length, d=m2dot5_screw_diameter);
        translate([0, 0, length-m2dot5_heatset_depth])
            cylinder(h=m2dot5_heatset_depth, d=m2dot5_heatset_diameter);
    }
}


module usb_connector_negative(length, fudge=0.1, extrude=0.1)
{
    hull()
    {
        linear_extrude(0.1)
            usb_connector_outline(offset=0);
        translate([0, 0, length+fudge])
            linear_extrude(0.1)
                usb_connector_outline(offset=feather_usb_connector_offset);
    }
}

module usb_connector_outline(offset=0)
{
    hull()
    {
        x_translate = feather_usb_connector_width/2 - (feather_usb_connector_thickness)/2 + offset/2;
        translate([-x_translate, 0, 0])
            circle(d=feather_usb_connector_thickness+offset);   
        translate([x_translate, 0, 0])
            circle(d=feather_usb_connector_thickness+offset);
    }
}
module 12_pixel_ring(h=12_pixel_ring_thickness)
{
    difference()
    {
        cylinder(h=h, d=12_pixel_ring_outer_diameter);
        cylinder(h=h, d=12_pixel_ring_inner_diameter);
    }
}

module 45mm_slide_pot_mount(screw_length=45mm_max_mount_thickness)
{
    translate([0, 45mm_slide_pot_hole_spacing/2, 0])
    {
        cylinder(h=screw_length, d=m2_screw_diameter);
        translate([0, 0, screw_length-m2_shcs_head_depth])
            cylinder(h=m2_shcs_head_depth, d=m2_shcs_head_diameter);
    }
    translate([0, -45mm_slide_pot_hole_spacing/2, 0])
    {
        cylinder(h=screw_length, d=m2_screw_diameter);
        translate([0, 0, screw_length-m2_shcs_head_depth])
            cylinder(h=m2_shcs_head_depth, d=m2_shcs_head_diameter);
    }
    translate([-45mm_slide_pot_slider_width/2, -45mm_slide_pot_slot_length/2, 0])
        cube([45mm_slide_pot_slider_width, 45mm_slide_pot_slot_length, screw_length]);
}

module 3x4_keypad(clearance_depth=3x4_keypad_clearance_depth)
{
    linear_extrude(3x4_keypad_protrusion)
        rounded_rectangle(3x4_keypad_width, 3x4_keypad_length, 3x4_keypad_radius);
    translate([-3x4_keypad_clearance_offset, 0, -3x4_keypad_protrusion])
    linear_extrude(clearance_depth)
        square([3x4_keypad_clearance_length, 3x4_keypad_clearance_width], center=true);
}