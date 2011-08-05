//
//  ExamResultTableViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 03.08.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemDelegate.h"
#import "ExamResultDAO.h"
#import "ExamResultCellController.h"

@interface ExamResultTableViewController : UITableViewController<ExamResultDAOProtocol> {
    IBOutlet ExamResultCellController *tmpCell;
    NSArray *_ExamResult;
    NSMutableArray * sections;

    UINib *cellNib;

}

@property (nonatomic, retain) ExamResultCellController *tmpCell;
@property (nonatomic, assign) id <MenuItemDelegate> delegate;
@property (nonatomic, retain) UINib *cellNib;

@end





