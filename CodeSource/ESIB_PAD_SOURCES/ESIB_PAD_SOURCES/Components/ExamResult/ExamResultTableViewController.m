//
//  ExamResultTableViewController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 03.08.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "ExamResultTableViewController.h"


@implementation ExamResultTableViewController
@synthesize delegate,cellNib,tmpCell;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) displayExamResult: (NSArray *)listOfExam{

    if(!sections)
        sections = [[NSMutableArray alloc] init];
    NSArray * sectitionTitle =  [listOfExam valueForKeyPath:@"@distinctUnionOfObjects.anne"];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    
    NSArray * descriptors = [NSArray arrayWithObject:sort];
    NSArray * sectitionTitleSorted =  [sectitionTitle sortedArrayUsingDescriptors:descriptors];
    for (NSString * s in sectitionTitleSorted) {
        NSPredicate *childPred = [NSPredicate predicateWithFormat:@"anne isEqualToString: %@",s];
        NSArray *child = [listOfExam filteredArrayUsingPredicate:childPred];
        [sections addObject:child];
    }
   
    if(_ExamResult)
        [_ExamResult release];
    _ExamResult = listOfExam;

    [[self tableView] reloadData];
    [sort release];
    
}
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    ExamResultDAO * nDAO = [[ExamResultDAO alloc] init];
    [nDAO setDelegate:self];
    [nDAO getExamResult];
    [nDAO release];
    self.cellNib = [UINib nibWithNibName:@"ExameCell" bundle:nil];
    [self.tableView setBackgroundView:nil];
    [self.tableView  setBackgroundView:[[[UIView alloc] init] autorelease]];
    [self.tableView  setBackgroundColor:[UIColor whiteColor]];   
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark Table View methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[sections objectAtIndex:section] objectAtIndex:0] valueForKey:@"anne"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [sections count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
	return [[sections objectAtIndex:section ] count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    return  71;
}

-(void) back{
    [self dismissModalViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"News Cell Identifier";
    ExamResultCellController *cell = (ExamResultCellController *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    ExamResult * a = [[sections objectAtIndex:indexPath.section ] objectAtIndex:[indexPath row]];
    
	if (cell == nil) {
        
        [self.cellNib instantiateWithOwner:self options:nil];
		cell = tmpCell;
		self.tmpCell = nil;
       
	}
    
    
	cell.titre = a.title;
    cell.ss_titre = a.note;
    cell.reussi = a.reussi;
    cell.moyene = a.moyeneClassee;
    
    return cell;
}



@end

