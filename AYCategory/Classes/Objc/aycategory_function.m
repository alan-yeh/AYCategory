//
//  AYPrintf.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "aycategory_function.h"
#import <libkern/OSAtomic.h>

void AYPrintf(NSString *format, ...){
    static OSSpinLock aspect_lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&aspect_lock);
    
    __block va_list params;
    va_start(params, format);
    printf([[NSString alloc] initWithFormat:format arguments:params].UTF8String, NULL);
    va_end(params);
    
    OSSpinLockUnlock(&aspect_lock);
}