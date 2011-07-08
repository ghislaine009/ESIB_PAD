//
//  BeautifulTableViewController.m
//  LevelMeUp
//
//  Created by Ray Wenderlich based on code
//  by Matt Gallagher at:
//  http://cocoawithlove.com/2009/04/easy-custom-uitableview-drawing.html
//

#import "BeautifulTableViewController.h"

@implementation BeautifulTableViewController
@synthesize rowSingleImage = rowSingleImage_;
@synthesize rowSingleSelImage = rowSingleSelImage_;
@synthesize rowTopImage = rowTopImage_;
@synthesize rowTopSelImage = rowTopSelImage_;
@synthesize rowBottomImage = rowBottomImage_;
@synthesize rowBottomSelImage = rowBottomSelImage_;
@synthesize rowMidImage = rowMidImage_;
@synthesize rowMidSelImage = rowMidSelImage_;

- (void) viewDidLoad {

	// Set up default images
	self.rowSingleImage = [[UIImage imageNamed:@"Table_single.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:50];
	self.rowSingleSelImage = [UIImage imageNamed:@"Table_single_sel.png"];
	self.rowTopImage = [UIImage imageNamed:@"Table_top.png"];
	self.rowTopSelImage = [UIImage imageNamed:@"Table_top_sel.png"];
	self.rowBottomImage = [UIImage imageNamed:@"Table_bottom.png"];
	self.rowBottomSelImage = [UIImage imageNamed:@"Table_bottom_sel.png"];
	self.rowMidImage = [UIImage imageNamed:@"Table_mid.png"];
	self.rowMidSelImage = [UIImage imageNamed:@"Table_mid_sel.png"];
	
	// Set up custom table view
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setAllowsSelectionDuringEditing:TRUE];
	
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void) dealloc {
	self.rowSingleImage = nil;
	self.rowSingleSelImage = nil;
	self.rowTopImage = nil;
	self.rowTopSelImage = nil;
	self.rowBottomImage = nil;
	self.rowBottomSelImage = nil;
	self.rowMidImage = nil;
	self.rowMidSelImage = nil;	
	[super dealloc];
}

// This will get overridden
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return 0;
}

- (void)beautifyCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

	// Set the background and selected images based on row
	UIImage *rowBackground;
	UIImage *selectionBackground;
	NSInteger sectionRows = [self tableView:tableView_ numberOfRowsInSection:[indexPath section]];
	if (indexPath.row == 0 && indexPath.row == sectionRows - 1) {
		rowBackground = rowSingleImage_;
		selectionBackground = rowSingleSelImage_;
	}
	else if (indexPath.row == 0) {
		rowBackground = rowTopImage_;
		selectionBackground = rowTopSelImage_;
	} else if (indexPath.row == sectionRows - 1) {
		rowBackground = rowBottomImage_;
		selectionBackground = rowBottomSelImage_;
	} else {
		rowBackground = rowMidImage_;
		selectionBackground = rowMidSelImage_;
	}

	// Set the images in the image views, creating if necessary
	UIImageView *backgroundView = (UIImageView *)cell.backgroundView;
	if (![backgroundView isKindOfClass:[UIImageView class]]) {
		backgroundView = [[[UIImageView alloc] init] autorelease];
		cell.backgroundView = backgroundView;
	}

	UIImageView *selectedBackgroundView = (UIImageView *)cell.selectedBackgroundView;
	if (![selectedBackgroundView isKindOfClass:[UIImageView class]]) {
		selectedBackgroundView = [[[UIImageView alloc] init] autorelease];
		cell.selectedBackgroundView = selectedBackgroundView;
	}
	
	// Set images
    selectedBackgroundView.image = selectionBackground;		
	backgroundView.image = rowBackground;
    
}

// This is a helper function you can use if you add or delete a row, to make sure that the the neighboring rows
// look OK
- (void)beautifyCellAndNeighborsAtIndexPath:(NSIndexPath *)indexPath nilAccessoryViews:(BOOL)nilAccessoryViews {
	
	UITableViewCell *cell = [tableView_ cellForRowAtIndexPath:indexPath];
	if (cell != nil) {
		[self beautifyCell:cell atIndexPath:indexPath];
	}
	if (nilAccessoryViews) cell.accessoryView = nil;
	
	NSIndexPath *topNeighborIndexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
	UITableViewCell *topNeighbor = [tableView_ cellForRowAtIndexPath:topNeighborIndexPath];
	if (topNeighbor != nil) {
		[self beautifyCell:topNeighbor atIndexPath:topNeighborIndexPath];
	}
	if (nilAccessoryViews) topNeighbor.accessoryView = nil;
	
	NSIndexPath *bottomNeighborIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
	UITableViewCell *bottomNeighbor = [tableView_ cellForRowAtIndexPath:bottomNeighborIndexPath];
	if (bottomNeighbor != nil) {
		[self beautifyCell:bottomNeighbor atIndexPath:bottomNeighborIndexPath];
	}	
	if (nilAccessoryViews) bottomNeighbor.accessoryView = nil;
	
}


@end
