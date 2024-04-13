$fn=80;
extra=0.01;

screwDia = 3.1;
screwLen = 10;

xAdapter = 123;
yAdapter = 38.5;

adapterWallthickness = 5;
adapterThickness = 20;
frontPlateThickness = 2;
frontPlateRotate = -10;

xPanelHole = 118;
yPanelHole = 33.5;

caseHoles = [[0,0],[xPanelHole,0],[0,yPanelHole],[xPanelHole,yPanelHole]];



module plateAdater()
{
  difference()
  {
    union()
    {
      difference()
      {
        cube([xAdapter,yAdapter,adapterThickness]);
        translate([-extra,0,adapterThickness])
          rotate([frontPlateRotate,0,0])
          cube([xAdapter+extra*2,yAdapter+20,adapterThickness]);
      }
    }
    translate([adapterWallthickness,adapterWallthickness,-extra])
    difference()
    {
      cube([xAdapter-adapterWallthickness*2,yAdapter-adapterWallthickness*2,adapterThickness-frontPlateThickness]);
      translate([-extra,0,adapterThickness-frontPlateThickness])
        rotate([frontPlateRotate,0,0])
        cube([xAdapter+extra*2,yAdapter+20,adapterThickness]);
    }
    translate([adapterWallthickness/2,adapterWallthickness/2,-extra])
    plateAdapterHoles();
  }
}

module plateAdapterHoles()
{
  for (i = caseHoles) {
    translate([i[0],i[1],0])
    cylinder(r=screwDia/2,h=screwLen);
  }
}

/* plateAdater(); */


xLenDisplay = 57.2;
yLenDisplay = 37.8;
xyLenDecoder = 11;


cube([xLenDisplay,yLenDisplay,frontPlateThickness]);
