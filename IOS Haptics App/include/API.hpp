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
#include "AccSynthHashMatrix.h"


class API {
public:
    void* initialize;
    double output(void *object, int interpSurf, float interpSpeed, float interpForce);
};


#endif /* API_hpp */
