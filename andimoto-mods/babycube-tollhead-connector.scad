$fn=80;
extra=0.01;

connectorWallthickness = 0.6;

xLenCon3x2 = 7.8;
yLenCon6x2 = 5.5;

xLenCon1x3 = 3;
yLenCon1x3 = 8;

zConHeight = 14;


xTH_Hook = 21;
yTH_Hook = 6;
zTH_Hook = 12;

screwDia = 3.5;

setScrewDia = 2.9;
zMoveConnFix = 3;


xLenTerminal = 12.5;
yLenTerminal = 10.5;
zLenTerminal = 9;

xPinCutoutTerminal = 4;

connDiff = (xTH_Hook) - (xLenCon3x2+xLenCon1x3);


conTerminal();
module conTerminal()
{
  difference()
  {
    translate([0,-connectorWallthickness,0])
    cube([xLenTerminal+connectorWallthickness*2,yLenTerminal+connectorWallthickness*2,zConHeight]);

    translate([connectorWallthickness,0,zConHeight-zLenTerminal])
    cube([xLenTerminal,yLenTerminal,zLenTerminal+extra]);

    translate([connectorWallthickness+extra,0,zConHeight-4])
    rotate([0,-90,0])
    hull()
    {
      translate([0,yLenTerminal/2+2.5,0])
      cylinder(r=2,h=connectorWallthickness+extra*2);
      translate([0,yLenTerminal/2-2.5,0])
      cylinder(r=2,h=connectorWallthickness+extra*2);
    }


    translate([connectorWallthickness+xLenTerminal-xPinCutoutTerminal-2,0,-extra])
    cube([xPinCutoutTerminal,yLenTerminal,zConHeight-zLenTerminal+extra*2]);
  }
}




translate([xLenTerminal+connectorWallthickness,0,0])
pinHeaderPeri();
module pinHeaderPeri()
{
  /* translate([connDiff,0,0]) */
  translate([connectorWallthickness,(connectorWallthickness),0])
  difference()
  {
    union()
    {
      translate([xLenCon1x3-connectorWallthickness,-connectorWallthickness,0])
      cube([xLenCon3x2+connectorWallthickness*2,yLenCon6x2+connectorWallthickness*2,zConHeight]);
      translate([-connectorWallthickness,-connectorWallthickness,0])
      cube([xLenCon1x3+connectorWallthickness*2,yLenCon1x3+connectorWallthickness*2,zConHeight]);

      translate([xLenCon1x3+xLenCon3x2+connectorWallthickness,-connectorWallthickness/2,zMoveConnFix])
      mirror([1,0,0])
      rotate([0,-90,0])
      setScrewHolder();
    }
    translate([0,0,-extra])
    connector();

    translate([xTH_Hook,3-connectorWallthickness/2,4+zMoveConnFix])
    rotate([0,-90,0])
    cylinder(r=setScrewDia/2, h=10);
  }
}

xMoveConnHolder =
  xLenTerminal + xLenCon3x2 + xLenCon1x3 + connectorWallthickness*3
  - (xTH_Hook+connectorWallthickness*2);

translate([xMoveConnHolder/2,0,0])
connHolder();
module connHolder()
{
  translate([0,-(yTH_Hook+connectorWallthickness*2),0])
  union()
  {
    difference() {
      cube([xTH_Hook+connectorWallthickness*2,yTH_Hook+connectorWallthickness*2,zConHeight]);

      translate([connectorWallthickness,connectorWallthickness,-extra])
      cube([xTH_Hook,yTH_Hook,zTH_Hook]);


      translate([connectorWallthickness+4,-extra,zTH_Hook-5])
      rotate([-90,0,0])
      cylinder(r=screwDia/2, h=yTH_Hook);

      translate([xTH_Hook+connectorWallthickness-4,-extra,zTH_Hook-5])
      rotate([-90,0,0])
      cylinder(r=screwDia/2, h=yTH_Hook);
    }
  }
}




module connector()
{
  union()
  {
    translate([xLenCon1x3,0,0])
    cube([xLenCon3x2,yLenCon6x2,zConHeight+extra*2]);
    translate([0,0,0])
    cube([xLenCon1x3,yLenCon1x3,zConHeight+extra*2]);
  }
}

module setScrewHolder()
{
    hull()
    {
      cube([8,6,0.01]);
      translate([2,1,2])
      cube([4,4,0.01]);
    }
}
