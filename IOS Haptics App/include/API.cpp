//
//  API.cpp
//  IOS Haptics App
//
//  Created by William Wei on 12/6/22.
//


#include "API.hpp"
#include "AccSynthHashMatrix.h"
#include "autoGenHashMatrix.h"

//AccSynthHashMatrix initialize()
//{
//    AccSynthHashMatrix hashmatrix= generateHashMatrix();
//    return hashmatrix;
//}
//
//double output(AccSynthHashMatrix* hashMatrix, int interpSurf, float interpSpeed, float interpForce)
//{
//
//    hashMatrix->HashAndInterp2(interpSurf, interpSpeed, interpForce);
//    double x = hashMatrix->vibrations();
//    return x;
//}
double API::output(const char* path, int interpSurf, float interpSpeed, float interpForce)
{
    AccSynthHashMatrix hashMatrix = generateHashMatrix(path);
    hashMatrix.HashAndInterp2(interpSurf, interpSpeed, interpForce);
    double x = hashMatrix.vibrations();
    hashMatrix.~AccSynthHashMatrix();
    return x;
}
