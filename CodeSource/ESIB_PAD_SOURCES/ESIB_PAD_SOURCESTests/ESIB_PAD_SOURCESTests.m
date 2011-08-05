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
    [self waitForEnableConnection];
    CampusDAO * cDao = [[CampusDAO alloc ]init];
    cDao.delegate = self;
    NSLog(@"Loading async the campus data from internet");
    finishAsyncOperation = NO;
    dataRecieved = NO;
    [cDao getCampusAndDisplayOnMap];

    NSDate *someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    while(!finishAsyncOperation){
        [[NSRunLoop currentRunLoop] runUntilDate:someSecondsFromNow];
        someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    }
    STAssertTrue([listFirstCall count]!=0, @"No data geted form the net");
    STAssertTrue([listSeconCall count]!=0, @"No data in cache");
    
    STAssertTrue([listFirstCall count]==[listSeconCall count], @"The data number of data in cache is not the same that those online");
    int i=0;
    for (Campus * c in listSeconCall) {
        STAssertEqualObjects(c, [ listFirstCall objectAtIndex:i], @"The campus data in cache are not the same that those online");
        i++;
    }  
    [cDao release]; 
}
-(void)testNews{
    

    NSLog(@"Testing the News DAO: You must uninstall or reset cache of the application before testing");
    [self waitForEnableConnection];
    NewsDAO * nDao = [[NewsDAO alloc ]init];
    nDao.delegate = self;
    NSLog(@"Loading async the news data from internet");
    finishAsyncOperation = NO;
    dataRecieved = NO;
    [nDao getNews];
    NSDate *someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    while(!finishAsyncOperation){
        [[NSRunLoop currentRunLoop] runUntilDate:someSecondsFromNow];
        someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    }
    STAssertTrue([listFirstCall count]!=0, @"No data geted form the net");
    STAssertTrue([listSeconCall count]!=0, @"No data in cache");
    
    STAssertTrue([listFirstCall count]==[listSeconCall count], @"The data number of data in cache is not the same that those online");
    int i=0;
    for (Actualite * c in listSeconCall) {
        STAssertEqualObjects([c titre], [[ listFirstCall objectAtIndex:i] titre], @"The news title in cache are not the same that those online");
        i++;
    }  
    [nDao release]; 
}
-(void) waitForEnableConnection{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enable your internet connection now(You have 30 sec to do it!!!)" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    [alert release];    
    NSDate *someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:30.0];
    [[NSRunLoop currentRunLoop] runUntilDate:someSecondsFromNow];

}
-(void) waitForDisableConnection{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please disable your internet connection now(You have 30 sec to do it!!!)" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    [alert release];   
    NSDate *someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:30.0];
    [[NSRunLoop currentRunLoop] runUntilDate:someSecondsFromNow];
    
}
-(void) displayNews: (NSArray *)listOfNews{
    if(dataRecieved){
        listSeconCall = listOfNews;     
        finishAsyncOperation =YES;
        
    }else{
        NSLog(@"DATA recieved");
        listFirstCall = [listOfNews retain];
        [condition signal];
        dataRecieved = YES;
        [self waitForDisableConnection];
        NewsDAO * cDao = [[NewsDAO alloc ]init];
        cDao.delegate = self;
        [cDao getNews];
    }

}
-(void) displayPersonList: (NSArray *)personArray{
    
}
-(void) displaySallesList: (NSArray *)salleArray{
    
}
-(void) displayPersonOnMap:(Person *)person{
    
}
-(void) displaySalleOnMap:(Salle *)salle{
    
}
-(void) displayAllCampusOnMap:(NSArray *)campusArray{
    if(dataRecieved){
        listSeconCall = campusArray;     
        finishAsyncOperation =YES;

    }else{
        NSLog(@"DATA recieved");
        listFirstCall = [campusArray retain];
        [condition signal];
        dataRecieved = YES;

        [self waitForDisableConnection];

        CampusDAO * cDao = [[CampusDAO alloc ]init];
        cDao.delegate = self;
        [cDao getCampusAndDisplayOnMap];
    }
}

-(void)consumeListOfCampus:(NSArray *)arrayOfCampus{
    
}
-(void) displayBatiments:(NSArray *)batimetnsArray{
    
}
-(void) campusSelected:(NSNumber *)selectedCampusIndex{
    
}
-(void) removeListFromTopView{
    
}


@end
