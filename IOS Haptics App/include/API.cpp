//
//  API.cpp
//  IOS Haptics App
//
//  Created by William Wei on 12/6/22.
//


#include "API.hpp"
#include "AccSynthHashMatrix.h"
#include "autoGenHashMatrix.h"
#include <iostream>
#include <tuple>


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
    double x = 0;
    
    std::vector <double> outputHist;
    std::vector <double> excitationHist;
    double filtCoeff[MAX_COEFF];
    double filtMACoeff[MAX_COEFF];
    double filtVariance;
    double filtGain;
    int coeffNum;
    int MAcoeffNum;
    
    
    tie(coeffNum,MAcoeffNum,filtVariance,filtGain) = hashMatrix.HashAndInterp2(interpSurf, 1, interpForce, filtCoeff, filtMACoeff);
    
    for(int i=0; i<600; i++){
        x = hashMatrix.vibrations(coeffNum,MAcoeffNum,filtVariance, filtGain, filtCoeff, filtMACoeff,outputHist,excitationHist);
        x += 1;
        cout << x << ", ";
    }
    cout << "Finished" << endl;
    
    return x;

}
