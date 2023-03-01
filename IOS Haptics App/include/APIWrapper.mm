//
//  APIWrapper.mm
//  IOS Haptics App
//
//  Created by William Wei on 12/6/22.
//

#import <Foundation/Foundation.h>

#import "APIWrapper.h"
#import "API.hpp"

@implementation APIWrapper

- (void*) generate {
    API api;
    void* ptr = api.generate();
    return ptr;
}

- (double) output:(void*)ptr interpSurf:(int)interpSurf interpSpeed:(float)interpSpeed interpForce:(float)interpForce {
    API api;
    double x = api.output(ptr, interpSurf, interpSpeed, interpForce);
    return x;
}
@end
