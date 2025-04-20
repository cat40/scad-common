include <scad-common.scad>

// a bunch of stuff useful for making enclosures for Adafruit Feathers

// see https://learn.adafruit.com/adafruit-feather/feather-specification
feather_length = 2*25.4;
feather_width = 0.9*25.4;
feather_hole_diameter = 0.1*25.4;
feather_hole_distance_from_center_length = 1.8*25.4/2;
feather_hole_distance_from_center_width = 0.7*25.4/2;
feather_standoff_radius = m2dot5_heatset_diameter/2 + m2dot5_heatset_wall_thickness;

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
12_pixel_ring_outer_diameter = 37.5;
12_pixel_ring_crosssection = (12_pixel_ring_outer_diameter-12_pixel_ring_inner_diameter)/2;
12_pixel_ring_thickness = 3.5;
12_pixel_ring_pcb_thickness = 2.75;



module feather_standoffs(length)
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

module 12_pixel_ring(h=12_pixel_ring_thickness)
{
    difference()
    {
        cylinder(h=h, d=12_pixel_ring_outer_diameter);
        cylinder(h=h, d=12_pixel_ring_inner_diameter);
    }
}