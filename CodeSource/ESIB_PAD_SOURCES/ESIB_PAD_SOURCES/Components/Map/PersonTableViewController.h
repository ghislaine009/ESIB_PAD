//
//  PersonTableViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 27.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "MapDisplayerDelegate.h"
#import "OverlayViewController.h"
/**
 Display a list of person with gps coordinate.
 On click on one cell, the corresponding salle will be displayed on the map.

 */
@interface PersonTableViewController : UITableViewController<UISearchBarDelegate> {
    NSArray * _persons;
    NSMutableArray *copyListOfItems;
	UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
	
	OverlayViewController *ovController;
}

- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;

@property(nonatomic ,retain) NSArray *persons;
@property (retain)  id <MapDisplayerDelegate>  delegate;
@property(nonatomic, retain) UISearchBar *searchBar;

@end
