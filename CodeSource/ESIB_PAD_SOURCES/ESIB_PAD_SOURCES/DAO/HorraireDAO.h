//
//  HorraireDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDAO.h"
#import "Horraires.h"
@protocol HorraireDAOProtocol 
-(void) dataLoadedFromInternet;
@end

@interface HorraireDAO : GenericDAO {
}
@property (retain)  id<HorraireDAOProtocol> delegate;

-(void)loadHorraire;

-(NSArray *) getHorraireForDate:(NSDate *) date;
@end
