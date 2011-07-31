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

#define widthLand 798
#define xCenter 206
#define yCenter 121

#define heightLand 602
#define widthPort 542
#define heightPort 858

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

-(void) resizeCenterSubviews;
@end
