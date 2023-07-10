//    radialex 3d print case
//  2023/7/7 by morecat_lab 


//$fn=100;


hipro_offset = 5; // add 5mm for hi profile, set 0 therwise
//hipro_offset = 0; // add 5mm for hi profile, set 0 therwise

switch_plate(3,scale=0.99);

module switch_plate(t, scale=1.0) {
    linear_extrude(height=t)
        difference() {
            scale([scale,scale, 1.0])
                import("radialex-switch-plate.svg", convexity=3,center=true);
            import("radialex-switch-plate-holes.svg", convexity=3,center=true);
        }
}

translate([-23.5, -29.7, -20])
    center_plate(3);

module center_plate(t, scale=1.0) {
    linear_extrude(height=t)
        difference() {
            scale([scale,scale, 1.0])
                import("radialex-center-top.svg", convexity=3,center=false);
            import("radialex-center-top-holes.svg", convexity=3,center=false);
        }
}

translate([-143, -50, 22])
    bottom_plate_wall_simple(6+4+hipro_offset);

module bottom_plate_wall_simple(t) {  //  just hole version
    difference() {  // 外形
        minkowski() {
            linear_extrude(height=t)
                import("radialex-bottom-plate-outline.svg", convexity=3);
            cylinder(h=2, r1=1.0, r2=3.5);
        }
        linear_extrude(height=t)
            import("radialex-bottom-plate-outline.svg", convexity=3);
        // cutout for arduino pro micro usb connector
        translate([133.5,91,0])
            cube([20, 5, 6 + hipro_offset]);

        translate([0, 0, -7])  // screw hole
            minkowski() {
                linear_extrude(height=10)
                    import("radialex-bottom-plate-holes.svg", convexity=3);
                cylinder(h=t, r=0.3, $fn=20);
            }
        }           
}

module bottom_plate_wall(t) {  // bottom with snandoff version
    difference() {  // 外形
        minkowski() {
            linear_extrude(height=t)
                import("radialex-bottom-plate-outline.svg", convexity=3);
            cylinder(h=2, r1=1.0, r2=3.5);
        }
        linear_extrude(height=t)
            import("radialex-bottom-plate-outline.svg", convexity=3);
        // cutout for arduino pro micro usb connector
        translate([133.5,91,0])
            cube([20, 5, 6 + hipro_offset]);

    }
    difference() {  //  standoff
        standoff_h = 2;
        translate([0, 0, 3+4+hipro_offset])
            union() {
                minkowski() {  
                   linear_extrude(height=0.01)
                        import("radialex-bottom-plate-holes.svg", convexity=3);
                        cylinder(h=standoff_h+1, r1=2.5 ,r2=3.5,$fn=20);
                }
                translate([0, 0, -3])
                minkowski() {  
                   linear_extrude(height=0.01)
                        import("radialex-bottom-plate-holes.svg", convexity=3);
                        cylinder(h=standoff_h+1, r=1, $fn=20);
                }
             }
        translate([0, 0, -7])  // screw hole
            minkowski() {
                linear_extrude(height=10)
                    import("radialex-bottom-plate-holes.svg", convexity=3);
                cylinder(h=t, r=0.7, $fn=20);
            }
    }                
}

//////////////// for test SVG files ///////////

//translate([120, 25, -10])
//    middle(3);

module middle(t) {
    linear_extrude(height=t)
        difference() {
            import("radialex-center-middle.svg", convexity=3);
            import("radialex-center-middle-holes.svg", convexity=3);
        }
}

//translate([120, 25, -15])
//    center(3);

module center(t) {
    linear_extrude(height=t)
        difference() {
            import("radialex-center-top.svg", convexity=3);
            import("radialex-center-top-holes.svg", convexity=3);
        }
}

//translate([0, 0, 10])
//    bottom(3);

module bottom(t) {
    linear_extrude(height=t)
        difference() {
            import("radialex-bottom-plate.svg", convexity=3);
            import("radialex-bottom-plate-holes.svg", convexity=3);
        }
}