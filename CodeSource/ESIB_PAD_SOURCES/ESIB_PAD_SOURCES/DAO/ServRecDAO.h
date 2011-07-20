//
//  ServRecDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 20.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDAO.h"
#import "ServRectora.h"

@protocol ServRecDAOProtocol
-(void) consumeListOfRectorat:(NSArray *)servRecList;
@end

@interface ServRecDAO : GenericDAO {
    
}

- (void)getServRec;
@property (retain)  id<ServRecDAOProtocol> delegate;


@end