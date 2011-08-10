//
//  MainMenu.m
//  ESIB@PAD
//
//  Created by Elias Medawar on 16.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "MainMenu.h"

@implementation MainMenu

@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void) menuClicked:(NSString *)name{
    
}
- (void)unloadModalView{}


-(id)init{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuItemsParam" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _menuItems = [[NSMutableArray alloc]init];
    dicMenuItems= [dict valueForKey:@"ListItem"];
    dicMenuItemsLogo = [dict valueForKey:@"ItemLogo"];
    int crnt_width = [self bounds].size.width;
    int widthElement = [[dict valueForKey:@"WidthElement"] intValue];
    int nb_element = crnt_width / widthElement;
    int espaceSup = (crnt_width-(nb_element*widthElement))/2;
    int y =0;
    
    for (int i =0; i<[dicMenuItems count];i++) {
        MenuItem *myItem;
        myItem=[[MenuItem alloc]init];
        myItem.logo = [UIImage imageNamed:[dicMenuItemsLogo valueForKey:[dicMenuItems objectAtIndex:i]]];
        myItem.texte =[dicMenuItems objectAtIndex:i];
        if(i%nb_element==0){
            myItem.frame = CGRectMake(espaceSup, y, 100, 100);
        }else{
            myItem.frame = CGRectMake((i%nb_element*widthElement)+espaceSup, y, 100, 100);
        }
        if((i+1)%nb_element==0){
            y = y + [[dict valueForKey:@"HeightElement"] intValue];
        }
        [_menuItems addObject:myItem];
        [self addSubview:myItem];
        myItem.delegate = self.delegate;
        [myItem autorelease];
        
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                        selector:@selector(didRotate:)
                                        name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
    [dict release];
    return self;
}
- (void) didRotate:(NSNotification *)notification
{	
    [self refresh];
}

-(void)refresh{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuItemsParam" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    int i=0;
    int crnt_width =0;
    UIInterfaceOrientation currentOrientation = [[UIDevice currentDevice] orientation];

    if (currentOrientation == UIDeviceOrientationUnknown ||
		currentOrientation == UIDeviceOrientationFaceUp ||
		currentOrientation == UIDeviceOrientationFaceDown){
        [dict release];
		return;
    }
    if(currentOrientation==UIInterfaceOrientationPortrait ||currentOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        crnt_width = [[UIScreen mainScreen] bounds].size.width;
    }  
    if (currentOrientation==UIInterfaceOrientationLandscapeRight ||currentOrientation==UIInterfaceOrientationLandscapeLeft ) {
        crnt_width = [[UIScreen mainScreen] bounds].size.height;
    }
    int widthElement = [[dict valueForKey:@"WidthElement"] intValue];
    int nb_element = crnt_width / widthElement;
    int espaceSup = (crnt_width-(nb_element*widthElement))/2;
    int y =0;
    [UIView beginAnimations:nil context:nil];
    for (MenuItem * object in _menuItems) {
        CGRect beforPlacement = object.frame;
        if(i%nb_element==0){
            beforPlacement.origin.x = espaceSup;
            beforPlacement.origin.y = y;
        }else{
            beforPlacement.origin.x = (i%nb_element*widthElement)+espaceSup;
            beforPlacement.origin.y = y;
        }
        if((i+1)%nb_element==0){
            y = y + [[dict valueForKey:@"HeightElement"] intValue];
        }
        i++;
        object.frame = beforPlacement;
        
    }
    [dict release];
    [UIView setAnimationDuration:2.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView commitAnimations];
}
- (void)dealloc
{   //[_menuItems release];
    //s_menuItems = nil;
        //[dicMenuItems release];
        //dicMenuItems = nil;
    [super dealloc];
}

@end
