
include <../global_defs.scad>

include <NopSCADlib/core.scad>

include <NopSCADlib/vitamins/pulleys.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../utils/carriageTypes.scad>

use <Y_Carriage.scad>

use <../Parameters_CoreXY.scad>
use <../Parameters_Positions.scad>
include <../Parameters_Main.scad>


//function pulleyOffset() = [-yRailShiftX(), 0, yCarriageThickness() - 6 + 1.25 + pulleyStackHeight()];
//function pulleyOffset() = [-yRailShiftX(), 0, yCarriageThickness() + pulleyStackHeight()/2];
function pulleyOffset() = [-yRailShiftX(), 0, 0];
function tongueOffset(NEMA_width=_xyNEMA_width) = (eX + 2*eSizeX - _xRailLength - 2*yRailOffset(NEMA_width).x)/2;

topInset = 3.5;


module Y_Carriage_Left_stl() {
    idlerHeight = pulley_height(coreXY_toothed_idler(coreXY_type()));
    pulleyStackHeight = pulleyStackHeight(idlerHeight);
    assert(pulleyStackHeight + yCarriageBraceThickness() == coreXYSeparation().z);

    blockOffsetX = topInset - 2.75;
    chamfer = 0;
    endStopOffsetX = 2.5;

    stl("Y_Carriage_Left")
        color(pp2_colour)
            Y_Carriage(yCarriageType(), idlerHeight, _beltWidth, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffsetX, endStopOffsetX, tongueOffset(), pulleyOffset(), topInset, left=true, cnc=false);
}

module Y_Carriage_Right_stl() {
    idlerHeight = pulley_height(coreXY_toothed_idler(coreXY_type()));
    blockOffsetX = topInset - 2.75;
    chamfer = 0;
    endStopOffsetX = 1;

    stl("Y_Carriage_Right")
        color(pp2_colour)
            Y_Carriage(yCarriageType(), idlerHeight, _beltWidth, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffsetX, endStopOffsetX, tongueOffset(), pulleyOffset(), topInset, left=false, cnc=false);
}

module Y_Carriage_Left_AL_dxf() {
    idlerHeight = pulley_height(coreXY_toothed_idler(coreXY_type()));
    blockOffsetX = topInset - 2.75;
    chamfer = 0;
    endStopOffsetX = 2.5;

    dxf("Y_Carriage_Left_AL")
        color(silver)
            Y_Carriage(yCarriageType(), idlerHeight, _beltWidth, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffsetX, endStopOffsetX, tongueOffset(), pulleyOffset(), topInset, left=true, cnc=true);
}

module Y_Carriage_Right_AL_dxf() {
    idlerHeight = pulley_height(coreXY_toothed_idler(coreXY_type()));
    blockOffsetX = topInset - 2.75;
    chamfer = 0;
    endStopOffsetX = 1;

    dxf("Y_Carriage_Right_AL")
        color(silver)
            Y_Carriage(yCarriageType(), idlerHeight, _beltWidth, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffsetX, endStopOffsetX, tongueOffset(), pulleyOffset(), topInset, left=false, cnc=true);
}

module Y_Carriage_Brace_Left_stl() {
    holeRadius = M3_tap_radius;

    stl("Y_Carriage_Brace_Left")
        color(pp1_colour)
            yCarriageBrace(yCarriageType(), yCarriageBraceThickness(), pulleyOffset(), holeRadius, left=true);
}

module Y_Carriage_Brace_Right_stl() {
    holeRadius = M3_tap_radius;

    stl("Y_Carriage_Brace_Right")
        color(pp1_colour)
            yCarriageBrace(yCarriageType(), yCarriageBraceThickness(), pulleyOffset(), holeRadius, left=false);
}

module yCarriageLeftAssembly(NEMA_width) {

    yCarriageType = yCarriageType();
    railOffset = yRailOffset(NEMA_width);
    plainIdler = coreXY_plain_idler(coreXY_type());
    toothedIdler = coreXY_toothed_idler(coreXY_type());
    pulleyStackHeight = pulleyStackHeight(pulley_height(plainIdler));

    translate([railOffset.x, carriagePosition().y, railOffset.z - carriage_height(yCarriageType)])
        rotate([180, 0, 0]) {
            stl_colour(pp2_colour)
                Y_Carriage_Left_stl();
            if (yCarriageBraceThickness())
                translate_z(yCarriageThickness() + pulleyStackHeight + eps)
                    explode(4*yCarriageExplodeFactor())
                        stl_colour(pp1_colour)
                            Y_Carriage_Brace_Left_stl();
            Y_Carriage_hardware(yCarriageType, plainIdler, toothedIdler, _beltWidth, yCarriageThickness(), yCarriageBraceThickness(), pulleyOffset(), left=true);
        }
}

module yCarriageRightAssembly(NEMA_width) {

    yCarriageType = yCarriageType();
    railOffset = yRailOffset(NEMA_width);
    plainIdler = coreXY_plain_idler(coreXY_type());
    toothedIdler = coreXY_toothed_idler(coreXY_type());
    pulleyStackHeight = pulleyStackHeight(pulley_height(plainIdler));

    translate([eX + 2*eSizeX - railOffset.x, carriagePosition().y, railOffset.z - carriage_height(yCarriageType)])
        rotate([180, 0, 180]) {
            stl_colour(pp2_colour)
                Y_Carriage_Right_stl();
            if (yCarriageBraceThickness())
                translate_z(yCarriageThickness() + pulleyStackHeight + 2*eps)
                    explode(4*yCarriageExplodeFactor())
                        stl_colour(pp1_colour)
                            Y_Carriage_Brace_Right_stl();
            Y_Carriage_hardware(yCarriageType, plainIdler, toothedIdler, _beltWidth, yCarriageThickness(), yCarriageBraceThickness(), pulleyOffset(), left=false);
        }
}
