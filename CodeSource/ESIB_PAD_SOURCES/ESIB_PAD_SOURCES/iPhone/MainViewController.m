//
//  MainViewController.m
//  ESIB@PAD
//
//  Created by Elias Medawar on 15.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "MainViewController.h"
@implementation MainViewController

@synthesize menuView = _menuView;
@synthesize owningController= _owningController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)dealloc
{   
    [_menuView release];
    _menuView = nil;
    [_owningController release];
    _owningController = nil;
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
    //_menuView.contentMode =UIViewContentModeRedraw;
    _menuView.delegate = self;
    [_menuView init];

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
-(void)unloadModalView{
    [self dismissModalViewControllerAnimated:YES];
}
- (void) menuClicked:(NSObject *)src{
     
    if ([((MenuItem *)src).texte isEqualToString:@"Settings"]) {
        SettingsViewControllerIPhone *controller = [[SettingsViewControllerIPhone alloc] initWithNibName:@"SettingsViewControllerIPhone" bundle:nil];
        controller.delegate = self;
    
        controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:controller animated:YES];
       
        [controller autorelease];
    }
    if ([((MenuItem *)src).texte isEqualToString:@"Map"]) {
        MapViewController *controller = [[MapViewController alloc] initWithNibName:@"MapViewiPhone" bundle:nil];
        controller.delegate = self;
        
        controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:controller animated:YES];
        
        [controller autorelease];
    }
    if ([((MenuItem *)src).texte isEqualToString:@"News"]) {
        NewsViewController *controller = [[NewsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        controller.delegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom]; 
            // Set its background image for some states...
        UIImage *img  = [UIImage imageNamed: @"Home.png"];

        [button setBackgroundImage:img forState:UIControlStateNormal];  
            // Add target to receive Action
        [button addTarget: self action:@selector(unloadModalView) forControlEvents:UIControlEventTouchUpInside]; 
            // Set frame width, height
        button.frame = CGRectMake(0, 0, 25, 23); 

      
        controller.navigationItem.rightBarButtonItem =[[[UIBarButtonItem alloc] initWithCustomView: button] autorelease];  
            //  controller.navigationController.navigationItem.title =@"News";
        controller.title=@"News";
        controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:navController animated:YES];
        
        [controller autorelease];
    } if ([((MenuItem *)src).texte isEqualToString:@"Directory"]) {
        DirectoryViewControllerIPhone *controller = [[DirectoryViewControllerIPhone alloc]init ];

        
                    //  controller.navigationController.navigationItem.title =@"News";
        controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:controller animated:YES];
        
        [controller autorelease];
    }
    if ([((MenuItem *)src).texte isEqualToString:@"Calendar"]) {
        CalendarViewController *controller = [[CalendarViewController alloc]init ];
            //controller.delegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom]; 
            // Set its background image for some states...
        UIImage *img  = [UIImage imageNamed: @"Home.png"];
        
        [button setBackgroundImage:img forState:UIControlStateNormal];  
            // Add target to receive Action
        [button addTarget: self action:@selector(unloadModalView) forControlEvents:UIControlEventTouchUpInside]; 
            // Set frame width, height
        button.frame = CGRectMake(0, 0, 25, 23); 
        
        
        controller.navigationItem.rightBarButtonItem =[[[UIBarButtonItem alloc] initWithCustomView: button] autorelease];  
            //  controller.navigationController.navigationItem.title =@"News";
        controller.title=@"Calendar";

        controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:navController animated:YES];
        
        [controller autorelease];
    } if ([((MenuItem *)src).texte isEqualToString:@"Examination"]) {
        ExamResultTableViewController *controller = [[ExamResultTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        controller.delegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom]; 
            // Set its background image for some states...
        UIImage *img  = [UIImage imageNamed: @"Home.png"];
        
        [button setBackgroundImage:img forState:UIControlStateNormal];  
            // Add target to receive Action
        [button addTarget: self action:@selector(unloadModalView) forControlEvents:UIControlEventTouchUpInside]; 
            // Set frame width, height
        button.frame = CGRectMake(0, 0, 25, 23); 
        
        
        controller.navigationItem.rightBarButtonItem =[[[UIBarButtonItem alloc] initWithCustomView: button] autorelease];  
        controller.title=@"Examination result";
        controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:navController animated:YES];
        
        [controller autorelease];
    } 
}

@end
