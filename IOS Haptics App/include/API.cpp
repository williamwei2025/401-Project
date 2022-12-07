//
//  API.cpp
//  IOS Haptics App
//
//  Created by William Wei on 12/6/22.
//

#include "API.hpp"
#include "AccSynthHashMatrix.h"
#include "autoGenHashMatrix.h"


void* initialize()
{
    AccSynthHashMatrix *hashmatrix = new AccSynthHashMatrix;
    *hashmatrix = generateHashMatrix();
    return (void *)hashmatrix;
}

double output(void *object, int interpSurf, float interpSpeed, float interpForce)
{
    AccSynthHashMatrix *hashmatrix;
    hashmatrix = (AccSynthHashMatrix *)object;
    hashmatrix->HashAndInterp2(interpSurf, interpSpeed, interpForce);
    double x = hashmatrix->vibrations();
    return x;
}
