//
//  MainViewController.h
//  ESIB@PAD
//
//  Created by Elias Medawar on 17.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenuIPad.h"
#import "MenuItemDelegate.h"
#import "SettingsViewController.h"
#import "MapViewController.h"

@interface MainViewControllerIPad : UIViewController<MenuItemDelegate> {
    UIView *_crntView;
    NSManagedObjectContext *_context;    

}
@property (retain) IBOutlet UIView *centerView;
@property (retain) IBOutlet MainMenuIPad *menuView;
@property (retain) IBOutlet UIImageView *lgView;
@property (nonatomic, retain) NSManagedObjectContext *context;

/*!
 @function menuClicked 
 Respond to the click on a Menu item messages.
 Is responsible to load the corresponding controller of the clicked menu item.
 */
- (void) menuClicked:(NSObject *)src;
@end
