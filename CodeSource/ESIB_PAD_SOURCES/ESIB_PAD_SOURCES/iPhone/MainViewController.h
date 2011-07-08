//
//  MainViewController.h
//  ESIB@PAD
//
//  Created by Elias Medawar on 15.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenu.h"
#import "MenuItem.h"
#import "SettingsViewControllerIPhone.h"
#import "MainViewController.h"
#import "MenuItemDelegate.h"
#import "MapViewController.h"
#import "NewsViewController.h"


/*!
 @class MainViewController
 @abstract The main view controller of the IPhone view.
 */

@interface MainViewController : UIViewController<MenuItemDelegate> {
    /*! @var  _menuView
     @abstract The main menu of the program
     */
    MainMenu *_menuView;
}
/*!
    This is the sub view controller, it's the temporary loaded modal controller how manage the current view.
 */
@property (nonatomic, retain) UIViewController *owningController;
@property (retain) IBOutlet MainMenu *menuView;
/*!
 @function menuClicked 
 Respond to the click on a Menu item messages.
 Is responsible to load the corresponding controller of the clicked menu item.
 */
- (void) menuClicked:(NSObject *)src;

@end
