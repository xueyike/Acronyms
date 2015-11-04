//
//  AcronymsTestUITests.m
//  AcronymsTestUITests
//
//  Created by Yike Xue on 11/3/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface AcronymsTestUITests : XCTestCase

@end

@implementation AcronymsTestUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSearchValid {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *pleaseInputAnAcronymHereTextField = app.textFields[@"Please Input An Acronym Here"];
    [pleaseInputAnAcronymHereTextField tap];
    [pleaseInputAnAcronymHereTextField typeText:@"FF"];
    [app.navigationBars[@"AcronymSearch"].buttons[@"Search"] tap];
    [app.tables.staticTexts[@"filtration fraction"] tap];
    [app.navigationBars[@"ResultDetailView"].buttons[@"Search"] tap];
    
}

- (void)testSearchInvalid {
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *pleaseInputAnAcronymHereTextField = app.textFields[@"Please Input An Acronym Here"];
    [pleaseInputAnAcronymHereTextField tap];
    [pleaseInputAnAcronymHereTextField typeText:@"F"];
    
    XCUIElement *searchButton = app.navigationBars[@"AcronymSearch"].buttons[@"Search"];
    [searchButton tap];
    [pleaseInputAnAcronymHereTextField tap];
    
    XCUIElement *deleteKey = app.keys[@"delete"];
    [deleteKey tap];
    [deleteKey tap];
    [searchButton tap];
    
}

@end
