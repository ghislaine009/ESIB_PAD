//
//  SubMenuFilterTableViewController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 18.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "SubMenuFilterTableViewController.h"


@implementation SubMenuFilterTableViewController

@synthesize currentData,delegate,filterName;


-(id)initWithFilterName:(NSString *) name{
    self = [super initWithStyle:UITableViewStyleGrouped];

    filterName = [name retain];
    if([filterName isEqualToString:@"Campus"]){
        campusAsSection = NO;
       
    }
    
    if([filterName isEqualToString:@"Institution"]){
        campusAsSection = YES;
    }
    [self.view setNeedsDisplay];

    return self;    
}
-(void) initListCampus{
    [self.delegate displayIsLoadingData:YES];

    CampusDAO * cDao = [[CampusDAO alloc] init];
    cDao.delegate = self;
    [cDao getCampus:NO];
    [cDao release];
}
-(void) initListInstition{
    [self.delegate displayIsLoadingData:YES];
    
    InstitutionDAO * iDao = [[InstitutionDAO alloc] init];
    iDao.delegate = self;
    [iDao getInstitution];
    [iDao release];
}
-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [filterName release];
    [backgroundView release];
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
    [super viewDidLoad];
    backgroundView = [[UIImageView alloc] init] ;
    backgroundView.image = [UIImage imageNamed:@"selectedCell.png"];
    if(campusAsSection){
         [self initListInstition];
    }else{
        [self initListCampus];
    }
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
    // Return the number of sections.
    return  1;        
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [currentData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if(!campusAsSection){
        Campus * c = (Campus *)[currentData objectAtIndex:indexPath.row];
        cell.textLabel.text = c.code;
        cell.selectedBackgroundView = backgroundView;
    }else{
        Institution * i = (Institution *)[currentData objectAtIndex:indexPath.row];
        cell.textLabel.text = i.code;      
        cell.selectedBackgroundView = backgroundView;
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
    if(campusAsSection){
        [self.delegate displayIsLoadingData:YES];
        PersonDAO * pDao = [[PersonDAO alloc] init];
        [pDao setDelegate:self];
        Institution * c = (Institution *)[currentData objectAtIndex:indexPath.row];
        [pDao getPersonsForInstitution:c.code];
        [pDao release];
        NSString * desc = [[NSString alloc] initWithFormat:@"%@ : %@ %@ %@, Tel: %@",c.responsable,c.titre, c.nom,c.prenom, c.extension];
        [self.delegate displayInformation:c.institution andSubtitle:[desc autorelease]];

    }else{
        
        [self.delegate displayIsLoadingData:YES];
        PersonDAO * pDao = [[PersonDAO alloc] init];
        [pDao setDelegate:self];
        Campus * c = (Campus *)[currentData objectAtIndex:indexPath.row];
        [pDao getPersonsForDomaine:c.code];
        [pDao release];
        NSString * desc = [[NSString alloc] initWithFormat:@"%@ : %@ %@ %@, Tel: %@",c.resp_def,c.titre_resp, c.nom_resp,c.prenom_resp, c.extension];
        [self.delegate displayInformation:c.campus andSubtitle:[desc autorelease]];
    }
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}
#pragma mark - PersonDAO delegate
-(void) consumeListOfPerson:(NSArray *)personArray{
    [self.delegate displayListOfPerson:personArray];
    [self.delegate displayIsLoadingData:NO];

}
#pragma mark - InstitutionDAO delegate
-(void) consumeListOfInstitution:(NSArray *)institutionArray{
    if(campusAsSection){
        self.currentData = [[NSMutableArray alloc ] initWithArray:institutionArray];
        [self.tableView beginUpdates];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];    
    }
    [self.delegate displayIsLoadingData:NO];}
#pragma mark - CampusDAO delegate

- (void)consumeListOfCampus:(NSArray *)arrayOfCampu{
    if(!campusAsSection){
        self.currentData = [[NSMutableArray alloc ] initWithArray:arrayOfCampu];
        [self.tableView beginUpdates];
        
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];    }
    [self.delegate displayIsLoadingData:NO];
}

@end
