//
//  HelloWorldTests.m
//  HelloWorldTests
//
//  Created by Michael Mühlebach on 10/02/14.
//  Copyright (c) 2014 Zühlke. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface HelloWorldTests : XCTestCase

@end

@implementation HelloWorldTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
