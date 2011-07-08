//
//  GenericDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESIB_PAD_SOURCESAppDelegate.h"
#import "Salle.h"
#import "SettingsDAO.h"
#import "MapDisplayerDelegate.h"

@interface GenericDAO : NSObject <NSXMLParserDelegate> {
    NSString * _crntElementName;
    NSString * _entityDescription;  
    NSManagedObjectContext * _managedObjectContext;
    NSMutableData * receivedData;
    SettingsDAO * set;
    NSManagedObject * _crntObject;
    NSArray * predicateForReturnValue;
    NSMutableArray * _crntListOfObject;
    NSString *crntCharacters;
    SEL afterLoading;
}

@property (retain)  id delegate;

@property (nonatomic, retain) NSString * crntElementName;
@property (nonatomic, retain) NSString * entityDescription;
@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, retain) NSMutableData * receivedData;
@property (nonatomic, retain) NSString *crntCharacters;

@property (nonatomic, assign) NSMutableArray * crntListOfObject;

@property (nonatomic, retain) NSManagedObject * crntObject;
@property (nonatomic, retain) SettingsDAO * set;
@property (nonatomic, retain) NSArray * predicateForReturnValue;


- (id) initWithEntityName:(NSString *)EntitiyDescription;
- (void)returnResponse;
- (NSArray*)getDataFromCacheWithPredicates:(NSArray *)listOfPredicate;
- (int)numberEntityInCacheWithPredicates:(NSArray *)listOfPredicate;
- (void) addToCache:(NSString *) webServicePostHeader;
- (void) deleteFromCacheWithPredicates:(NSArray *)listOfPredicate;
- (bool) areDataUpToDate:(NSDate *)lastUpdateTime;
- (bool)verifyError:(NSString *)errorTexte;
@end