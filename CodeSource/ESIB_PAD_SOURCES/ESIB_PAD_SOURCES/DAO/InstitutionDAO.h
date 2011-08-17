//
//  InstitutionDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 19.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDAO.h"
#import "Institution.h"
/**
 This protocol have to be implemented by objects how want to consume async returned resul of this DAO.
 */
@protocol InstitutionDAOProtocol
-(void) consumeListOfInstitution:(NSArray *)institutionArray;
@end

@interface InstitutionDAO : GenericDAO {
    
}
- (void)getInstitution;

@property (retain)  id<InstitutionDAOProtocol> delegate;

@end

