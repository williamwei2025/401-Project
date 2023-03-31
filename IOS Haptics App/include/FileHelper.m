//
//  FileHelper.m
//  IOS Haptics App
//
//  Created by William Wei on 3/28/23.
//

// FileHelper.m
#import <Foundation/Foundation.h>
#import "FileHelper.h"

static const char *getFilePathFromBundle(NSString *filename, NSString *extension) {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:extension];
    
    
    if (fileURL != nil) {
        return strdup([[fileURL path] UTF8String]);
    } else {
        return NULL;
    }
}

const char *getFilePath(const char *filename, const char *extension) {
    NSString *fileNameStr = [NSString stringWithUTF8String:filename];
    NSString *extensionStr = [NSString stringWithUTF8String:extension];
    return getFilePathFromBundle(fileNameStr, extensionStr);
}
