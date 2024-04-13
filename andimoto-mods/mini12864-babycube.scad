$fn=80;
extra=0.01;

screwDia = 3.1;
screwLen = 10;

xAdapter = 125;
yAdapter = 50;

adapterXWallthickness = 7;
adapterYWallthickness = 1;
adapterThickness = 25;
frontPlateThickness = 2;
frontPlateRotate = -15;

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
        translate([adapterXWallthickness,adapterYWallthickness,-extra])
        difference()
        {
          cube([xAdapter-adapterXWallthickness*2,yAdapter-adapterYWallthickness*2,adapterThickness-frontPlateThickness]);
          translate([-extra,0,adapterThickness-frontPlateThickness])
            rotate([frontPlateRotate,0,0])
            cube([xAdapter+extra*2,yAdapter+20,adapterThickness]);
        }
        translate([adapterXWallthickness/2,8/2,-extra])
        plateAdapterHoles();
      }
      mountPins();
    }


    translate([0,0,-3])
    translate([tempX,tempY,adapterThickness])
    rotate([frontPlateRotate,0,0])
    translate([0,0,0])
    union()
    {
    translate([3,1,0])
    cube([xLenDisplay,yLenDisplay,frontPlateThickness+1]);

    translate([-xyLenDecoder/2 +3 + 79,-xyLenDecoder/2 + 24,0])
    cube([xyLenDecoder,xyLenDecoder,frontPlateThickness+1]);

    translate([+3+79-6.1/2, 24-6.1-15,0])
    cube([6.1,6.1,frontPlateThickness+1]);

    }



    union()
    {
      translate([0,0,-2])
      translate([tempX,tempY,adapterThickness])
      rotate([frontPlateRotate,0,0])
      translate([0,0,-5])
      mini12864_Holes(height=5);
    }

  }
}

module plateAdapterHoles()
{
  for (i = caseHoles) {
    translate([i[0],i[1],0])
    cylinder(r=screwDia/2,h=screwLen);
  }
}


plateAdater();




xLenDisplay = 57.2;
yLenDisplay = 37.8;
xyLenDecoder = 15;

xHoleDisp = 93;
yHoleDisp = 41;

mini12864Holes = [[0,0],[xHoleDisp,0],[0,yHoleDisp],[xHoleDisp,yHoleDisp]];

function retMountPin(mountPin = false) = (mountPin==true) ? (1.5+screwDia/2) : screwDia/2 ;
module mini12864_Holes(mountPin = false, height = 4)
{
  for (i = mini12864Holes) {
    translate([i[0],i[1],0])
    cylinder(r=retMountPin(mountPin),h=height);
  }
}

tempX = (xAdapter-xHoleDisp)/2;
tempY = (yAdapter-yHoleDisp)/2;
module mountPins()
{
  translate([0,0,-2])
  translate([tempX,tempY,adapterThickness])
  rotate([frontPlateRotate,0,0])
  translate([0,0,-1-3])
  mini12864_Holes(mountPin = true);
}


/* translate([0,0,-3])
translate([tempX,tempY,adapterThickness])
rotate([frontPlateRotate,0,0])
translate([0,0,0])
union()
{
translate([3,1,0])
cube([xLenDisplay,yLenDisplay,frontPlateThickness+1]);

translate([-xyLenDecoder/2 +3 + 79,-xyLenDecoder/2 + 24,0])
cube([xyLenDecoder,xyLenDecoder,frontPlateThickness+1]);

translate([+3+79-6.1/2, 24-6.1-15,0])
cube([6.1,6.1,frontPlateThickness+1]);

} */

/* translate([0,0,-2])
translate([tempX,tempY,adapterThickness])
rotate([frontPlateRotate,0,0])
translate([0,0,-5])
mini12864_Holes(height=5); */
