//
//  API.h
//  IOS Haptics App
//
//  Created by William Wei on 12/6/22.
//

#ifndef API_h
#define API_h

#include "AccSynthHashMatrix.h"
#include "autoGenHashMatrix.h"

class API{
public:
        void *initialize();
        double output(void *object, int interpSurf, float interpSpeed, float interpForce);
};


#endif /* API_h */
