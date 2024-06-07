$fn=80;
extra=0.005;

holderLen = 120;    // complete length (if shorter, bed will be hit the holder when driving down)
holderX = 10;      // length of the "wings" which goes in front of the rear frame
bcFrameThickness = 4; // wallthickness of the babycubes rear frame
wallThickness = 1;    // std wallThickness
height = 10;      //height (wallthickness will be added on top)

fanX = 20;    // cutout for fan (just simple to get airflow through it)
fanDistX = 32; //distance from 0,0

fanScrewHoleDia = 3;    // useing M3 Screws
fanScrewDist = 32;  // distance of the screws from each other

difference()
{
  cube([holderLen,bcFrameThickness+wallThickness*5,height+wallThickness]);

  translate([-extra,wallThickness*4,0])
    cube([holderLen+extra*2,bcFrameThickness,height]);
  translate([holderX,bcFrameThickness+wallThickness*4-extra,0])
    cube([holderLen-holderX*2,wallThickness+extra*2,height]);

  translate([fanDistX+fanX/2,-extra,0])
    cube([fanX,wallThickness*4+extra*2,height-wallThickness]);

  translate([fanDistX+fanX-fanScrewDist/2 ,0,0])
  {
    translate([0,-extra,height/2])
    rotate([-90,0,0])
      cylinder(r=fanScrewHoleDia/2, h=wallThickness*4+extra*2);

    translate([fanScrewDist,-extra,height/2])
    rotate([-90,0,0])
      cylinder(r=fanScrewHoleDia/2, h=wallThickness*4+extra*2);
  }
}
