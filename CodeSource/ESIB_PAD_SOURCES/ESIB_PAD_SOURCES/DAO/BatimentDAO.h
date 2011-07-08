//
//  BatimentDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 01.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDAO.h"

@interface BatimentDAO : GenericDAO {
    
}
- (void)getBatimentWithLocalisationForDomaine:(NSString *) domaineName;

@end
