include <global_defs.scad>

include <vitamins/bolts.scad>

use <printed/BackFace.scad>
use <printed/BackFaceAssemblies.scad>
use <printed/Base.scad>
use <printed/DisplayHousingAssemblies.scad>
include <printed/Extras.scad>
use <printed/FrontChords.scad>
use <printed/LeftAndRightFaceAssemblies.scad>
use <printed/PrintheadAssemblies.scad>
use <printed/TopFaceAssemblies.scad>
use <printed/X_CarriageAssemblies.scad>

include <utils/CoreXYBelts.scad>
include <utils/HolePositions.scad>

use <Parameters_Positions.scad>


staged_assembly = false; // set this to false for faster builds during development

module staged_assembly(name, big, ngb) {
    if (staged_assembly)
        assembly(name, big, ngb)
            children();
    else
        children();
}

//!1. Bolt the **Left_Face** and the left feet to the base.
//!2. Bolt the **Right_Face** and the right feet to the base.
//
module Stage_1_assembly()
staged_assembly("Stage_1", big=true, ngb=true) {

    explode([-100, 0, 25])
        Left_Face_assembly();

    translate_z(-eps)
        Base_assembly();

    translate_z(-eps) {
        stl_colour(pp2_colour)
            baseLeftFeet();
        baseLeftFeet(hardware=true);
    }
    explode(-40)
        baseLeftHolePositions(-_basePlateThickness)
            vflip()
                boltM3Buttonhead(8);

    explode([100, 50, 0])
        Right_Face_assembly();

    translate_z(-eps) {
        stl_colour(pp2_colour)
            baseRightFeet();
        baseRightFeet(hardware=true);
    }
    explode(-40)
        baseRightHolePositions(-_basePlateThickness)
            vflip()
                boltM3Buttonhead(8);
}

//! Add the **Back_Face** and bolt it to the left and right faces and the base.
//
module Stage_2_assembly()
staged_assembly("Stage_2", big=true, ngb=true) {

    Stage_1_assembly();

    explode([0, 200, 0], true) {
        Back_Face_assembly();
        translate([0, eY + 2*eSizeY, 0])
            rotate([90, 0, 0]) {
                backFaceAllHolePositions(-_backPlateThickness)
                    vflip()
                        explode(50)
                            boltM3Countersunk(6);
                backFaceBracketHolePositions(-_backPlateThickness)
                    vflip()
                        explode(50)
                            boltM3Countersunk(10);
            }
            baseBackHolePositions(-_basePlateThickness)
                vflip()
                    boltM3Buttonhead(10);
    }
    if (!exploded())
        backFaceCableTies();
}


//!Bolt the BabyCube nameplate and the **Display_Housing** to the front of the frame.
//
module Stage_3_assembly()
staged_assembly("Stage_3", big=true, ngb=true) {

    Stage_2_assembly();

    explode([0, -20, 0], true) {
        translate_z(eZ)
            rotate([90, 0, 180]) {
                translate([0, -eps, 0]) {
                    stl_colour(pp2_colour)
                        Front_Upper_Chord_stl();
                    Front_Upper_Chord_hardware();
                }
                color(pp4_colour)
                    frontUpperChordMessage();
            }
        Display_Housing_assembly();
        frontLowerChordHardware();
    }
    baseFrontHolePositions(-_basePlateThickness)
        vflip()
            explode(30)
                boltM3Buttonhead(10);
}

//! Add the **Top_Face**.
//
module Stage_4_assembly()
staged_assembly("Stage_4", big=true, ngb=true) {

    Stage_3_assembly();

    explode(50, true) {
        if (_xyMotorDescriptor == "NEMA14")
            Top_Face_assembly();
        else
            Top_Face_NEMA_17_assembly();
        topFaceAllHolePositions(eZ + _topPlateCoverThickness)
            boltM3Buttonhead(12);
    }
}

//!1. Add the Printhead.
//!2. Thread the belts in the pattern shown.
//!3. Adjust the belts tension.
//
module Stage_5_assembly()
staged_assembly("Stage_5", big=true, ngb=true) {

    Stage_4_assembly();

    explode(100)
        CoreXYBelts(carriagePosition());
    explode(100, true) {
        printheadBeltSide();
    }
}

module FinalAssembly() {
    translate([-(eX + 2*eSizeX)/2, - (eY + 2*eSizeY)/2, -eZ/2])
        if ($target == "BC200_test") {
            /* Left_Face_stl();
            Right_Face_stl(); */
            Base_stl();
            /* Base_Template_stl(); */
            /* translate([0,230,0])
            Back_Face_stl(); */
        } else {
            Stage_5_assembly();
            if (!exploded())
                printheadWiring(carriagePosition());
            explode(100, true)
                printheadHotendSide();
            explode(150)
                bowdenTube(carriagePosition());
            explode([75, 0, 100])
                faceRightSpoolHolder();
            explode([150, 0, 0])
                faceRightSpool();
        }
}
