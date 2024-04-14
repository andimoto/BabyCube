$fn=80;
extra=0.01;

screwDia = 3.1;
screwLen = 10;

xAdapter = 125;
yAdapter = 50;

adapterXWallthickness = 7;
adapterYWallthickness = 1;
adapterThickness = 30;
frontPlateThickness = 2;
frontPlateRotate = -20;

xPanelHole = 118;
yPanelHole = 33.5;

caseHoles = [[0,0],[xPanelHole,0],[0,yPanelHole],[xPanelHole,yPanelHole]];


/* cutout and pcb mount dimensions */
xLenDisplay = 58.5;
yLenDisplay = 39;
xyLenDecoder = 15;
xyLenReset = 7;

xHoleDisp = 93;
yHoleDisp = 41;

mini12864Holes = [[0,0],[xHoleDisp,0],[0,yHoleDisp],[xHoleDisp,yHoleDisp]];


xMoveDisplay = 3.5;
xMoveDecoder = 79.5 + xMoveDisplay;

yMoveDisplay = 1;
yMoveDecoder = 24;
yMoveCutoutExtra = 1;

yMidMoveDecReset = 15;  // move in y of reset relativ to middle point of decoder cutout

yMoveAllPCB = 2;
yMovePCBMount = 1;

// I used a small rocker switch
WifiSwitch = true;
WifiSwitchYMove = 20;

WifiSwitchYLen = 14;
WifiSwitchZLen = 10; // + one overhang (cover) of rocker switch

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

    /* cutouts for display, knob, reset */
    cutouts();

    pcbScrewMountHoles();

    if(WifiSwitch == true)
    {
      translate([-extra+xAdapter-adapterXWallthickness,-WifiSwitchYLen/2+WifiSwitchYMove,-extra])
      cube([adapterXWallthickness+extra*2,WifiSwitchYLen,WifiSwitchZLen]);
    }

    /* translate([xAdapter+extra,yAdapter/2,5+5])
    rotate([0,-90,0])
    cylinder(r=5,h=adapterXWallthickness-2); */

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
  translate([0,yMovePCBMount+yMoveAllPCB,-1-3])
  mini12864_Holes(mountPin = true);
}


/* cutouts(); */
module cutouts()
{
  translate([0,0,-3])
  translate([tempX,tempY,adapterThickness])
  rotate([frontPlateRotate,0,0])
  translate([0,yMoveCutoutExtra+yMoveAllPCB,-1])
  union()
  {
    translate([xMoveDisplay,yMoveDisplay,0])
    cube([xLenDisplay,yLenDisplay,frontPlateThickness+1]);  // add 1 to thickness for proper cuout

    translate([xMoveDecoder-xyLenDecoder/2,yMoveDecoder-xyLenDecoder/2,0])
    cube([xyLenDecoder,xyLenDecoder,frontPlateThickness+1]);  // add 1 to thickness for proper cuout

    translate([xMoveDecoder-xyLenReset/2, yMoveDecoder-xyLenReset-yMidMoveDecReset,0])
    cube([xyLenReset,xyLenReset,frontPlateThickness+1]);  // add 1 to thickness for proper cuout
  }
}

module pcbScrewMountHoles()
{
  translate([0,0,-2])
  translate([tempX,tempY,adapterThickness])
  rotate([frontPlateRotate,0,0])
  translate([0,yMovePCBMount+yMoveAllPCB,-5])
  mini12864_Holes(height=5);
}
