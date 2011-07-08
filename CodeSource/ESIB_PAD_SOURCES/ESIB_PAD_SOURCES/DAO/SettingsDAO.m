//
//  SettingsDAO.m
//  ESIB@PAD
//
//  Created by Elias Medawar on 17.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "SettingsDAO.h"


@implementation SettingsDAO
@synthesize defaultURL;
@synthesize url;
@synthesize pasword;
@synthesize login;
@synthesize retenir;
@synthesize mapType,lastUpPerson,refreshCacheEvery,lastUpSalle,lastUpCampus,lastUpBatiment;

- (id)init {
    self = [super init];
    if (self) {
        NSFileManager *defFM = [NSFileManager defaultManager];
        
        /**
         * The Settings.plist file must be in the Documents folder on the device to be writible
         * if this file is not there we will move it to the /Documents location.
         * For debuging, the Document file can be readed in / Users/userName/Library/Application Support/iPhone Simulator/4.3/Applications/5325636F-EF07-4DEB-A1AB-D1A0E6F2243D/Documents
         */
        NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        NSString *dest = [docsDir stringByAppendingPathComponent: @"Settings.plist"];

        if( ![defFM fileExistsAtPath:dest] )	//..do this only once after install..
        {
            [defFM removeItemAtPath:dest error:NULL];

            NSString *path = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
            
            [defFM copyItemAtPath: path toPath: dest error: NULL];

        }
        [self loadValues];
    }
    return self;
}

-(void) loadValues{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *path = [docsDir stringByAppendingPathComponent: @"Settings.plist"];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    self.defaultURL = [plistDict objectForKey:@"defaultURL"];
    self.login = [plistDict objectForKey:@"login"];
    self.pasword = [plistDict objectForKey:@"password"];
    
    NSString  *a = [plistDict objectForKey:@"retain"];
    if([a isEqual:@"YES"]){
        self.retenir =YES;
    }else{
        self.retenir = NO;
    }
    self.mapType = [plistDict objectForKey:@"mapType"];
    self.url = [plistDict objectForKey:@"url"];
    self.lastUpPerson = [plistDict objectForKey:@"lastUpPerson"];
    self.lastUpSalle = [plistDict objectForKey:@"lastUpSalle"];
    self.lastUpCampus = [plistDict objectForKey:@"lastUpCampus"];
    self.lastUpBatiment = [plistDict objectForKey:@"lastUpBatiment"];

    self.refreshCacheEvery = [plistDict objectForKey:@"refreshCacheEvery"];

    [plistDict release];

}
-(void) save{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,
                                                         NSUserDomainMask, YES); 
    NSString *path =[[paths objectAtIndex: 0] stringByAppendingPathComponent: @"Settings.plist"];
    
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    [plistDict setValue:login forKey:@"login"];
    [plistDict setValue:pasword forKey:@"password"];
    if(retenir){
        [plistDict setValue:@"YES" forKey:@"retain"];
    }else{
        [plistDict setValue:@"NO" forKey:@"retain"];

    }
    [plistDict setValue:mapType forKey:@"mapType"];
    [plistDict setValue:url forKey:@"url"];
    [plistDict setValue:lastUpPerson forKey:@"lastUpPerson"];
    [plistDict setValue:lastUpSalle forKey:@"lastUpSalle"];
    [plistDict setValue:lastUpCampus forKey:@"lastUpCampus"];
    [plistDict setValue:lastUpBatiment forKey:@"lastUpBatiment"];


    [plistDict setValue:refreshCacheEvery forKey:@"refreshCacheEvery"];


    [plistDict writeToFile:path atomically: YES];
    [plistDict release];
    [self loadValues];
}
-(void)reset{
    NSFileManager *defFM = [NSFileManager defaultManager];
    
    /**
     * The Settings.plist file must be in the Documents folder on the device to be writible
     * if this file is not there we will move it to the /Documents location.
     * For debuging, the Document file can be readed in / Users/userName/Library/Application Support/iPhone Simulator/4.3/Applications/5325636F-EF07-4DEB-A1AB-D1A0E6F2243D/Documents
     */
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dest = [docsDir stringByAppendingPathComponent: @"Settings.plist"];
    [defFM removeItemAtPath:dest error:NULL];
        
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
        
    [defFM copyItemAtPath: path toPath: dest error: NULL];
    [self loadValues];
    NSLog(@"%d",[self.refreshCacheEvery intValue]);

}
- (void)dealloc
{   
    [login release];
    [pasword release];
    [url release];
    [defaultURL release];
    [mapType release];
    [lastUpSalle release];
    [lastUpPerson release];
    [lastUpCampus release];
    [lastUpBatiment release];
    [super dealloc];
}
@end
