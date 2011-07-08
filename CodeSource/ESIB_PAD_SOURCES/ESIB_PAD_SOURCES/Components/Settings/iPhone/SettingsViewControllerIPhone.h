//
//  SettingsViewController.h
//  ESIB@PAD
//
//  Created by Elias Medawar on 16.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"
#import "SettingsViewController.h"
/**
 Extend the SettingsViewController with adding some comportement spécific to the iPhone interface
 */
@interface SettingsViewControllerIPhone : SettingsViewController {
}
/**
 Called when the user want to back to the main screen of the application
 */
- (IBAction)goHome:(id)sender;

@property (nonatomic, assign) id <MenuItemDelegate> delegate;

@end
