//
//  ESIB_PAD_SOURCESAppDelegate_iPad.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 21.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESIB_PAD_SOURCESAppDelegate.h"
#import "MainViewControllerIPad.h"
@interface ESIB_PAD_SOURCESAppDelegate_iPad : ESIB_PAD_SOURCESAppDelegate {
    MainViewControllerIPad *_mainViewController;
}
@property (nonatomic, retain) IBOutlet MainViewControllerIPad * mainViewController;

@end
