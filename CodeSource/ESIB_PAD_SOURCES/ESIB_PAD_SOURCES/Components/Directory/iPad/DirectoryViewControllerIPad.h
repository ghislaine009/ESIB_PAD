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


/**
 Class responsible to manage the view of the directory part of the application on the iPad
 Implement the DirectoryDisplayerProtocol and here different methode.
 */
@interface DirectoryViewControllerIPad : UIViewController<DirectoryDisplayerProtocol> {
    /**
     The table on the left with the main menu
     */
    IBOutlet UITableView * mainMenuFilter;
    /**
     The table on the left with the submenu options.
     Will bee loaded on click on the mainMenuFilter.
     */
    IBOutlet UITableView * subMenuFilter;
    /**
     The main table with the list of all result.
     */
    IBOutlet UITableView * contactList;
    /**
     The searchbar
     */
    IBOutlet UISearchBar * srchBar;
    /**
     The title of the view
     */
    IBOutlet UILabel * mainTitle;
    /**
     The subtitle of the view
     */
    IBOutlet UILabel * subTitle;
    /**
     The view that alload us to go from the subMenu to the parent menu.
     */
    IBOutlet UIView * backView;
    IBOutlet UILabel * mainChoise;
    /**
     The dimension before/after animation, used to animate bigger smaller...
     */
    CGRect mainBeforeModif;
    /**
     The dimension before/after animation, used to animate bigger smaller...
     */
    CGRect subBeforeModif;
    /**
     The dimension before/after animation, used to animate bigger smaller...
     */
    CGRect backBeforeModif;
    /**
     A submenu mangager.
     */
    SubMenuFilterTableViewController *subCtrl;
    /**
     Display the waiting logo durring the loading phase.
     */
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
