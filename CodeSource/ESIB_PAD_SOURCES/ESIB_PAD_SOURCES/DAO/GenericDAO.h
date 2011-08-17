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

/**

    This class represent a generic DAP. 
    Hier are regrouped the most common functionality that a DAO using Core-data and cache system
    sould use.
    This class implement the NSXMLParserDelegate protocol and is able to parse XML documents.
 */

@interface GenericDAO : NSObject <NSXMLParserDelegate> {
    /**
     The name of the curent node durring the parsing phase 
     */
    NSString * _crntElementName;
    /**
     The name of the entity in the SQL-Lite DB
     */
    NSString * _entityDescription;  
    /**
     The managedObjectContext allow us to handel the data in the DB 
     */
    NSManagedObjectContext * _managedObjectContext;
    /**
     This array contain the row data loaded of the XML file loaded from internet.
     This data are recievied asynchronous from the internet.
     This object can ben compared to a buffer.
     */
    NSMutableData * receivedData;
    /**
     This is a settingDAO object used to acces to diffierent settings information
     and more specificly at the time of the last execution of a request(Cache)
     */
    SettingsDAO * set;
    /**
     The current object is create when a root(<row> most of the time ) node in the xml file.
     Then the value of this object will be set...
     */
    NSManagedObject * _crntObject;
    /**
     We save the filter option that we will aply to the data recieved asynchronous.
     This value is reused to creat an NSPredicate variable.
     */
    NSString * predicateForReturnValue;
    /**
     We save the filter option data that we will aply to the data recieved asynchronous
     This value is reused to creat an NSPredicate variable.
     */
    NSArray * arrgumentPredicate;
    
    /**
     The current result set
     */
    NSMutableArray * _crntListOfObject;
    /**
     We recive the value of the parser word after word. To obtain all the value,crntCharacters is 
     is used to concatain the all string...
     */
    NSString *crntCharacters;
    /**
     The send param to the server. This value is used as a key to save the time of execution for the
     cache system.
     */
    NSString *postParam;
    /**
     This is a pointer to a fuction to be called we finish to download,parse,and save data. The most
     of time the pointed function return the send to the delegate object the _crntListOfObject as 
     a result of the request.
     */
    SEL afterLoading;
}


@property (nonatomic, retain) NSString * crntElementName;
@property (nonatomic, retain) NSString * entityDescription;
@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, retain) NSMutableData * receivedData;
@property (nonatomic, retain) NSString *crntCharacters;

@property (nonatomic, assign) NSMutableArray * crntListOfObject;

@property (nonatomic, retain) NSManagedObject * crntObject;
@property (nonatomic, retain) SettingsDAO * set;
@property (nonatomic, retain) NSString * predicateForReturnValue;
@property (nonatomic, retain) NSString * postParam;

@property (nonatomic, retain) NSArray * arrgumentPredicate;

@property (nonatomic, assign) SEL afterLoading;


/**
 Initialise the classe with the name of the managed Entity in the DB
 @param EntitiyDescription the name of the managed Entity.
 */
- (id) initWithEntityName:(NSString *)EntitiyDescription;

/**
 Load data from the DB, (dont check if the data are valid in cache)
 The data are loaded from the table with name  :entityDescription
 @param predicate an filter option to aply for the SQL-Lite request
 */
- (NSArray*)getDataFromCacheWithPredicates:(NSPredicate *) predicate;
/**
 Return the number of data in cache
 The data are loaded from the table with name  :entityDescription
 @param listOfPredicate filter option to aply for the SQL-Lite request
 @returns the number of data in the DB with specified predicate
 */
- (int)numberEntityInCacheWithPredicates:(NSPredicate *) listOfPredicate;
/**
 Create the request and send it asynchronous to the server.It define self as delegate for recieving
 the data from internet.
 @param webServicePostHeader the option of the resquest to send to the server. Example:sr=Elias, pwd=1234,op=listeNotes 
 */
- (void) addToCache:(NSString *) webServicePostHeader;
/**
 Remove the data with the specified filteroption
 The data are deleted from the table with name  :entityDescription
 @param listOfPredicate filter option to aply for the SQL-Lite request
 */
- (void) deleteFromCacheWithPredicates:(NSPredicate *) listOfPredicate;

/**
 Test if a data how was executed for the last time at lastUpdateTime is still valid in cache.
 */
- (bool) areDataUpToDate:(NSDate *)lastUpdateTime;
/**
Verify if the recieved text is an error texte
 */

- (bool)verifyError:(NSString *)errorTexte;
/**
 Utility method that test if an alert view is alerdy displayed. 
 @return YES if an alert view is displayed.
 */
- (BOOL) doesAlertViewExist ;
/**
 Important, this function have to be overwrited by you to modifie the comportement when we recieve the data.
 Fonction called by the parser
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
/**
 Important, this function have to be overwrited by you to specifiy the comportement for parsing the xml data.
 Fonction called by the parser
 Typical implementation:
 \code
 if(self.crntCharacters){
     NSString * string = self.crntCharacters;
     if([self.crntCharacters isEqualToString:@""] || [string isEqualToString:@" "] || !string){
     return;
     }
     if( [self verifyError:self.crntCharacters]){
         [parser abortParsing];
         [parser setDelegate:nil];
         return;
     }        
     if([self.crntElementName isEqualToString:@"latitude"]){
         [self.crntObject setValue:[NSNumber numberWithFloat:[string floatValue]] forKey:@"latitude"];
     }
     if([self.crntElementName isEqualToString:@"longitude"]){
         [self.crntObject setValue:[NSNumber numberWithFloat:[string floatValue]] forKey:@"longitude"];
     }
     // Other nodes test ...
     self.crntElementName =@"";        
 }
 if([elementName isEqualToString:@"row"]){
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    return;
 }
 \endcode
 */
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;


@end
