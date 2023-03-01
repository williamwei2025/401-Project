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


void* API::generate()
{
    static AccSynthHashMatrix hashMatrix = generateHashMatrix("test");
    void* ptr = &hashMatrix;
    return ptr;
}

double API::output(void* ptr, int interpSurf, float interpSpeed, float interpForce)
{
    AccSynthHashMatrix* hashMatrix = static_cast<AccSynthHashMatrix*>(ptr);
    double x = 0;
    
    std::vector <double> outputHist;
    std::vector <double> excitationHist;
    double filtCoeff[MAX_COEFF];
    double filtMACoeff[MAX_COEFF];
    double filtVariance;
    double filtGain;
    int coeffNum;
    int MAcoeffNum;
    
    
    tie(coeffNum,MAcoeffNum,filtVariance,filtGain) = hashMatrix->HashAndInterp2(interpSurf, 1, interpForce, filtCoeff, filtMACoeff);
    
    for(int i=0; i<600; i++){
        x = hashMatrix->vibrations(coeffNum,MAcoeffNum,filtVariance, filtGain, filtCoeff, filtMACoeff,outputHist,excitationHist);
        x += 1;
        cout << x << ", ";
    }
    cout << "Finished" << endl;
    
    return x;

}
