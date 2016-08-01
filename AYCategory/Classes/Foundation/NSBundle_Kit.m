//
//  NSBundle_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSBundle_Kit.h"

#define CONST_IMP(KEY) NSString * const KEY = @#KEY;
CONST_IMP(AYBundleIdentifier);
CONST_IMP(AYBundleShortVersionString);
CONST_IMP(AYBundleVersion);
CONST_IMP(AYBundleName);
CONST_IMP(AYBundlePlatformName);
CONST_IMP(AYBundleSDKName);
CONST_IMP(AYBundleMinimumOSVersion);
CONST_IMP(AYBundleLaunchStoryboardName);
CONST_IMP(AYBundleMainStoryboardFile);
CONST_IMP(AYBundleSupportedInterfaceOrientations);
#undef IMP

