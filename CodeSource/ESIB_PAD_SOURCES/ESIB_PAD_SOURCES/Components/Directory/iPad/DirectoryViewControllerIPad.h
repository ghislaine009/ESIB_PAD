//
//  DirectoryViewControllerIPad.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 15.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainFilterTableViewController.h"
#import "SubMenuFilterTableViewController.h"
#import "DirectoryDisplayerProtocol.h"
#import "RectoServTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DirectoryViewControllerIPad : UIViewController<DirectoryDisplayerProtocol> {
    IBOutlet UITableView * mainMenuFilter;
    IBOutlet UITableView * subMenuFilter;
    IBOutlet UITableView * contactList;
    IBOutlet UISearchBar * srchBar;
    IBOutlet UILabel * mainTitle;
    IBOutlet UILabel * subTitle;

    IBOutlet UIView * backView;
    IBOutlet UILabel * mainChoise;
    CGRect mainBeforeModif;
    CGRect subBeforeModif;
    CGRect backBeforeModif;
    SubMenuFilterTableViewController *subCtrl;
    IBOutlet UIActivityIndicatorView *loading;

}
@property (nonatomic,retain)  UITableView * mainMenuFilter;
@property (nonatomic,retain)  UITableView * subMenuFilter;
@property (nonatomic,retain)  UIView * backView;
@property (nonatomic,retain) UITableView * contactList;
@property (nonatomic,retain)  UISearchBar * srchBar;
@property (nonatomic, retain)  UIActivityIndicatorView *loading;


- (IBAction)displayMainMenuFromButton:(id)sender;




@property (nonatomic,retain)  UILabel * mainChoise;

@end
