//
//  SelectionListViewController.m
//  iContractor
//
//  Created by Elias Medawar on 12.07.11.
//  Copyright 2011 HEFR. All rights reserved.

#import "SelectionListViewController.h"

@implementation SelectionListViewController
@synthesize list;
@synthesize lastIndexPath;
@synthesize initialSelection;
@synthesize delegate;
-(IBAction)cancel
{
    [self.delegate removeListFromTopView];
}
-(IBAction)save
{

    [self.delegate campusSelected:[[[NSNumber alloc] initWithUnsignedInt:[lastIndexPath row]] autorelease]];
    [self.delegate removeListFromTopView];

}
-(void) setInitialSelection:(NSInteger)select{
    if (select > - 1 && select < [list count])
    {
        NSUInteger newIndex[] = {0, select};
        NSIndexPath *newPath = [[NSIndexPath alloc] initWithIndexes:newIndex length:2];
        self.lastIndexPath = newPath;
        [[self tableView] reloadData];
        self.initialSelection = select;
        [newPath release];
    }

}
#pragma mark -
- (id)initWithStyle:(UITableViewStyle)style
{

    if (self == [super initWithStyle:style])
    {
        initialSelection = -1;
        self.contentSizeForViewInPopover = CGSizeMake(300, 400);    
    }
    return self;
}
- (void)viewDidLoad 
{
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated 
{
    // Check to see if user has indicated a row to be selected, and set it
    if (initialSelection > - 1 && initialSelection < [list count])
    {
        NSUInteger newIndex[] = {0, initialSelection};
        NSIndexPath *newPath = [[NSIndexPath alloc] initWithIndexes:newIndex length:2];
        self.lastIndexPath = newPath;
        [newPath release];
    }
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithTitle:NSLocalizedString(@"Cancel", @"Cancel - for button to cancel changes")
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(cancel)];
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:NSLocalizedString(@"Save", @"Save - for button to save changes")
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
    
    [super viewWillAppear:animated];
}
- (void)dealloc 
{
    [list release];
    [lastIndexPath release];
    [super dealloc];
}
#pragma mark -
#pragma mark Tableview methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *SelectionListCellIdentifier = @"SelectionListCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectionListCellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:SelectionListCellIdentifier] autorelease];
    }
    
    NSUInteger row = [indexPath row];
    NSUInteger oldRow = [lastIndexPath row];
    cell.textLabel.text = [[list objectAtIndex:row] valueForKey:@"code"];
    cell.accessoryType = (row == oldRow && lastIndexPath != nil) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    

        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: lastIndexPath]; 
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        
        lastIndexPath = indexPath;  
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end