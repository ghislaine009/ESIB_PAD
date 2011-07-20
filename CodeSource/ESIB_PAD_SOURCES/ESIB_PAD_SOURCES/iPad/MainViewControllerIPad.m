//
//  MainViewController.m
//  ESIB@PAD
//
//  Created by Elias Medawar on 17.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "MainViewControllerIPad.h"
#import "NewsViewController.h"
#import "DirectoryViewControllerIPad.h"
#import "SettingsViewController.h"
#import "MapViewController.h"

@implementation MainViewControllerIPad

@synthesize menuView=_menuView;
@synthesize centerView=_centerView;
@synthesize lgView =_lgView;
@synthesize context = _context;

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
    [_crntView release];
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
    // Do any additional setup after loading the view from its nib.
    _menuView.delegate = self;

    [_menuView init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRotate:)
                                                 name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
}
- (void) didRotate:(NSNotification *)notification
{	
    UIInterfaceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    
    if (currentOrientation == UIDeviceOrientationUnknown ||
		currentOrientation == UIDeviceOrientationFaceUp ||
		currentOrientation == UIDeviceOrientationFaceDown){
		return;
    }
    if( UIDeviceOrientationIsLandscape(currentOrientation)){
        if([[_centerView subviews] count] > 0){
            UIView * toResize = [[_centerView subviews]objectAtIndex:0];
            [UIView animateWithDuration:0.5
                                  delay:0
                                options: UIViewAnimationCurveEaseOut
                             animations:^{
                                 CGRect r = [_centerView frame];
                                 r.origin.x = 0;
                                 r.origin.y = 0;
                                 r.size.width = 798;
                                 r.size.height = 602;

                                 toResize.frame= r;
                             } 
                             completion:^(BOOL finished){                             
                                 
                             }];
            
        }
    }else{
        if([[_centerView subviews] count] > 0){
            UIView * toResize = [[_centerView subviews]objectAtIndex:0];
            [UIView animateWithDuration:0.5
                                  delay:0
                                options: UIViewAnimationCurveEaseOut
                             animations:^{
                                 CGRect r = [_centerView frame];
                                 r.origin.x = 0;
                                 r.origin.y = 0;
                                 r.size.width = 542;
                                 r.size.height = 858;
                                 
                                 toResize.frame= r;
                             } 
                             completion:^(BOOL finished){                             
                                 
                             }];
            
        }

    }
    //    [[[self view]superview] setNeedsDisplay];
}

- (void)unloadModalView{
    
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
- (void) loadViewControler: (UIViewController *) controller withTheName:(NSObject *)name{
    [_menuView setUserInteractionEnabled:NO];

    CGRect r = [controller.view frame];
    r.origin.x = 0;
    r.origin.y = [[UIScreen mainScreen] bounds].size.height;
    r.size.width = _centerView.frame.size.width;
    r.size.height = _centerView.frame.size.height;
    controller.view.autoresizesSubviews = YES;
    [controller.view setFrame:r];
    [_centerView addSubview:controller.view];
    
    CGRect newViewFrame = controller.view.frame;
    newViewFrame.origin.y = 0;
    if(_crntView){
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             _crntView.alpha = 0;
                             CGRect rect = [_lgView frame];
                             rect.origin.y = ((MenuItem *)name).frame.origin.y+_menuView.frame.origin.y-43;
                             _lgView.frame = rect;
                             
                         } 
                         completion:^(BOOL finished){
                         }];
        [UIView animateWithDuration:0.5
                              delay:0.9
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             controller.view.frame= newViewFrame;
                             
                         } 
                         completion:^(BOOL finished){
                             [_crntView removeFromSuperview];
                             _crntView = controller.view;
                             [_menuView setUserInteractionEnabled:TRUE];
                             
                         }];
        
    }else{
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             controller.view.frame= newViewFrame;
                             CGRect rect = [_lgView frame];
                             rect.origin.y = ((MenuItem *)name).frame.origin.y+_menuView.frame.origin.y-43;
                             _lgView.frame = rect;
                         } 
                         completion:^(BOOL finished){
                             _crntView = controller.view;
                             [_menuView setUserInteractionEnabled:TRUE];
                             
                             
                         }];
        
        
        
    }
    [UIView commitAnimations];
    

}
- (void) menuClicked:(NSObject *)name{
   if ([((MenuItem *)name).texte isEqualToString:@"Settings"]) {
        SettingsViewController *controller = [[SettingsViewController alloc] initWithNibName:@"SettingsViewControllerIPad" bundle:nil];
       [self loadViewControler:controller withTheName:name];
                
   }else if ([((MenuItem *)name).texte isEqualToString:@"Map"]) {
       
       MapViewController *controller = [[MapViewController alloc] initWithNibName:@"MapViewIPad" bundle:nil];
       [self loadViewControler:controller withTheName:name];
   }else if ([((MenuItem *)name).texte isEqualToString:@"News"]) {
       NewsViewController *controller = [[NewsViewController alloc] initWithStyle:UITableViewStyleGrouped];
       [self loadViewControler:controller withTheName:name];
   }else if ([((MenuItem *)name).texte isEqualToString:@"Directory"]) {
       DirectoryViewControllerIPad *controller = [[DirectoryViewControllerIPad alloc] initWithNibName:@"DirectoryViewControllerIPad" bundle:nil];
       [self loadViewControler:controller withTheName:name];
   }

}

@end
