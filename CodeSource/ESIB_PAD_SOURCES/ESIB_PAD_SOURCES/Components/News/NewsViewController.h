//
//  NewsViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 05.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemDelegate.h"
#import "NewsDAO.h"
#import "AsyncImageView.h"
#import "NewsCellViewController.h"
/**
 Responsible to display news.
 */
@interface NewsViewController : UITableViewController<NewsDADProtocol> {
	IBOutlet NewsCellViewController *tmpCell;
    NSMutableArray *_news;
    NSMutableArray *_newsImage;
    UINib *cellNib;

}
@property (nonatomic, retain) IBOutlet NewsCellViewController *tmpCell;

@property (nonatomic, assign) id <MenuItemDelegate> delegate;
@property (nonatomic, retain) UINib *cellNib;

@end
