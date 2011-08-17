//
//  SelectionListViewController.h
//  iContractor
//
//  Created by Elias Medawar on 12.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapDisplayerDelegate.h"

@interface SelectionListViewController : UITableViewController 
{
    NSArray         *list;
    NSIndexPath     *lastIndexPath;
    NSInteger       initialSelection;
    
    id <MapDisplayerDelegate>    delegate;
}
@property (nonatomic, retain) NSIndexPath *lastIndexPath;
@property (nonatomic, retain) NSArray *list;
@property NSInteger initialSelection;
@property (nonatomic, assign) id <MapDisplayerDelegate> delegate;
@end