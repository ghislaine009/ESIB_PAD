//
//  SettingsViewsController.m
//  ESIB@PAD
//
//  Created by Elias Medawar on 20.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "SettingsViewController.h"


@implementation SettingsViewController

@synthesize mscrollview;
@synthesize login;
@synthesize pwd;
@synthesize url;
@synthesize retenir;
@synthesize mapDisp;
@synthesize crntText;
@synthesize sDao;


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
    /*[mscrollview release];
    [login release];
    [pwd release];
    [url release];
    [retenir release];
    [mapDisp release];*/
    [sDao release];

    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    sDao = [[SettingsDAO alloc ]init];
    NSLog(@"%@",sDao.url);
    [self registerNotifications];
    [self refreshDisplay];
    
    [super viewDidLoad];
}
-(void) refreshDisplay{
    login.text = sDao.login;
    pwd.text = sDao.pasword;
    url.text = sDao.url;
    [retenir setOn:sDao.retenir];
    if([sDao.mapType isEqual:@"sat"]){
        [mapDisp setSelectedSegmentIndex:0];

    }else{
        [mapDisp setSelectedSegmentIndex:1];
    }
}

-(void) saveChangement{
    sDao.login=login.text;
    sDao.pasword=pwd.text;
    sDao.url=url.text;
    sDao.retenir =retenir.on;
    if(mapDisp.selectedSegmentIndex == 0){
        [sDao setMapType:@"sat"];
    }else{
        [sDao setMapType:@"plan"];
    }
    [sDao save];
}

-(void) registerNotifications{
    [login addTarget:self action:@selector(fieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
    [url addTarget:self action:@selector(fieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
    [pwd addTarget:self action:@selector(fieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
    [retenir addTarget:self action:@selector(fieldChanged:) forControlEvents:UIControlEventValueChanged];
    [mapDisp addTarget:self action:@selector(fieldChanged:) forControlEvents:UIControlEventValueChanged];
    
    [login addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [url addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [pwd addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    
    // We set self as delgate so we can overite the textFieldShouldReturn return comportement
    [login setDelegate:self];  
    [url setDelegate:self];  
    [pwd setDelegate:self];  

    [self refreshDisplay];
}
- (void) fieldChanged:(id) sender {
    [sender resignFirstResponder];
    [self saveChangement];
}
- (void) beginEditing:(id) sender {
    crntText = (UITextField *)sender;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    crntText = nil;
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)looseFocus:(id)sender{
    [crntText resignFirstResponder];
    [sender resignFirstResponder];
}
- (IBAction)resetSettings:(id)sender{
    [sDao reset];
    [self refreshDisplay];
}

@end
