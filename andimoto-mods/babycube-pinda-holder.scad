$fn=80;
extra=0.005;

pindaD=7.8;
pindaExtra = 0.1;

screwDia = 2;
screwExtra = 0.3;

pindaMountHeight = 36;
pindaMountX = 33.5;
wallthickness=0.8;

tempX=pindaD/2+pindaExtra+wallthickness;
/* longhole(); */

module longhole()
{
  rotate([90,0,0])
  hull()
  {
    cylinder(r=screwDia/2+screwExtra, h=wallthickness+extra*2);
    translate([2,0,0])
    cylinder(r=screwDia/2+screwExtra, h=wallthickness+extra*2);
  }
}

module bc_pinda_holder()
{
  difference() {
    translate([0,pindaD/2+pindaExtra,0])
    cube([pindaMountX+tempX,wallthickness,pindaMountHeight]);

    translate([3+tempX,tempX+extra,1+screwDia/2+screwExtra])
    longhole();
    translate([3+tempX+28-2,tempX+extra,1+screwDia/2+screwExtra])
    longhole();

    translate([3+tempX+28-2,tempX+extra,6+1+screwDia/2+screwExtra])
    longhole();
    translate([3+tempX,tempX+extra,24+6+1+screwDia/2+screwExtra])
    longhole();
  }




  difference()
  {
    cylinder(r=(wallthickness+pindaExtra+pindaD/2),h=pindaMountHeight);
    translate([0,0,-extra])
    cylinder(r=(pindaExtra + pindaD/2),h=pindaMountHeight+extra*2);

  }
}


bc_pinda_holder();
