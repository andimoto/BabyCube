$fn=80;
extra=0.01;

connectorWallthickness = 0.6;

xLenCon6x2 = 13;
yLenCon6x2 = 5.5;

xLenCon1x3 = 3;
yLenCon1x3 = 8;

zConHeight = 14;


xTH_Hook = 20;
yTH_Hook = 6;
zTH_Hook = 12;

screwDia = 3.5;

setScrewDia = 2.9;
zMoveConnFix = 3;

connDiff = (xTH_Hook) - (xLenCon6x2+xLenCon1x3);

translate([connectorWallthickness + connDiff/2,(connectorWallthickness),0])
difference()
{
  union()
  {
    translate([xLenCon1x3-connectorWallthickness,-connectorWallthickness,0])
    cube([xLenCon6x2+connectorWallthickness*2,yLenCon6x2+connectorWallthickness*2,zConHeight]);
    translate([-connectorWallthickness,-connectorWallthickness,0])
    cube([xLenCon1x3+connectorWallthickness*2,yLenCon1x3+connectorWallthickness*2,zConHeight]);

    translate([-connectorWallthickness,0,zMoveConnFix])
    rotate([0,-90,0])
    setScrewHolder();
  }
  translate([0,0,-extra])
  connector();

  translate([1,3,4+zMoveConnFix])
  rotate([0,-90,0])
  cylinder(r=setScrewDia/2, h=10);
}

translate([0,-(yTH_Hook+connectorWallthickness*2),0])
union()
{
  difference() {
    cube([xTH_Hook+connectorWallthickness*2,yTH_Hook+connectorWallthickness*2,zTH_Hook+connectorWallthickness]);

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


module connector()
{
  union()
  {
    translate([xLenCon1x3,0,0])
    cube([xLenCon6x2,yLenCon6x2,zConHeight+extra*2]);
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
