//
//  SettingsDAO.h
//  ESIB@PAD
//
//  Created by Elias Medawar on 17.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Class for accessing to the settings
 */
@interface SettingsDAO : NSObject {
    /**
     The defaultURL used for resiting valuses
     */
    NSString * defaultURL;
    /**
     The URL of the webservice
     */
    NSString * url;
    /**
     The password of the user
     */
    NSString * pasword;
    /** 
     The login name of the user
     */
    NSString * login;
    /**
     This boolean indiquate the system to save or not the login and password inforamtion
     */
    BOOL retenir;
    /**
     The type of map to display sat is satelite view, plan is the plan view 
     */
    NSString * mapType;
    /**
     The last time of loading a data from the server
     */
    NSMutableDictionary * listOfUpdatedTime;
    /**
     The number of days before refresh cach information
     */
    NSNumber * refreshCacheEvery;
}
@property(nonatomic ,retain) NSString *defaultURL;
@property(nonatomic ,retain) NSString * url;
@property(nonatomic ,retain) NSString * pasword;
@property(nonatomic ,retain) NSString * login;
@property(nonatomic ,assign) BOOL retenir;
@property(nonatomic ,retain) NSString * mapType;
@property(nonatomic ,retain) NSMutableDictionary * listOfUpdatedTime;


@property(nonatomic ,retain) NSNumber * refreshCacheEvery;

/**
    Save the content of vars to the file system
 */
-(void) save;
/**
  Load the value from the fileSystem
 */
-(void) loadValues;

/**
    Reset the initial data of the settings
    This function reset the cache information at the same tiem
 */
-(void) reset;

/**
    Save the time of the modification for a key.
    This values are used to determine if data in cache are valid.
    @param

 */
-(void)setLastUpdateTimeForKey:(NSString *) theKey lastUpdate:(NSDate *) uptime;

/**
    Get the time of the modification for a key.
    This values are used to determine if data in cache are valid.
 */
-(NSDate *)getLastUpdateTimeForKey:(NSString *) theKey;



@end
