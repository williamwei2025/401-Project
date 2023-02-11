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
    
    
    double x;
    
    for(int i=0; i<300; i++) {
        hashMatrix.HashAndInterp2(interpSurf, i%2==0?interpSpeed:3, interpForce);
        
        x = hashMatrix.vibrations();
        cout << x << ",";
    }
    cout << endl;
    
    //hashMatrix.~AccSynthHashMatrix();
    return x;

}
