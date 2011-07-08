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

@interface SalleDAO : GenericDAO {

}
- (void)getSallesWithLocalisationForDomaine:(NSString *) domaineName;
@end
