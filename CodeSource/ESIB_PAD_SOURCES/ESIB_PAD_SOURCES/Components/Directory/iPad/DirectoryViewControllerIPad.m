//
//  DirectoryViewControllerIPad.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 15.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "DirectoryViewControllerIPad.h"
#import "PersonListViewController.h"
@implementation DirectoryViewControllerIPad

@synthesize mainMenuFilter,mainChoise,subMenuFilter,backView,contactList,srchBar,loading;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                
    }
    return self;
}

- (void)dealloc
{   if(subCtrl)
        [subCtrl release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void) displayMainMenu{
        mainTitle.text = @"Please choose a display filter.";
        subTitle.text=@"";

        [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         subBeforeModif = subMenuFilter.frame;
                         backBeforeModif = backView.frame;
                         CGRect rect = subMenuFilter.frame;
                         rect.size.height = 0;
                         CGRect rect2 = backView.frame;
                         rect2.size.width = 0;
                         self.srchBar.alpha =0;
                         self.contactList.alpha =0;
                         subMenuFilter.frame = rect;
                         backView.frame= rect2;
                     } 
                     completion:^(BOOL finished){
                         mainMenuFilter.hidden = NO;
                         backView.hidden = YES;
                         subMenuFilter.hidden = YES;
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.7
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         [mainMenuFilter deselectRowAtIndexPath:[mainMenuFilter indexPathForSelectedRow] animated:YES];
                         mainMenuFilter.frame = mainBeforeModif;
                     } 
                     completion:^(BOOL finished){
                     }];
    [UIView commitAnimations];

 
}

-(void) displaySubMenu:(NSString *)subMenuOption{
    if([subMenuOption isEqualToString:@"Campus"]){
        [self displayInformation:@"Choose a camps" andSubtitle:@"Use the 'Other filters' button to change the settings"];
    }else{
        [self displayInformation:@"Choose an institution" andSubtitle:@"Use the 'Other filters' button to change the settings  "];
        
    }
    if(!subCtrl || ![subMenuOption isEqualToString:subCtrl.filterName]){
        if(subCtrl)
            [subCtrl release];
        subCtrl = [[SubMenuFilterTableViewController alloc ] initWithFilterName:subMenuOption];
        [subCtrl setDelegate:self];

        subCtrl.tableView = self.subMenuFilter;
        subMenuFilter.delegate=subCtrl;
        subMenuFilter.dataSource = subCtrl;
    }
    
    mainBeforeModif = mainMenuFilter.frame;
    if(!(subBeforeModif.size.height > 0)){
        subBeforeModif = subMenuFilter.frame;
        backBeforeModif = backView.frame;
    }
    CGRect rect = subMenuFilter.frame;
    rect.size.height = 0;
    CGRect rect2 = backView.frame;
    rect2.size.width = 0;
    backView.frame = rect2;
    subMenuFilter.frame = rect;
    


    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         CGRect rect = mainMenuFilter.frame;
                         rect.size.height = 0;
                         mainMenuFilter.frame = rect;
                         self.srchBar.alpha = 1;
                         self.contactList.alpha=1;
                     } 
                     completion:^(BOOL finished){
                         mainMenuFilter.hidden = YES;
                         backView.hidden = NO;
                         subMenuFilter.hidden = NO;
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.7
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         subMenuFilter.frame = subBeforeModif;
                         backView.frame = backBeforeModif;
                     } 
                     completion:^(BOOL finished){
                     }];
    [UIView commitAnimations];
        //[subCtrl release];
}
-(void) displayRectoratServ{
    self.srchBar.hidden = YES;
    RectoServTableViewController * rc = [[RectoServTableViewController alloc] init];
    rc.tableView = self.contactList;
    [self.contactList setDelegate:rc];
    [self.contactList setDataSource:rc];
    [self.contactList reloadData];
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.contactList.alpha=1;
                     } 
                     completion:^(BOOL finished){
                         [rc release];
                     }];

}
-(void) displayListOfPerson:(NSArray *)listOfPerson{
    self.srchBar.text =@"";
    self.srchBar.alpha =1;
    self.contactList.alpha =1;
    PersonListViewController * personList = [[PersonListViewController alloc]init];
    personList.persons = [listOfPerson retain];
    personList.tableView = self.contactList;
    personList.searchBar = self.srchBar;
    [self.srchBar setDelegate:personList];
    
    self.srchBar.hidden = NO;

    [personList.view setNeedsDisplay];
    [self.contactList setDelegate:personList];
    [self.contactList setDataSource:personList];
    [self.contactList beginUpdates];
    [self.contactList deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    [self.contactList insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    [self.contactList endUpdates];
}
-(void) displayIsLoadingData:(BOOL) loadingInprogress{
    if(loadingInprogress)
        [loading startAnimating];
    else
        [loading stopAnimating];
}
- (IBAction)displayMainMenuFromButton:(id)sender{
    [self displayMainMenu];
}
-(void) displayInformation:(NSString *) title andSubtitle:(NSString *) texte{
    mainTitle.text = title;
    subTitle.text = texte;
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    mainChoise.transform = CGAffineTransformMakeRotation( M_PI/2 );
    [self.mainMenuFilter setBackgroundView:nil];
    [self.mainMenuFilter  setBackgroundView:[[[UIView alloc] init] autorelease]];
    [self.mainMenuFilter  setBackgroundColor:[UIColor whiteColor]];  
    [self.subMenuFilter setBackgroundView:nil];
    [self.subMenuFilter  setBackgroundView:[[[UIView alloc] init] autorelease]];
    [self.subMenuFilter  setBackgroundColor:[UIColor whiteColor]];
    [super viewDidLoad];
    
    
    MainFilterTableViewController * mainCtrl = [[MainFilterTableViewController alloc ] init];
    mainCtrl.tableView= self.mainMenuFilter;
    mainMenuFilter.delegate=mainCtrl;
    mainMenuFilter.dataSource = mainCtrl;
    [mainCtrl setDelegate: self];
    
    [self.mainMenuFilter reloadData];
    
    [srchBar setBackgroundColor:[UIColor clearColor]];
    
    for (UIView *subview in srchBar.subviews) { 
        if ([subview conformsToProtocol:@protocol(UITextInputTraits)]) { 
            [(UITextField *)subview setClearButtonMode:UITextFieldViewModeNever]; 
        }
        if([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
            [subview removeFromSuperview];
    }
    [loading stopAnimating];

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
-(void)displayDetailOfPerson:(Person *)Person{
}

@end
