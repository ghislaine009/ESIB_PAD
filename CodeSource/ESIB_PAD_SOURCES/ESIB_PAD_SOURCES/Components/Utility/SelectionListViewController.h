//
//  SelectionListViewController.h
//  iContractor
//
//  Created by Jeff LaMarche on 2/18/09.
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