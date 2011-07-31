//
//  PersonListViewController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "PersonListViewController.h"


@implementation PersonListViewController
@synthesize persons = _persons,searchBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.contentSizeForViewInPopover = CGSizeMake(300, 400);
        //Initialize the copy array.
	copyListOfItems = [[NSMutableArray alloc] init];
    
    searchBar = [[UISearchBar alloc ] initWithFrame:CGRectMake(0,0,4, 40)];
    
	[searchBar setDelegate:(id)self];
        //Set the title
	self.navigationItem.title = @"People";
	
        //Add the search bar
	self.tableView.tableHeaderView = searchBar;
    
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	
	searching = NO;
	letUserSelectRow = YES;
    
}


-(void)dealloc{
    [self.persons release];
    [super dealloc];
}
- (void) setPersons:(NSArray *)persons{
    _persons = [persons retain];
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        // There is only one section.
	return 1;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar
{
    [theSearchBar resignFirstResponder];
    theSearchBar.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searching)
		return [copyListOfItems count];
    else
        return [self.persons count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
        // Try to retrieve from the table view a now-unused cell with the given identifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
        // If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
            // Use the default cell style.
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
	}
    if(searching) {
        if([copyListOfItems count] > indexPath.row ){
            Person * p = (Person *)[copyListOfItems objectAtIndex:indexPath.row];
            NSString  * s =  [NSString stringWithFormat:@" %@ %@",p.nom , p.prenom];
            cell.textLabel.text = s ;
        }
	}else {
            // Set up the cell.
        Person * p = (Person *)[_persons objectAtIndex:indexPath.row];
        NSString  * s =  [NSString stringWithFormat:@" %@ %@",p.nom , p.prenom];
        cell.textLabel.text = s ;
	}
	
	
	return cell;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(searching) {
        if([copyListOfItems count]!=0){
            [self displayDetail:(Person *)[copyListOfItems objectAtIndex:indexPath.row]];
        }
	}else{
        [self displayDetail:(Person *)[_persons objectAtIndex:indexPath.row]];
    }
	return nil;
}
-(void) displayDetail:(Person*)p{
    ContactDetailTableViewController * detailView = [[ContactDetailTableViewController alloc] initWithForThisPerson:p];
    
    RotableUINavController *navController = [[RotableUINavController alloc] initWithRootViewController:detailView];
   
    [navController.view sizeToFit];
    [detailView.view sizeToFit];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    if(![[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] && ! [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
        navController.modalPresentationStyle = UIModalPresentationPageSheet;
    }
    [self presentModalViewController:navController animated:YES];
    navController.navigationBar.tintColor = [UIColor colorWithRed:26/255.0 green:99/255.0 blue:140/255.0 alpha:1.0];
    
    UIBarButtonItem *b = [[UIBarButtonItem alloc ]initWithTitle:@"Back" style:UIBarButtonSystemItemPlay target:self action:@selector(back)];
    detailView.navigationItem.leftBarButtonItem = b;
    [navController.view sizeToFit];
    [detailView release];
    [navController release];
}
-(void) back{
    [self dismissModalViewControllerAnimated:YES];

}
#pragma mark -
#pragma mark Search Bar 

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
        //This method is called again when the user clicks back from teh detail view.
        //So the overlay is displayed on the results, which is something we do not want to happen.
	if(searching)
		return;
	
        //Add the overlay view.
	if(ovController == nil)
		ovController = [[OverlayViewController alloc] initWithNibName:@"OverlayView" bundle:[NSBundle mainBundle]];
	
	CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	
        //Parameters x = origion on x-axis, y = origon on y-axis.
	CGRect frame = CGRectMake(0, yaxis, width, height);
	ovController.view.frame = frame;	
	ovController.view.backgroundColor = [UIColor grayColor];
	ovController.view.alpha = 0.5;
	
	ovController.rvController = self;
	
	[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
	
	searching = YES;
	letUserSelectRow = NO;
	
        //Add the done button.
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											   initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
											   target:self action:@selector(doneSearching_Clicked:)] autorelease];
}


- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
        //Remove all objects first.
	[copyListOfItems removeAllObjects];
    
	if([searchText length] > 0) {
		
		[ovController.view removeFromSuperview];
		searching = YES;
		letUserSelectRow = YES;
		[self searchTableView];
	}
	else {
		
		[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
		
		searching = NO;
		letUserSelectRow = NO;
		
        [theSearchBar resignFirstResponder];
        letUserSelectRow = YES;
        self.navigationItem.rightBarButtonItem = nil;
        
        
	}
	
	[self.tableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	
	[self searchTableView];
}

- (void) searchTableView {
	
	NSString *searchText = searchBar.text;
	NSMutableArray *searchArray = [[NSMutableArray alloc] init];
	
	for (Person * p in _persons)
        {
        NSString  * s =  [NSString stringWithFormat:@" %@ %@ %@",p.nom , p.prenom ,p.carriere];
		[searchArray addObject:s];
        }
	int i=0;
	for (NSString *sTemp in searchArray)
        {
        NSArray* separatedWord = [searchText componentsSeparatedByString: @" "];
        for (NSString *word in separatedWord) {
            NSRange titleResultsRange = [sTemp rangeOfString:word options:NSCaseInsensitiveSearch];
            if (titleResultsRange.length > 0){
                [copyListOfItems addObject:[_persons objectAtIndex:i]];
                break;
            }
        }
        i++;
        }
	[searchArray release];
	searchArray = nil;
}

- (void) doneSearching_Clicked:(id)sender {
	
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	
	[ovController.view removeFromSuperview];
	[ovController release];
	ovController = nil;
	
	[self.tableView reloadData];
}

@end

