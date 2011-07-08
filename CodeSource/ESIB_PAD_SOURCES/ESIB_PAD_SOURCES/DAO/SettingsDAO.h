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
     The last time of loading personne cache information
     */
    NSDate * lastUpPerson;
    /**
     The last time of loading salle cache information
     */
    NSDate * lastUpSalle;
    /**
     The last time of loading campus cache information
    */
    NSDate * lastUpCampus;
    /**
     The last time of loading batiment cache information
     */
    NSDate * lastUpBatiment;
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
@property(nonatomic ,retain) NSDate * lastUpPerson;
@property(nonatomic ,retain) NSDate * lastUpCampus;
@property(nonatomic ,retain) NSDate * lastUpSalle;
@property(nonatomic ,retain) NSDate * lastUpBatiment;


@property(nonatomic ,retain) NSNumber * refreshCacheEvery;

/**
 * Save the content of vars to the file system
 */
-(void) save;
/**
 * Load the value from the fileSystem
 */
-(void) loadValues;
-(void) reset;



@end
