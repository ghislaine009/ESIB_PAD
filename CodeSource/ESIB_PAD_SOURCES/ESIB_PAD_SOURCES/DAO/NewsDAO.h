//
//  NewsDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 05.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDAO.h"
#import "NewsDisplayerProtocol.h"

@interface NewsDAO : GenericDAO {
    
}

- (void)getNews;

@end
