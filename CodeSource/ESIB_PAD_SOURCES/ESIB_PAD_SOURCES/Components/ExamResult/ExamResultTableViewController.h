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

/**
 Class that manage the table for displaying the exam results.
 
 */
@interface ExamResultTableViewController : UITableViewController<ExamResultDAOProtocol> {
    /**
     Temporary cell used to the reuse of the Graphique design of the nib compiled file
     */
    IBOutlet ExamResultCellController *tmpCell;
    /**
     Array of data recieved from the DAO and to display.
     */
    NSArray *_ExamResult;
    /**
     The different section. The year field of the data is used to determine the sections.
     */
    NSMutableArray * sections;
    /**
     The nib file of a cell.
     */
    UINib *cellNib;

}

@property (nonatomic, retain) ExamResultCellController *tmpCell;
@property (nonatomic, assign) id <MenuItemDelegate> delegate;
@property (nonatomic, retain) UINib *cellNib;

@end





