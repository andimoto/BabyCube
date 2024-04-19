$fn=80;
extra=0.005;

pindaD=8;
pindaExtra = 0.1;

screwDia = 2;
screwExtra = 0.3;

plateExtra = 3;
pindaMountHeight = 36;
pindaTubeHeight = 24;
pindaMountX = 35;
wallthickness=0.8;

xMoveLongHole = 3.5;

setScrewDia=2.9;


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
  difference()
  {
    union()
    {
      translate([0,pindaD/2+pindaExtra,0])
      cube([pindaMountX+plateExtra,wallthickness,pindaMountHeight]);

      pindaProbeTube();
    }


    translate([plateExtra+xMoveLongHole,tempX+extra,1+screwDia/2+screwExtra])
    longhole();
    translate([plateExtra+xMoveLongHole,tempX+extra,+screwDia/2])
    longhole();

    translate([plateExtra+xMoveLongHole+28-2,tempX+extra,1+screwDia/2+screwExtra])
    longhole();
    translate([plateExtra+xMoveLongHole+28-2,tempX+extra,screwDia/2])
    longhole();

    translate([plateExtra+xMoveLongHole+28-2,tempX+extra,6+1+screwDia/2+screwExtra])
    longhole();
    translate([plateExtra+xMoveLongHole+2,tempX+extra,24+6+1+screwDia/2+screwExtra])
    longhole();

  }


}

module pindaProbeTube()
{
  difference()
  {
    union()
    {
      cylinder(r=(wallthickness+pindaExtra+pindaD/2),h=pindaTubeHeight);
      translate([0.97-pindaD/2-wallthickness,-3,0])
      rotate([0,-90,0])
      setScrewHolder();

      translate([0,0,15])
      translate([0.97-pindaD/2-wallthickness,-3,0])
      rotate([0,-90,0])
      setScrewHolder();
    }

    translate([0,0,0])
    hull()
    {
      translate([pindaExtra,-pindaD/2-wallthickness-pindaExtra,0])
      cube([pindaD/2+wallthickness,(pindaD+wallthickness*2)+pindaExtra,0.1]);
      translate([pindaExtra-0.01+pindaD/2+wallthickness,-pindaD/2-wallthickness-pindaExtra,pindaD])
      cube([0.01,(pindaD+wallthickness*2)+pindaExtra,0.01]);
    }

    translate([0,0,-extra])
    cylinder(r=(pindaExtra + pindaD/2),h=pindaMountHeight+extra*2);

    translate([0,0,4])
    rotate([0,-90,0])
    cylinder(r=setScrewDia/2, h=10);

    translate([0,0,4+15])
    rotate([0,-90,0])
    cylinder(r=setScrewDia/2, h=10);

  }
}

/* setScrewHolder(); */
module setScrewHolder()
{
    hull()
    {
      cube([8,6,0.01]);
      translate([2,1,2.5])
      cube([4,4,0.01]);
    }
}


bc_pinda_holder();
