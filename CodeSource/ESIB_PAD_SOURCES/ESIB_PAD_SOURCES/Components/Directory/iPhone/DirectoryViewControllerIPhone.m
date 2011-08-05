//
//  DirectoryViewControllerIPhone.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 15.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "DirectoryViewControllerIPhone.h"


@implementation DirectoryViewControllerIPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayMainMenu];

    // Do any additional setup after loading the view from its nib.
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
-(void) displayMainMenu{
    MainFilterTableViewController * mainMenu = [[MainFilterTableViewController alloc] init];
    
    mainMenu.delegate = self;
    mainMenu.title =@"Directory";
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom]; 
        // Set its background image for some states...
    UIImage *img  = [UIImage imageNamed: @"Home.png"];
    
    [button setBackgroundImage:img forState:UIControlStateNormal];  
        // Add target to receive Action
    [button addTarget: self action:@selector(unloadModalView) forControlEvents:UIControlEventTouchUpInside]; 
        // Set frame width, height
    button.frame = CGRectMake(0, 0, 25, 23); 
    
    
    mainMenu.navigationItem.rightBarButtonItem =[[[UIBarButtonItem alloc] initWithCustomView: button] autorelease];  

    [self pushViewController:mainMenu animated:YES];
}
-(void)unloadModalView{
    [self dismissModalViewControllerAnimated:YES];
}
-(void) displaySubMenu:(NSString *)subMenuOption{
    if(!subCtrl || ![subMenuOption isEqualToString:subCtrl.filterName]){
        if(subCtrl)
            [subCtrl release];
        subCtrl = [[SubMenuFilterTableViewController alloc ] initWithFilterName:subMenuOption];
        [subCtrl setDelegate:self];
    }
    [self pushViewController:subCtrl animated:YES];

    
}
-(void) displayRectoratServ{
    RectoServTableViewController * rc = [[RectoServTableViewController alloc] init];
    [self pushViewController:rc animated:YES];
}
-(void) displayListOfPerson:(NSArray *)listOfPerson{

    //self.srchBar.text =@"";
    PersonListViewController * personList = [[PersonListViewController alloc]init];
    personList.persons = [listOfPerson retain];
    /*personList.searchBar = self.srchBar;
    [self.srchBar setDelegate:personList]
    [personList.view setNeedsDisplay];
    [self.contactList setDelegate:personList];
    [self.contactList setDataSource:personList];
    [self.contactList beginUpdates];
    [self.contactList deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    [self.contactList insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    [self.contactList endUpdates]; */  
    
    [self pushViewController:personList animated:YES];
     
}
-(void) displayIsLoadingData:(BOOL) loadingInprogress{
    /*if(loadingInprogress)
        [loading startAnimating];
    else
        [loading stopAnimating];*/
}
- (IBAction)displayMainMenuFromButton:(id)sender{
    [self displayMainMenu];
}
-(void) displayInformation:(NSString *) title andSubtitle:(NSString *) texte{
    /*mainTitle.text = title;
    subTitle.text = texte;*/
}
#pragma mark - View lifecycle

/*- (void)viewDidLoad
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
    
}*/
-(void) displayDetailOfPerson:(Person *)Person{
    
}

@end
