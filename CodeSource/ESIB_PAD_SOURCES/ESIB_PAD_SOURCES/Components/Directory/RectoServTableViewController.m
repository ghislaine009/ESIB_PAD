//
//  RectoServTableViewController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 20.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "RectoServTableViewController.h"


@implementation RectoServTableViewController
@synthesize tmpCell,cellNib;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        ServRecDAO * nDAO = [[ServRecDAO alloc] init];
        [nDAO setDelegate:self];
        [nDAO getServRec];
        [nDAO release];
    }
    return self;
    
}
-(void) consumeListOfRectorat:(NSArray *)servRecList{
    if(_servRec)
        [_servRec release];
    _servRec = [servRecList retain];
    [self.tableView reloadData];
    
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

    self.cellNib = [UINib nibWithNibName:@"RectServCell" bundle:nil];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_servRec count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    RectServViewController *cell = (RectServViewController *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        [self.cellNib instantiateWithOwner:self options:nil];
		cell = tmpCell;
		self.tmpCell = nil;
        cell.backgroundView = [[[UIView alloc] init] autorelease];
        cell.selectedBackgroundView = [[[UIView alloc] init] autorelease];
	}
    
    ServRectora * a = [_servRec objectAtIndex:[indexPath row]];
    cell.titre = a.nom;
    NSString * desc = [[NSString alloc] initWithFormat:@"%@ : %@ %@ %@, Tel: %@",a.responsable,a.titre_resp, a.nom_resp,a.prenom_resp, a.extension];
    cell.ss_titre = desc;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
   
    ServRectora * a = [_servRec objectAtIndex:[indexPath row]];
    NSString* to = a.email;
    
    if ([MFMailComposeViewController canSendMail]) {
                
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        [[mailComposer navigationBar] setTintColor:[UIColor colorWithRed:0.03f green:0.03f blue:0.03f alpha:1.0f]];
        mailComposer.mailComposeDelegate = self;
        
        [mailComposer setSubject:@"Information rectorat service"];
        [mailComposer setMessageBody:@"Sent from ESIB@PAD" isHTML:NO];
        
        [mailComposer setToRecipients:[NSArray arrayWithObject:to]];
        [self presentModalViewController:mailComposer animated:YES];
        [mailComposer release];
    }
    else
        {
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:
                      [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@",to,@"Information rectorat service",@"Sent from ESIB@PAD"]]];
        }
    
}
    // Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	[self dismissModalViewControllerAnimated:YES];
}

@end
