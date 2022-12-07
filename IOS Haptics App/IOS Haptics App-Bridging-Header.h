//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import "HelloWorldWrapper.h"
#import "AccSynthHashMatrixWrapper.h"

#ifdef __cplusplus
extern "C" {
#endif

    void *initalize();
    double output(void *object, int interpSurf, float interpSpeed, float interpForce);

#ifdef __cplusplus
}
#endif



 
