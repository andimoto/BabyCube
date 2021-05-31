include <../global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/ball_bearings.scad>
include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/sheets.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

use <../utils/carriageTypes.scad>
use <../utils/HolePositions.scad>
use <../utils/X_Rail.scad>

use <TopFace.scad>
use <Y_Carriage.scad>
use <Y_CarriageAssemblies.scad>

use <../Parameters_CoreXY.scad>
use <../Parameters_Positions.scad>
include <../Parameters_Main.scad>


module Top_Face_stl() {
    stl("Top_Face")
        color(pp3_colour)
            vflip()
                topFace(NEMA14);
}

module Top_Face_NEMA_17_stl() {
    stl("Top_Face_NEMA_17")
        color(pp3_colour)
            vflip()
                topFace(NEMA17M);
}

module Top_Face_CF_dxf() {
    dxf("Top_Face_CF")
        topFaceCF(NEMA14);
}

module Top_Face_CF() {
    size = [eX + 2*eSizeX, eY + 2*eSizeY];
    insetY = _backPlateThickness-1;

    translate([size.x/2, size.y/2 + insetY, 0])
        render_2D_sheet(CF3, w=size.x, d=size.y)
            Top_Face_CF_dxf();
}

//! 1. Turn the Top_Face upside down and place it on a flat surface.
//! 2. Bolt the rails to the top face. Note that the first and last bolts on the left rail are countersunk bolts and act as pilot bolts to ensure the rails are aligned precisely - they should be tightened before all the other bolts on the left side.
//! 3. The bolts on the right side rail should be only loosely tightened - they will be fully tightened when the right rail is aligned when the X axis rail is added.
module Top_Face_Stage_1_assembly()  pose(a=[55 + 180, 0, 25 + 310])
assembly("Top_Face_Stage_1", big=true, ngb=true) {

    translate_z(eZ)
        vflip()
            stl_colour(pp3_colour)
                Top_Face_stl();
    topFaceAssembly(NEMA_width(NEMA14));
}

module Top_Face_NEMA_17_Stage_1_assembly()  pose(a=[55 + 180, 0, 25 + 310])
assembly("Top_Face_NEMA_17_Stage_1", big=true, ngb=true) {

    translate_z(eZ)
        vflip()
            stl_colour(pp3_colour)
                Top_Face_NEMA_17_stl();
    topFaceAssembly(NEMA_width(NEMA17M));
}

//! Attach the left and right Y carriages to the top face rails. Note that the two carriages are not interchangeable so be sure
//! to attach them as shown in the diagram.
//!
//! The carriages should be attached to the rails before the pulleys are added, since otherwise the bolts are not accessible.  
//! Attach the pulleys to the carriages. Note that the toothless pulleys are on the inside. Note also that there is a washer under
//! each of the upper pulleys, but not on top of those pulleys.
//!
//! Tighten the pulley bolts until the pulleys stop running freely, and then loosen them slightly (approximately 1/16 of a turn)
//! so they run freely.
//
module Top_Face_Stage_2_assembly() pose(a=[55 + 180, 0, 25 + 310])
assembly("Top_Face_Stage_2", big=true, ngb=true) {

    Top_Face_Stage_1_assembly();

    explode(-15, true) {
        yCarriageLeftAssembly(NEMA_width(NEMA14));
        yCarriageRightAssembly(NEMA_width(NEMA14));
    }
}

//! Attach the left and right Y carriages to the top face rails. Note that the two carriages are not interchangeable so be sure
//! to attach them as per the diagram.
//!
//! The carriages should be attached to the rails before the pulleys are added, since otherwise the bolts are not accessible.  
//! Attach the pulleys to the carriages. Note that the toothless pulleys are on the inside. Note also that there is a washer under
//! each pulley, but not on top of the pulley.
//!
//! Tighten the pulley bolts until the pulleys stop running freely, and then loosen them slightly (approximately 1/16 of a turn)
//! so they run freely.
//
module Top_Face_NEMA_17_Stage_2_assembly() pose(a=[55 + 180, 0, 25 + 310])
assembly("Top_Face_NEMA_17_Stage_2", big=true, ngb=true) {

    Top_Face_NEMA_17_Stage_1_assembly();

    explode(-15, true) {
        yCarriageLeftAssembly(NEMA_width(NEMA17M));
        yCarriageRightAssembly(NEMA_width(NEMA17M));
    }
}

//!1. Turn the Top_Face into its normal orientation.
//!2. Bolt the X-axis linear rail onto the Y carriages.
//!3. Turn the Top_Face upside down again and place it on a flat surface.
//!4. Align the left and right Y-axis linear rails. Do this by pushing the X-axis rail to the rear of the top face and tighten
//!the corresponding bolts (left loose in a previous step) and then push the X-axis rails to the front of the top face, again
//!tightening the corresponding bolts.
//!5. Check that the carriages run smoothly on the Y-axis linear rails.
//
module Top_Face_assembly()
assembly("Top_Face", big=true) {

    Top_Face_Stage_2_assembly();
    //hidden() Y_Carriage_Left_AL_dxf();
    //hidden() Y_Carriage_Right_AL_dxf();

    explode(30, true)
        xRail(xCarriageType(), _xRailLength);
}

module Top_Face_NEMA_17_assembly()
assembly("Top_Face_NEMA_17", big=true) {

    Top_Face_NEMA_17_Stage_2_assembly();

    explode(30, true)
        xRail(xCarriageType(), _xRailLength);
}


module Top_Face_CF_Stage_1_assembly()  pose(a=[55 + 180, 0, 25 + 310])
assembly("Top_Face_CF_Stage_1", big=true) {

    translate_z(eZ - _topPlateThickness + eps)
        Top_Face_CF();
    topFaceAssembly(NEMA_width(NEMA14));
}

module Top_Face_CF_Stage_2_assembly() pose(a=[55 + 180, 0, 25 + 310])
assembly("Top_Face_CF_Stage_2", big=true, ngb=true) {

    Top_Face_CF_Stage_1_assembly();

    yCarriageLeftAssembly(NEMA_width(NEMA14));
    yCarriageRightAssembly(NEMA_width(NEMA14));
}

module Top_Face_CF_assembly()
assembly("Top_Face_CF", big=true) {

    Top_Face_CF_Stage_2_assembly();

    explode(30, true)
        xRail(xCarriageType(), _xRailLength);
}


/*
// used for debug
module Top_Face_with_Printhead_assembly()
assembly("Top_Face_with_Printhead", big=true) {
    Top_Face_with_X_Rail_assembly();

    xRailCarriagePosition()
        rotate(0) {// for debug, to see belts better
            X_Carriage_Front_assembly();
            Print_head_assembly();
            xCarriageTopBolts(xCarriageType());
        }
}
*/

module topFaceAssembly(NEMA_width) {
    yCarriageType = yCarriageType();
    yRailType = carriage_rail(yCarriageType);

    railOffset = yRailOffset(NEMA_width);
    posY = carriagePosition().y - _yRailLength/2 - (_fullLengthYRail ? 0 : eSizeY);

    translate(railOffset)
        rotate([180, 0, 90])
            explode(20, true) {
                rail_assembly(yCarriageType, _yRailLength, posY, carriage_end_colour="green", carriage_wiper_colour="red");
                rail_screws(yRailType, _yRailLength, thickness = 5, index_screws = _useCNC ? 0 : 1);
            }

    translate([eX + 2*eSizeX - railOffset.x, railOffset.y, railOffset.z])
        rotate([180, 0, 90])
            explode(20, true) {
                rail_assembly(yCarriageType, _yRailLength, posY, carriage_end_colour="green", carriage_wiper_colour="red");
                rail_screws(yRailType, _yRailLength, thickness = 5, index_screws = 0);
            }
    *translate_z(eZ - bb_width(BB608)/2)
        zLeadScrewHolePosition()
            ball_bearing(BB608);

}
