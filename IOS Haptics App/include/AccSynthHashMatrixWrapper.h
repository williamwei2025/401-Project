//
//  AccSynthHashMatrixWrapper.h
//  IOS Haptics App
//
//  Created by user229725 on 11/16/22.
//

#ifndef AccSynthHashMatrixWrapper_h
#define AccSynthHashMatrixWrapper_h


#import <Foundation/Foundation.h>

@interface AccSynthHashMatrixWrapper : NSObject
- (void)HashAndInterp2:(float)interpSpeed interpForce:(float)interpForce;
- (int)test:(int)count;
@end

#endif /* AccSynthHashMatrixWrapper_h */
