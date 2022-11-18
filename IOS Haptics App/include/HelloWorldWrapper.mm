//
//  HelloWorldWrapper.mm
//  IOS Haptics App
//
//  Created by user229725 on 11/16/22.
//

#import <Foundation/Foundation.h>

#import "HelloWorldWrapper.h"
#import "HelloWorld.hpp"

@implementation HelloWorldWrapper
- (NSString *) sayHello {
    HelloWorld helloWorld;
    std::string helloWorldMessage = helloWorld.sayHello();
    return [NSString
            stringWithCString:helloWorldMessage.c_str()
            encoding:NSUTF8StringEncoding];
}
@end
