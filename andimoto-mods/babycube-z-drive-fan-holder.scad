$fn=80;
extra=0.005;

holderX = 10;
zDriveXLen = 57;
bcFrameThickness = 4;
wallThickness = 1;
height = 10;

fanX = 20;

fanScrewHoleDia = 3.2;
fanScrewDist = 32;

difference()
{
  cube([holderX*2+zDriveXLen,bcFrameThickness+wallThickness*5,height+wallThickness]);
  translate([-extra,wallThickness*4,0])
    cube([holderX*2+zDriveXLen+extra*2,bcFrameThickness,height]);
  translate([holderX,bcFrameThickness+wallThickness*4,0])
    cube([zDriveXLen,wallThickness*4,height]);

  translate([(holderX*2+zDriveXLen)/2-fanX/2,-extra,0])
    cube([fanX,wallThickness*4+extra*2,height-wallThickness]);

  translate([(holderX*2+zDriveXLen)/2-fanScrewDist/2,0,0])
  {
    translate([0,-extra,height/2])
    rotate([-90,0,0])
      cylinder(r=fanScrewHoleDia/2, h=wallThickness*4+extra*2);

    translate([fanScrewDist,-extra,height/2])
    rotate([-90,0,0])
      cylinder(r=fanScrewHoleDia/2, h=wallThickness*4+extra*2);
  }
}
