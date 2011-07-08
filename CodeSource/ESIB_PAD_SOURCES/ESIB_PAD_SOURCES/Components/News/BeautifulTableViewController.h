//
//  BeautifulTableViewController.h
//  LevelMeUp
//
//  Created by Ray Wenderlich based on code
//  by Matt Gallagher at:
//  http://cocoawithlove.com/2009/04/easy-custom-uitableview-drawing.html
//

#import <UIKit/UIKit.h>

@interface BeautifulTableViewController : UITableViewController {
	UITableView *tableView_;
	UIImage *rowSingleImage_;
	UIImage *rowSingleSelImage_;
	UIImage *rowTopImage_;
	UIImage *rowTopSelImage_;
	UIImage *rowBottomImage_;
	UIImage *rowBottomSelImage_;
	UIImage *rowMidImage_;
	UIImage *rowMidSelImage_;
}

@property (nonatomic, retain) UIImage *rowSingleImage;
@property (nonatomic, retain) UIImage *rowSingleSelImage;
@property (nonatomic, retain) UIImage *rowTopImage;
@property (nonatomic, retain) UIImage *rowTopSelImage;
@property (nonatomic, retain) UIImage *rowBottomImage;
@property (nonatomic, retain) UIImage *rowBottomSelImage;
@property (nonatomic, retain) UIImage *rowMidImage;
@property (nonatomic, retain) UIImage *rowMidSelImage;

- (void)beautifyCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

// This is a helper function you can use if you add or delete a row, to make sure that the the neighboring rows
// look OK
- (void)beautifyCellAndNeighborsAtIndexPath:(NSIndexPath *)indexPath nilAccessoryViews:(BOOL)nilAccessoryViews;	

@end
