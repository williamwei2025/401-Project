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
    double output(void* ptr, int interpSurf, float interpSpeed, float interpForce);
    void* generate();
};


#endif /* API_hpp */
