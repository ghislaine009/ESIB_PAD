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
  }

- (void)tearDown
{
    
    [super tearDown];
}
-(void)testSettings{
    SettingsDAO * setToTest = [[SettingsDAO alloc] init];
    STAssertNotNil(setToTest,@"Created object is nil" );
        // Set-up code here.

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
    [setToTest reset];
    [setToTest release];

}


-(void)testCarte{
    NSLog(@"Testing the Campus DAO: You must uninstall or reset cache of the application before testing");
    CampusDAO * cDao = [[CampusDAO alloc ]init];
    cDao.delegate = self;
    NSLog(@"Loading async the campus data from internet");
    [cDao getCampusListAndDisplay];
    NSDate *someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    while(!finishListCampus){
        [[NSRunLoop currentRunLoop] runUntilDate:someSecondsFromNow];
        someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    }
    STAssertTrue([listCampus count]!=0, @"No data geted form the net");
    STAssertTrue([listCampus2 count]!=0, @"No data in cache");
    
    STAssertTrue([listCampus count]==[listCampus2 count], @"The data number of data in cache is not the same that those online");
    int i=0;
    for (Campus * c in listCampus2) {
        STAssertEqualObjects(c, [ listCampus objectAtIndex:i], @"The campus data in cache are not the same that those online");
        i++;
    }  
    [cDao release]; 
}
-(void) displayPersonList: (NSArray *)personArray{
    
}
-(void) displaySallesList: (NSArray *)salleArray{
    
}
-(void) displayPersonOnMap:(Person *)person{
    
}
-(void) displaySalleOnMap:(Salle *)salle{
    
}
-(void) displayListOfCampus:(NSArray *)campusArray{
    if(dataRecieved){
        listCampus2 = campusArray;     
        finishListCampus =YES;

    }else{
        NSLog(@"DATA recieved");
        listCampus = [campusArray retain];
        [condition signal];
        dataRecieved = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please disable your internet connection now(You have 30 sec to do it!!!)" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
        NSLog(@"Waiting for 30 sec for disabling the internet connection");

        NSDate *someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:30.0];
        [[NSRunLoop currentRunLoop] runUntilDate:someSecondsFromNow];
        CampusDAO * cDao = [[CampusDAO alloc ]init];
        cDao.delegate = self;
        [cDao getCampusListAndDisplay];
    }
}
-(void) displayAllCampusOnMap:(NSArray *)campusArray{
}

-(void) displayBatiments:(NSArray *)batimetnsArray{
    
}
-(void) campusSelected:(NSNumber *)selectedCampusIndex{
    
}
-(void) removeListFromTopView{
    
}

@end
