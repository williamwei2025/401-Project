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

- (void) output:(void*)ptr sharpnessArray:(float*)sharpnessArray size:(int)size interpSurf:(int)interpSurf interpSpeed:(float)interpSpeed interpForce:(float)interpForce {
    API api;
    api.output(ptr, sharpnessArray, size, interpSurf, interpSpeed, interpForce);
    
    NSLog(@"%f", sharpnessArray[20]);
}
@end
