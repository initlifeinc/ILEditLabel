//
//  ILCommonKitDemoTests.m
//  ILCommonKitDemoTests
//
//  Created by guodi.ggd on 6/30/15.
//  Copyright (c) 2015 guodi.ggd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ILEditLabel.h"

@interface ILCommonKitDemoTests : XCTestCase

@end

@implementation ILCommonKitDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testEditlabel
{
    ILEditLabel *lb = [[ILEditLabel alloc] init];
    XCTAssertTrue(lb.editEnabled == NO, @"default should be NO");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
