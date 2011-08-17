//
//  SalleDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Salle.h"
#import "GenericDAO.h"
/**
 This protocol have to be implemented by objects how want to consume async returned resul of this DAO.
 */
@protocol SalleDAOProtocol
/**
 This function will be called at the end of async loading of the data
 The delegate object have to implement this function.

 @param salleArray is a list of object of type Salle.
 */
-(void) displaySallesList: (NSArray *)salleArray;
@end


/**
 This class allow acces to the salle information
 */
@interface SalleDAO : GenericDAO {

}
@property (retain)  id<SalleDAOProtocol> delegate;
/**
 Return the salles for a sprecifique domaine
 @param domainName is the domaine code in the DB. 
 */
- (void)getSallesWithLocalisationForDomaine:(NSString *) domaineName;
@end

