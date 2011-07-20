//
//  NewsDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 05.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDAO.h"

@protocol NewsDADProtocol 
-(void) displayNews: (NSArray *)listOfNews;
@end

@interface NewsDAO : GenericDAO {
    
}
@property (retain)  id<NewsDADProtocol> delegate;

- (void)getNews;

@end
