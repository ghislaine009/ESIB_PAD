//
//  DirectoryViewControllerIPad.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 15.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "DirectoryViewControllerIPad.h"

@implementation DirectoryViewControllerIPad

@synthesize mainMenuFilter,mainChoise,subMenuFilter,backView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                
    }
    return self;
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
-(void) displayMainMenu{
    
}
-(void) displaySubMenu:(NSArray *)listOfOption{
    mainBeforeModif = mainMenuFilter.frame;
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         CGRect rect = mainMenuFilter.frame;
                         rect.size.width = 0;
                         mainMenuFilter.frame = rect;
                         mainMenuFilter.hidden = NO;

                     } 
                     completion:^(BOOL finished){
                     }];
        [UIView commitAnimations];
}
-(void) displayListOfPerson:(NSArray *)listOfPerson{
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    mainChoise.transform = CGAffineTransformMakeRotation( M_PI/2 );

    [super viewDidLoad];
    MainFilterTableViewController * mainCtrl = [[MainFilterTableViewController alloc ] init];
    mainCtrl.tableView= self.mainMenuFilter;
    mainMenuFilter.delegate=mainCtrl;
    mainMenuFilter.dataSource = mainCtrl;
    mainCtrl.delegate = self;
    MainFilterTableViewController * mainCtrl2 = [[MainFilterTableViewController alloc ] init];
    mainCtrl2.tableView = self.subMenuFilter;
    subMenuFilter.delegate=mainCtrl2;
    subMenuFilter.dataSource = mainCtrl2;
    
    [self.mainMenuFilter reloadData];
    


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
