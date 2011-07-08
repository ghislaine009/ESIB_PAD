//
//  CampusDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDAO.h"

@interface CampusDAO : GenericDAO {
    
}
- (void)getCampusListAndDisplay;
- (void)getCampusAndDisplayOnMap;
@end
