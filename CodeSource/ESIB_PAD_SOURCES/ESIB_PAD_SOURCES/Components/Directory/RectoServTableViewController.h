//
//  RectoServTableViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 20.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RectServViewController.h"
#import "ServRecDAO.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface RectoServTableViewController : UITableViewController<ServRecDAOProtocol,MFMailComposeViewControllerDelegate> {
    IBOutlet RectServViewController *tmpCell;
    NSMutableArray *_servRec;
    UINib *cellNib;
}
@property (nonatomic, retain) IBOutlet RectServViewController *tmpCell;

@property (nonatomic, retain) UINib *cellNib;

@end
