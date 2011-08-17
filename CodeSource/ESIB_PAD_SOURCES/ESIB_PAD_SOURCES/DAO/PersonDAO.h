//
//  PersonnDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 27.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESIB_PAD_SOURCESAppDelegate.h"
#import "Person.h"
#import "InstitutionDAO.h"
#import "GenericDAO.h"

/**
 This protocol have to be implemented by objects how want to consume async returned resul of this DAO.
 */
@protocol PersonDAOProtocol
/**
This function will be called at the end of async loading of the data
The delegate object have to implement this function.
 @param personArray is a list of object of type Person.
 */
-(void) consumeListOfPerson:(NSArray *)personArray;
@end

/**
 This class allow acces to the person information
 */
@interface PersonDAO : GenericDAO {
    
}
/**
 Return the personns with gps coordoniate for a sprecifique domaine
@param domainName is the domaine code in the DB. 
 */
- (void)getPersonsWithLocalisationForDomaine:(NSString *) domaineName;
/**
 Return the personns for a sprecifique domaine
 @param domainName is the domaine code in the DB. 
 */
- (void)getPersonsForDomaine:(NSString *)domaineName;
/**
 Return the personns for a sprecifique institution
 @param domainName is the institution code in the DB. 
 */
- (void)getPersonsForInstitution:(NSString *)instCode;

/**
 The delegate objet will be notified with the results.
 */
@property (retain)  id<PersonDAOProtocol> delegate;

@end
