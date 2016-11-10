//
//  AYCategoryTests.m
//  AYCategoryTests
//
//  Created by Alan Yeh on 08/01/2016.
//  Copyright (c) 2016 Alan Yeh. All rights reserved.
//

@import XCTest;
#import <AYCategory/AYCategory.h>

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testOptional{
    NSArray *optional_obj1 = nil;
    
    NSArray *obj1 = AYOptional(NSArray, optional_obj1);
    XCTAssert(obj1 != nil && [obj1 isKindOfClass:[NSArray class]]);
    
    NSMutableArray *optional_obj2 = nil;
    NSMutableArray *obj2 = AYOptional(NSMutableArray, optional_obj2);
    XCTAssert(obj2 != nil && [obj2 isKindOfClass:[NSMutableArray class]]);
    
}

@end

