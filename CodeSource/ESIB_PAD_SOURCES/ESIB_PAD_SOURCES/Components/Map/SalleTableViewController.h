//
//  SalleTableViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapDisplayerDelegate.h"
#import "OverlayViewController.h"

@interface SalleTableViewController  : UITableViewController {
    NSArray * _salles;
    NSMutableArray *copyListOfItems;
	UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
	
	OverlayViewController *ovController;
}

- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;

@property(nonatomic ,retain) NSArray *salle;
@property (retain)  id <MapDisplayerDelegate>  delegate;

@end
