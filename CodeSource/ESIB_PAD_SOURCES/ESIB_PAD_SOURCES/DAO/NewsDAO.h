//
//  NewsDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 05.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDAO.h"
/**
 This protocol have to be implemented by objects how want to consume async returned resul of this DAO.
 */
@protocol NewsDADProtocol 
-(void) displayNews: (NSArray *)listOfNews;
@end

@interface NewsDAO : GenericDAO {
    
}
@property (retain)  id<NewsDADProtocol> delegate;
/**
 Return the news if the system is able to connect to internet, cache data will be ignored
 */
- (void)getNews;

@end
