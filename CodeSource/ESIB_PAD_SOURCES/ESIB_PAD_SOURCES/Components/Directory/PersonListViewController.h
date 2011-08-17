//
//  PersonListViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "OverlayViewController.h"
#import "ContactDetailTableViewController.h"
#import "RotableUINavController.h"
/**
 Responsible to display a list of personns in a table. 
 have to manage the search functionality 
 */
@interface PersonListViewController : UITableViewController<UISearchBarDelegate> {
    NSArray * _persons;
    NSMutableArray *copyListOfItems;
	UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
	
	OverlayViewController *ovController;
}
- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;
-(void) displayDetail:(Person*)p;
@property(nonatomic ,retain) NSArray *persons;
@property(nonatomic, retain) UISearchBar *searchBar;



@end
