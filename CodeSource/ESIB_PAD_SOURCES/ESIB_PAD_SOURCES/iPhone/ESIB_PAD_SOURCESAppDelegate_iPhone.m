//
//  ESIB_PAD_SOURCESAppDelegate_iPhone.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 21.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "ESIB_PAD_SOURCESAppDelegate_iPhone.h"
@implementation UINavigationBar (UINavigationBarCategory)
 - (void)drawRect:(CGRect)rect {
     UIImage *img  = [UIImage imageNamed: @"HeaderNavBar.png"];
     [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
 
 }
 @end
@implementation ESIB_PAD_SOURCESAppDelegate_iPhone

@synthesize mainViewController=_mainViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window.rootViewController = self.mainViewController;
        //NSManagedObjectContext *context = [self managedObjectContext];
    //[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)dealloc
{
    [_mainViewController release];
    _mainViewController = nil;
	[super dealloc];
}

@end
