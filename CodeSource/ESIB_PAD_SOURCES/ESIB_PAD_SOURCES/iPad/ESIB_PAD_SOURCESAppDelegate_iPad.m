//
//  ESIB_PAD_SOURCESAppDelegate_iPad.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 21.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "ESIB_PAD_SOURCESAppDelegate_iPad.h"

@implementation ESIB_PAD_SOURCESAppDelegate_iPad

@synthesize mainViewController=_mainViewController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window.rootViewController = self.mainViewController;
    
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
