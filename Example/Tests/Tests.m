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

- (void)testURLKit{
    NSString *domain = @"http://example.com/index";
    NSString *url = @"http://example.cn/province?name=广东省";
    NSURL *url1 = [NSURL URLWithString:url relativeToURL:[NSURL URLWithString:domain]];
    XCTAssert(!url1, @"使用系统的不能正常转");
    
    NSURL *url2 = [NSURL ay_URLWithString:url relativeToURL:[NSURL URLWithString:domain]];
    XCTAssert([url2.absoluteString isEqualToString:@"http://example.cn/province?name=%E5%B9%BF%E4%B8%9C%E7%9C%81"]);
 
    NSDictionary *content = @{
                              @"hello": @"world"
                              };
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/中文路径/文件名.plist"];
    
    NSURL *systemFileUrl = [NSURL fileURLWithPath:path];
    [content writeToURL:systemFileUrl atomically:YES];
    
    NSURL *fileUrl = [NSURL ay_URLWithString:[@"file://" stringByAppendingString:path]];
    XCTAssert([fileUrl.absoluteString isEqualToString:systemFileUrl.absoluteString]);
    
    NSDictionary *read = [NSDictionary dictionaryWithContentsOfURL:fileUrl];
    NSLog(@"%@", read);
    [read isEqualToDictionary:content];
}

- (void)testEncode{
    NSString *encodeURL = [@"http://www.baidu.com/aaa?abc=aaa&&name=广东省" ay_URLEncodingWithEncoding:NSUTF8StringEncoding];
    XCTAssert([encodeURL isEqualToString:@"http://www.baidu.com/aaa?abc=aaa&&name=%E5%B9%BF%E4%B8%9C%E7%9C%81"]);
    NSString *doubleEncodeURL = [encodeURL ay_URLEncodingWithEncoding:NSUTF8StringEncoding];
    XCTAssert([doubleEncodeURL isEqualToString:@"http://www.baidu.com/aaa?abc=aaa&&name=%25E5%25B9%25BF%25E4%25B8%259C%25E7%259C%2581"]);
    
    NSString *originString = @";;//??::@@&&==++$$,,--__..!!~~**``''(())#广东省[[]]>><<!@#$%^&*()_+}{;'；：「「」」";
    NSString *encodeOriginString = [originString ay_URLEncodingWithEncoding:NSUTF8StringEncoding];
    NSString *doubleEncodeOriginString = [encodeOriginString ay_URLEncodingWithEncoding:NSUTF8StringEncoding];
    
    XCTAssert([encodeOriginString isEqualToString:@";;//??::@@&&==++$$,,--__..!!~~**%60%60''(())#%E5%B9%BF%E4%B8%9C%E7%9C%81%5B%5B%5D%5D%3E%3E%3C%3C!@#$%25%5E&*()_+%7D%7B;'%EF%BC%9B%EF%BC%9A%E3%80%8C%E3%80%8C%E3%80%8D%E3%80%8D"]);
    XCTAssert([doubleEncodeOriginString isEqualToString:@";;//??::@@&&==++$$,,--__..!!~~**%2560%2560''(())#%25E5%25B9%25BF%25E4%25B8%259C%25E7%259C%2581%255B%255B%255D%255D%253E%253E%253C%253C!@#$%2525%255E&*()_+%257D%257B;'%25EF%25BC%259B%25EF%25BC%259A%25E3%2580%258C%25E3%2580%258C%25E3%2580%258D%25E3%2580%258D"]);
    
    
    
    NSString *encodeComponentURL = [@"http://www.baidu.com/aaa?abc=aaa&&name=广东省" ay_URLComponentEncodingWithEncoding:NSUTF8StringEncoding];
    XCTAssert([encodeComponentURL isEqualToString:@"http%3A%2F%2Fwww.baidu.com%2Faaa%3Fabc%3Daaa%26%26name%3D%E5%B9%BF%E4%B8%9C%E7%9C%81"]);
    NSString *doubleEncodeComponentURL = [encodeComponentURL ay_URLComponentEncodingWithEncoding:NSUTF8StringEncoding];
    XCTAssert([doubleEncodeComponentURL isEqualToString:@"http%253A%252F%252Fwww.baidu.com%252Faaa%253Fabc%253Daaa%2526%2526name%253D%25E5%25B9%25BF%25E4%25B8%259C%25E7%259C%2581"]);

    NSString *encodeComponentOriginString = [originString ay_URLComponentEncodingWithEncoding:NSUTF8StringEncoding];
    NSString *doubleEncodeComponentOriginString = [encodeComponentOriginString ay_URLComponentEncodingWithEncoding:NSUTF8StringEncoding];
    XCTAssert([encodeComponentOriginString isEqualToString:@"%3B%3B%2F%2F%3F%3F%3A%3A%40%40%26%26%3D%3D%2B%2B%24%24%2C%2C--__..!!~~**%60%60''(())%23%E5%B9%BF%E4%B8%9C%E7%9C%81%5B%5B%5D%5D%3E%3E%3C%3C!%40%23%24%25%5E%26*()_%2B%7D%7B%3B'%EF%BC%9B%EF%BC%9A%E3%80%8C%E3%80%8C%E3%80%8D%E3%80%8D"]);
    XCTAssert([doubleEncodeComponentOriginString isEqualToString:@"%253B%253B%252F%252F%253F%253F%253A%253A%2540%2540%2526%2526%253D%253D%252B%252B%2524%2524%252C%252C--__..!!~~**%2560%2560''(())%2523%25E5%25B9%25BF%25E4%25B8%259C%25E7%259C%2581%255B%255B%255D%255D%253E%253E%253C%253C!%2540%2523%2524%2525%255E%2526*()_%252B%257D%257B%253B'%25EF%25BC%259B%25EF%25BC%259A%25E3%2580%258C%25E3%2580%258C%25E3%2580%258D%25E3%2580%258D"]);
}

- (void)testEncodeURL{
    // 一部份转了码，一部份没转码
    NSString *string = @"http://www.baidu.com/aaa?abc=aaa&&name=%E5%B9%BF%E4%B8%9C%E7%9C%81&password=我爱中国";
    NSURL *url = [NSURL ay_URLWithString:string relativeToURL:[NSURL URLWithString:@"http://www.example.com"]];

    NSLog(@"%@", url);
        
}

- (void)testUUID{
    NSString *uuid = [NSString ay_uuidString];
    NSLog(uuid, nil);
}

- (void)test3Des{
    NSString *encodedStr = @"Wefm6vKOrnQiOB0wa519C6I4ItVd0zIFKXHeeqa07pv8hbkC3e6kRLxSpnWYIKIchNkK1tSTOxMRDFF7tdL7i7xSpnWYIKIcsSHs0l/THq+GAHGIbXF3Q3Fw+mivbTXZENkHmQt29rdqenSCDUwybbxSpnWYIKIcvFKmdZggohwr5WcQtufdoQkn2xQ5z+zsvFKmdZggohwv0PtTjyxx1tzl7G4oQt5WvFKmdZggohy8UqZ1mCCiHKilVCRnftBL5hLf+mY2610mYtBtchol/LxSpnWYIKIcdq1cVBvPsMm8UqZ1mCCiHD8NWcef9I0sIw9sswVkfJwaUw0JSvAzasTKMQIUcV6BvFKmdZggohy8UqZ1mCCiHMIAQ119thm6GfKUuf1IIc9/Ikt4qosfOalPucfguj9SvFKmdZggohy8UqZ1mCCiHBDpSxA+DITGCPx1Gb0bN4v40XxABgl+4+M33nO3FLMovFKmdZggohxBfEfL2i6YhFwGtJ3V/qjKDSkmYsiGJGvZZIKGGqOJXbxSpnWYIKIcvFKmdZggohxBfEfL2i6YhNd6bjG5MnqVvFKmdZggohy8UqZ1mCCiHLST0D1PEzhDvFKmdZggohx0jQnfxoSzyXX695UtGj02f9//fITLyLAhSBQt4bGAPAkn2xQ5z+zsRxP+ArJ6BOg7gt9KEz52lrxSpnWYIKIcNqnNCaAymZb986SmL5PaVNUp3JmJkuJDvFKmdZggohzehAhQGJ/dbTUKseSEz6kzJOhmFbOH6Hp+yufttTcRh7xSpnWYIKIcZhl2GJgfHsjQ+5TamJgQ/KZFAcZM9op4";
    
    NSString *key = @"pHywmA5KivEqN7x/Qz0jCzjca8dKYceM";
    
    NSString *result = [encodedStr ay_3DESDecryptWithKeyData:key.ay_base64DecodedData];
    
    NSLog(@"%@", result);
}
@end

