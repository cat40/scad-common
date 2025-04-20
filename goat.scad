module goat_logo(goat_width, goat_depth)
{
    goat_aspect_ratio = 75.451/61.953;
    translate([-goat_width/2, -(goat_width/goat_aspect_ratio)/2, 0])
        linear_extrude(goat_depth)
            resize([goat_width, 0, 0], auto=true)
                import("goat.dxf");
}