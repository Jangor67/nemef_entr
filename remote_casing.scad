// nemef entr remotecase

////////////// parameters (meet jouw afstandsbediening) //////////////
D1 = 62;     // diameter knop (mm)
D2 = 42;     // diameter onderkant
L = 124;      // totale lengte  
H = 15;      // hoogte elektronische module (mm)
wall = 2.0;  // wanddikte (mm)

////////////// afgeleide maten //////////////
wall2 = wall * 2;
R1=D1/2;
R2=D2/2;
sphere_distance = L-R1-R2;

//// SETTINGS /////

$fn=60; 
 
////////////// modules //////////////

module behuizing() {
  scale([1,1,H/R1]) {
    difference() {
      sphere(d=D1);
      // remove inside
      sphere(d=D1-wall2);
      // remove top
      translate([-R1-0.1,-R1-0.1,0])
        cube([D1+0.2,D1+0.2,R1]);
      // open one side
      translate([0,-D1,0]) scale([D2/D1,D2/D1,1]) hull() {
        sphere(d=D1-wall2);
        translate([0,D1*D1/D2,0])
          sphere(d=D1-wall2);
      }
    }
    translate([0,-sphere_distance,0]) scale([D2/D1,D2/D1,1]) difference() {
      hull() { 
        sphere(d=D1);
        translate([0,sphere_distance*D1/D2,0]) sphere(d=D1);
      }
      // remove inside
      hull() {
        sphere(d=D1-wall2);
        translate([0,sphere_distance*D1/D2,0]) sphere(d=D1-wall2);
      }
      // remove the part which resides in the main sphere
      scale([D1/D2,D1/D2,1]) translate([0,sphere_distance,0]) sphere(d=D1-wall2);
      // remove top
      translate([-D1/2-0.1,-D1/2-0.1,0])
        cube([D1+0.2,R1+sphere_distance*D1/D2+R2+0.2,D1/2]);
    }
  }
}

////////////// constructie (centeren voor gemak) //////////////

// Helpful: export separate pieces by uncommenting:
behuizing();
translate([D1,-L/2,-H]) rotate([0,180,180]) behuizing();
