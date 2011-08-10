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
    SettingsDAO * setToTest = [[SettingsDAO alloc] init];
    [setToTest reset];
    tmpHost = [[NSString alloc] initWithString:setToTest.url];
    [setToTest release];

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
    
    SettingsDAO * setToTest = [[SettingsDAO alloc] init];
    [setToTest reset];
    [setToTest release];
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
-(void)testDirectory{
    NSLog(@"Testing the Person DAO for the directory fonctionality: You must uninstall or reset cache of the application before testing");
    [self waitForEnableConnection];
    PersonDAO * cDao = [[PersonDAO alloc ]init];
    cDao.delegate = self;
    NSLog(@"Loading async the directory of the cmapus CST from internet");
    finishAsyncOperation = NO;
    dataRecieved = NO;
    [cDao getPersonsForDomaine:@"CST"];
    
    NSDate *someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    while(!finishAsyncOperation){
        [[NSRunLoop currentRunLoop] runUntilDate:someSecondsFromNow];
        someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    }
    STAssertTrue([listFirstCall count]!=0, @"No data geted form the net");
    STAssertTrue([listSeconCall count]!=0, @"No data in cache");
    
    STAssertTrue([listFirstCall count]==[listSeconCall count], @"The data number of data in cache is not the same that those online");
    int i=0;
    for (Person * c in listSeconCall) {
        STAssertEqualObjects(c , [ listFirstCall objectAtIndex:i], @"The person data in cache are not the same that those online");
        i++;
    }  
    [cDao release]; 
}

-(void)testPlaning{
    SettingsDAO * s = [[SettingsDAO alloc] init];
    s.url =@"http://localhost/Bachelor/ESIB_PAD/CodeSource/webServices/webServices.php";
    [s save];
    tmpHost = @"http://localhost/Bachelor/ESIB_PAD/CodeSource/webServices/webServices.php";

    NSLog(@"Testing the Horraire DAO for the planning  fonctionality: You must uninstall or reset cache of the application before testing");
    [self waitForEnableConnection];
    HorraireDAO * cDao = [[HorraireDAO alloc ]init];
    cDao.delegate = self;
    
    NSLog(@"Loading async the plannong from internet");
    finishAsyncOperation = NO;
    dataRecieved = NO;
    [cDao loadHorraire];
    
    NSDate *someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    while(!finishAsyncOperation){
        [[NSRunLoop currentRunLoop] runUntilDate:someSecondsFromNow];
        someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    }
    
    STAssertTrue([listFirstCall count]==[listSeconCall count], @"The data number of data in cache is not the same that those online");
    int i=0;
    for (Horraires * c in listSeconCall) {
        STAssertEqualObjects(c, [ listFirstCall objectAtIndex:i], @"The planning data in cache are not the same that those online");
        i++;
    }  
    [cDao release]; 
    [s reset];
    [s release];
}

-(void)testExam{
    SettingsDAO * s = [[SettingsDAO alloc] init];
    s.url =@"http://localhost/Bachelor/ESIB_PAD/CodeSource/webServices/webServices.php";
    [s save];
    tmpHost = @"http://localhost/Bachelor/ESIB_PAD/CodeSource/webServices/webServices.php";
    NSLog(@"Testing the Examnination result DAO  fonctionality: You must uninstall or reset cache of the application before testing");
    [self waitForEnableConnection];
    ExamResultDAO * cDao = [[ExamResultDAO alloc ]init];
    cDao.delegate = self;
    
    NSLog(@"Loading async the exam result from internet");
    finishAsyncOperation = NO;
    dataRecieved = NO;
    [cDao getExamResult];
    
    NSDate *someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    while(!finishAsyncOperation){
        [[NSRunLoop currentRunLoop] runUntilDate:someSecondsFromNow];
        someSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:2.0];
    }
    STAssertTrue([listFirstCall count]!=0, @"No data geted form the net");
    STAssertTrue([listSeconCall count]!=0, @"No data in cache");

    STAssertTrue([listFirstCall count]==[listSeconCall count], @"The data number of data in cache is not the same that those online");
    int i=0;
    for (ExamResult * c in listSeconCall) {
        STAssertEqualObjects(c, [ listFirstCall objectAtIndex:i], @"The exam data in cache are not the same that those online");
        i++;
    }  
    [cDao release]; 
    [s reset];
    [s release];
}
-(void) waitForEnableConnection{
    SettingsDAO * setToTest = [[SettingsDAO alloc] init];
    setToTest.url =  tmpHost;
    [setToTest save];
    [setToTest release];
   
}
-(void) waitForDisableConnection{
    SettingsDAO * setToTest = [[SettingsDAO alloc] init];
    tmpHost = [setToTest.url retain];
    setToTest.url = @"http://none";
    [setToTest save];
    [setToTest release];
    
}
-(void)displayExamResult:(NSArray *)listOfExam{
    if(dataRecieved){
        listSeconCall = [listOfExam retain];     
        finishAsyncOperation =YES;
        
    }else{
        NSLog(@"Recievied async the  Exam data");
        SettingsDAO * s = [[SettingsDAO alloc] init];
        s.url =@"http://localhost/Bachelor/ESIB_PAD/CodeSource/webServices/webServices.php";
        [s save];
        tmpHost = @"http://localhost/Bachelor/ESIB_PAD/CodeSource/webServices/webServices.php";
        [s release];
        listFirstCall = [listOfExam retain];
        [condition signal];
        dataRecieved = YES;
        [self waitForDisableConnection];
        ExamResultDAO * cDao = [[ExamResultDAO alloc ]init];
        cDao.delegate = self;
        [cDao getExamResult];
        [cDao release];
    }
}
-(void) displayNews: (NSArray *)listOfNews{
    if(dataRecieved){
        listSeconCall = [listOfNews retain];     
        finishAsyncOperation =YES;
        
    }else{
        NSLog(@"Recievied async the news DATA");
        listFirstCall = [listOfNews retain];
        [condition signal];
        dataRecieved = YES;
        [self waitForDisableConnection];
        NewsDAO * cDao = [[NewsDAO alloc ]init];
        cDao.delegate = self;
        [cDao getNews];
        [cDao release];
    }

}
-(void) consumeListOfPerson:(NSArray *)personArray{
    if(dataRecieved){
        listSeconCall = [personArray retain];     
        finishAsyncOperation =YES;
        
    }else{
        NSLog(@"List of person recieved");
        listFirstCall = [personArray retain];
        [condition signal];
        dataRecieved = YES;
        [self waitForDisableConnection];
        PersonDAO * cDao = [[PersonDAO alloc ]init];
        cDao.delegate = self;
        [cDao getPersonsForDomaine:@"CST"]; 
        [cDao release];
    }
}
-(void) planningDataLoadedFromInternet{
    if(dataRecieved){
        HorraireDAO * cDao = [[HorraireDAO alloc ]init];
        NSDate * d  = [NSDate date];
        listSeconCall = [[cDao getHorraireForDate:d] retain];
        finishAsyncOperation =YES;
        
    }else{
        NSLog(@"Recievied async the planning from internet");
        SettingsDAO * s = [[SettingsDAO alloc] init];
        s.url =@"http://localhost/Bachelor/ESIB_PAD/CodeSource/webServices/webServices.php";
        [s save];
        tmpHost = @"http://localhost/Bachelor/ESIB_PAD/CodeSource/webServices/webServices.php";
        [s release];
        HorraireDAO * cDao = [[HorraireDAO alloc ]init];
        [cDao setDelegate:self];
        NSDate * d  = [NSDate date];
        listFirstCall = [[cDao getHorraireForDate:d] retain];
        [condition signal];
        dataRecieved = YES;
        [self waitForDisableConnection];
        [cDao loadHorraire];
        [cDao release];
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
        listSeconCall = [campusArray retain];     
        finishAsyncOperation =YES;

    }else{
        NSLog(@"Recievied async the Campus DATA");
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
