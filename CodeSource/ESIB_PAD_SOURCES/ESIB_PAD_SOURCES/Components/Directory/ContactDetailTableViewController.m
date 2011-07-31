//
//  ContactDetailTableViewController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "ContactDetailTableViewController.h"


@implementation ContactDetailTableViewController
@synthesize tmpCell,cellNib;

- (id) initWithForThisPerson:(Person *) p{
    self = [super initWithStyle:UITableViewStyleGrouped];
    personInformation = [p retain];
    [self.tableView reloadData];
    return self;
}
- (void)dealloc
{
    [personInformation release];
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
     self.cellNib = [UINib nibWithNibName:@"DetailContactCell" bundle:nil];
    /*[self.tableView setBackgroundView:nil];
    [self.tableView  setBackgroundView:[[[UIView alloc] init] autorelease]];
    [self.tableView  setBackgroundColor:[UIColor whiteColor]];   */
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 3;
    else {
        NSInteger i;
        i=0;
        if(personInformation.extension && !([personInformation.extension isEqualToString:@"0"]))
            i++;
        if (personInformation.email && ![personInformation.email isEqualToString:@" "]) {
            i++;
        }
        NSLog(@"%d , %d",i,section);
        return i;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    ContactViewCellController *cell = (ContactViewCellController *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        [self.cellNib instantiateWithOwner:self options:nil];
		cell = tmpCell;
		self.tmpCell = nil;
        /*cell.backgroundView = [[[UIView alloc] init] autorelease];
        cell.selectedBackgroundView = [[[UIView alloc] init] autorelease];*/
	}
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                cell.left = @"Nom :";
                cell.right = personInformation.nom;
                break;
            case 1:
                cell.left = @"Prenom :";
                cell.right = personInformation.prenom;
                break;  
            case 2:
                cell.left = @"Carrière :";
                cell.right = personInformation.carriere;
                break;  
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
                cell.left = @"E-Mail :";
                cell.right = personInformation.email;
                break;
            case 1:
                cell.left = @"Tel :";
                NSString *s  = [[NSString alloc] initWithFormat:@"01 42 %@",personInformation.extension];

                cell.right =s;
                break;  
            default:
                break;
        }

    }
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section ==1 && indexPath.row ==0){
        if ([MFMailComposeViewController canSendMail]) {
            
            MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
            [[mailComposer navigationBar] setTintColor:[UIColor colorWithRed:0.03f green:0.03f blue:0.03f alpha:1.0f]];
            mailComposer.mailComposeDelegate = self;
            
            [mailComposer setSubject:@"Subject"];
            [mailComposer setMessageBody:@"Sent from ESIB@PAD" isHTML:NO];
            
            [mailComposer setToRecipients:[NSArray arrayWithObject:personInformation.email]];
            [self presentModalViewController:mailComposer animated:YES];
            [mailComposer release];
        }
        else
            {
            UIApplication *app = [UIApplication sharedApplication];
            [app openURL:[NSURL URLWithString:
                          [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@",personInformation.email,@"Subject",@"Sent from ESIB@PAD"]]];
            }
    }else if (indexPath.section ==1 && indexPath.row ==1){
        if([[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] || [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
            NSString *s  = [[NSString alloc] initWithFormat:@"Call 0142%@?",personInformation.extension];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:s delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES",nil];
            [s release];
            [alert show];
            [alert release];
        }
             
    }
} 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
        {
        NSString *s  = [[NSString alloc] initWithFormat:@"tel://0142%@?",personInformation.extension];
        [[UIApplication sharedApplication] 
         openURL:[NSURL URLWithString:s]];   
        [s release];

        }
}


    // Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	[self dismissModalViewControllerAnimated:YES];
}

@end
