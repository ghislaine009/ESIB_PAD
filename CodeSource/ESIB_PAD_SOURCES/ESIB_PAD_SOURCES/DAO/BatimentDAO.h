//
//  BatimentDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 01.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDAO.h"
#import "Batiment.h"
/**
 This protocol have to be implemented by objects how want to consume async returned resul of this DAO.
 */
@protocol BatimentDAOProtocol
@optional
- (void)consumeListOfBatiments:(NSArray *)arrayOfBatiments;
@end

@interface BatimentDAO : GenericDAO {
    
}
@property (retain)  id<BatimentDAOProtocol> delegate;

- (void)getBatimentWithLocalisationForDomaine:(NSString *) domaineName;

@end
