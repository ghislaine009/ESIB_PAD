//
//  MainFilterTableViewController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 15.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "MainFilterTableViewController.h"


@implementation MainFilterTableViewController

@synthesize listMainMenu,delegate;


-(id)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    self.listMainMenu = [[NSArray alloc] initWithObjects:@"Rectorship",@"Campus",@"Institution",@"All the direcectory", nil];
    return  self;
}
- (void)didReceiveMemoryWarning
{
        // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
        // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad {
    [self.tableView setBackgroundView:nil];
    [self.tableView  setBackgroundView:[[[UIView alloc] init] autorelease]];
    [self.tableView  setBackgroundColor:[UIColor whiteColor]]; 
 
    [super viewDidLoad];
}

- (void)dealloc {
    
	[super dealloc];
}

#pragma mark Table View methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}

/*
  -(UITableView *) tableView
  - (UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
  {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.textLabel.textColor = [UIColor orangeColor];
  [super beautifyCell:cell atIndexPath:indexPath];
  return nil;
  
  }*/

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section ==0 ) return @"";
    if(section == 1)
        return @"Directory filterd by:";
    else
        return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    if(section ==0 ) return 1;
    if(section == 1) return 2;
    return  1;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
            if(indexPath.row ==0)
                [self.delegate displaySubMenu:@"Campus"];
            else
                [self.delegate displaySubMenu:@"Institution"];
    }else if (indexPath.section == 0){
          [self.delegate displayRectoratServ];    
    }
        

}

-(void) back{
    [self dismissModalViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString *MyIdentifier = @"MainMenu";
    int dec = [indexPath row];
    if(indexPath.section == 1){
        dec+=1;
    }
    if(indexPath.section == 2){
        dec+=3;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
        cell.textLabel.text =[self.listMainMenu objectAtIndex:dec] ;

	}
    
        
	return cell;
}



@end

