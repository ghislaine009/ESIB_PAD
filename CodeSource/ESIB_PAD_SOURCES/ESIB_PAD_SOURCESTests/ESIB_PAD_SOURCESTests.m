//
//  ESIB_PAD_SOURCESTests.m
//  ESIB_PAD_SOURCESTests
//
//  Created by Elias Medawar on 21.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "ESIB_PAD_SOURCESTests.h"

@implementation ESIB_PAD_SOURCESTests

- (void)setUp
{
    [super setUp];
    setToTest = [[SettingsDAO alloc] init];
    STAssertNotNil(setToTest,@"Created object is nil" );
    // Set-up code here.
}

- (void)tearDown
{
    [setToTest release];
    
    [super tearDown];
}
-(void)testSettings{
    NSLog(@"Testing the settings DAO");
    setToTest.login = @"TestLogin";
    setToTest.pasword=@"Test password";
    setToTest.url=@"https://www.medawar.org";
    setToTest.retenir=YES;
    setToTest.refreshCacheEvery =[NSNumber numberWithInt:4];
    
    [setToTest save];
    [setToTest loadValues];
    STAssertEqualObjects(setToTest.login,@"TestLogin", @"The login value was not saved!");
    STAssertEqualObjects(setToTest.pasword,@"Test password", @"The password value was not saved!");
    STAssertEqualObjects(setToTest.url,@"https://www.medawar.org", @"The url value was not saved!");
    STAssertTrue(setToTest.retenir,@"The retain value was not saved!");
}
@end
