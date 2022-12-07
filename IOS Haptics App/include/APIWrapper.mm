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
- (void *) initialize {
    API api;
    void* x = api.initialize();
    return x;
}

- (double) output:(void *)object interpSurf:(int)interpSurf interpSpeed:(float)interpSpeed interpForce:(float)interpForce {
    API api;
    double x = api.output(object, interpSurf, interpSurf, interpSpeed);
    return x;
}
@end
