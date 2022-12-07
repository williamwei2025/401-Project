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

//- (AccSynthHashMatrixWrapper *) initialize {
//    API api;
//    AccSynthHashMatrix hashMatrix = api.initialize();
//    AccSynthHashMatrixWrapper *wrapper = [AccSynthHashMatrixWrapper new];
//    wrapper.hashMatrix = hashMatrix;
//
//    return wrapper;
//
//}
//
//- (double) output:(AccSynthHashMatrixWrapper *)wrapper interpSurf:(int)interpSurf interpSpeed:(float)interpSpeed interpForce:(float)interpForce {
//    API api;
//    AccSynthHashMatrix hm = wrapper.hashMatrix;
//    double x = api.output(hm, interpSurf, interpSurf, interpSpeed);
//    return x;
//}

- (double) output:(NSString*)path interpSurf:(int)interpSurf interpSpeed:(float)interpSpeed interpForce:(float)interpForce {
    API api;
    const char *cString = [path UTF8String];
    double x = api.output(cString, interpSurf, interpSpeed, interpForce);
    return x;
}
@end
