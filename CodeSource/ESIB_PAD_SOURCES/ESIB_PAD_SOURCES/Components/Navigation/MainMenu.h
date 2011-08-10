//
//  MainMenu.h
//  ESIB@PAD
//
//  Created by Elias Medawar on 16.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"
#import "MenuItemDelegate.h"
/**
 * Class of the main menu of the application
 * this class represent the items in a grid.
 */
@interface MainMenu : UIView<MenuItemDelegate> {
    /**
     the list of all  menu items object
     */
    NSMutableArray *_menuItems;
    /**
     the list of logo of all menu items loaded from the MenuItemsParam.plist file
     */
    NSDictionary *dicMenuItemsLogo;
    /**
     the list of logo of all menu items loaded from the MenuItemsParam.plist file
     */
    NSArray *dicMenuItems;

}

@property (nonatomic, assign) id <MenuItemDelegate> delegate;
/**
 This method redraw the menu, if the device orientation change, this method have to be executed!
 */
- (void)refresh;
/**
 This method is called from the notification center when the device orientation change.
 */
- (void) didRotate:(NSNotification *)notification;

@end
