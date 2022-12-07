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
//- (AccSynthHashMatrixWrapper*) initialize;
//- (double) output:(AccSynthHashMatrixWrapper*)hashMatrix interpSurf:(int)interpSurf interpSpeed:(float)interpSpeed interpForce:(float)interpForce;
- (double) output:(NSString*)path interpSurf:(int)interpSurf interpSpeed:(float)interpSpeed interpForce:(float)interpForce;
@end

#endif /* APIWrapper_h */
