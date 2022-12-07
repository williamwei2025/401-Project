//
//  AccSynthHashMatrixWrapper.mm
//  IOS Haptics App
//
//  Created by user229725 on 11/16/22.
//

#import <Foundation/Foundation.h>

#import "AccSynthHashMatrixWrapper.h"
#import "AccSynthHashMatrix.h"

@implementation AccSynthHashMatrixWrapper

- (void) HashAndInterp2:(int)interpSurf interpSpeed:(float)interpSpeed interpForce:(float)interpForce {
    AccSynthHashMatrix hashMatrix;
    //double x = hashMatrix.HashAndInterp2(interpSurf, interpSpeed, interpForce);
    return;
}
- (int) test:(int)count {
    AccSynthHashTable hashTable;
    int x = hashTable.test(count);
    return x;
}

@end
