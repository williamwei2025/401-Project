//
//  API.hpp
//  IOS Haptics App
//
//  Created by William Wei on 12/6/22.
//

#ifndef API_hpp
#define API_hpp

#include <stdio.h>
#include <string>

class API {
public:
    //AccSynthHashMatrix initialize();
    //double output(int interpSurf, float interpSpeed, float interpForce);
    double output(const char* path, int interpSurf, float interpSpeed, float interpForce);
};


#endif /* API_hpp */
