//
//  ESIB_PAD_SOURCESAppDelegate_iPhone.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 21.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESIB_PAD_SOURCESAppDelegate.h"
#import "MainViewController.h"

@interface ESIB_PAD_SOURCESAppDelegate_iPhone : ESIB_PAD_SOURCESAppDelegate {
    MainViewController *_mainViewController;
}
@property (nonatomic, retain) IBOutlet MainViewController * mainViewController;

@end
