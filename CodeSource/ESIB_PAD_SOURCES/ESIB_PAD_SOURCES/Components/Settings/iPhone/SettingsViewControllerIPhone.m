//
//  SettingsViewController.m
//  ESIB@PAD
//
//  Created by Elias Medawar on 16.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "SettingsViewControllerIPhone.h"


@implementation SettingsViewControllerIPhone

@synthesize delegate =_delegate;

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
- (IBAction)goHome:(id)sender{
    [_delegate unloadModalView];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
       
    [self.mscrollview setContentSize:(CGSizeMake(270, 400))];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];        // Do any additional setup after loading the view from its nib.
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    UIInterfaceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    if (currentOrientation == UIDeviceOrientationUnknown ||
		currentOrientation == UIDeviceOrientationFaceUp ||
		currentOrientation == UIDeviceOrientationFaceDown)
		return;
    if(currentOrientation==UIInterfaceOrientationPortrait ||currentOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        [self.mscrollview setContentSize:(CGSizeMake(270, 400+kbSize.height))];

    }  
    if (currentOrientation==UIInterfaceOrientationLandscapeRight ||currentOrientation==UIInterfaceOrientationLandscapeLeft ) {
        [self.mscrollview setContentSize:(CGSizeMake(400, 200+kbSize.height ))];

    }
    
    [self.mscrollview setContentOffset:CGPointMake(0.0,self.crntText.frame.origin.y-30) animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIInterfaceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    
    if (currentOrientation == UIDeviceOrientationUnknown ||
		currentOrientation == UIDeviceOrientationFaceUp ||
		currentOrientation == UIDeviceOrientationFaceDown)
		return;
    if(currentOrientation==UIInterfaceOrientationPortrait ||currentOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        [self.mscrollview setContentSize:(CGSizeMake(270, 400))];
        
    }  
    if (currentOrientation==UIInterfaceOrientationLandscapeRight ||currentOrientation==UIInterfaceOrientationLandscapeLeft ) {
        [self.mscrollview setContentSize:(CGSizeMake(400, 200))];
        
    }

    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.mscrollview.contentInset = contentInsets;
    self.mscrollview.scrollIndicatorInsets = contentInsets;
    [self.mscrollview setContentOffset:CGPointMake(0.0,0.0) animated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
