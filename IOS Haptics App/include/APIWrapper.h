//
//  APIWrapper.h
//  IOS Haptics App
//
//  Created by William Wei on 12/6/22.
//

#ifndef APIWrapper_h
#define APIWrapper_h

#import <Foundation/Foundation.h>

@interface APIWrapper : NSObject
- (void) output:(void*)ptr sharpnessArray:(float*)sharpnessArray size:(int)size interpSurf:(int)interpSurf interpSpeed:(float)interpSpeed interpForce:(float)interpForce;
- (void*) generate;
@end

#endif /* APIWrapper_h */
