//
//  ContactDetailTableViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactViewCellController.h"
#import "Person.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

/**
 manage the view for displaing the detail about one personne.
 */
@interface ContactDetailTableViewController : UITableViewController<MFMailComposeViewControllerDelegate,UIAlertViewDelegate> {
    IBOutlet ContactViewCellController *tmpCell;
    UINib *cellNib;
    Person * personInformation;
}
- (id) initWithForThisPerson:(Person *) p;

@property (nonatomic, retain) IBOutlet ContactViewCellController *tmpCell;

@property (nonatomic, retain) UINib *cellNib;

@end
