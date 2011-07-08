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
#import "GenericDAO.h"

@interface PersonDAO : GenericDAO {
    
}
- (void)getPersonsWithLocalisationForDomaine:(NSString *) domaineName;
    
@end
