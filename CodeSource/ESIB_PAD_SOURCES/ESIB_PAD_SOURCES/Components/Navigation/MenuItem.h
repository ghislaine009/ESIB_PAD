//
//  MenuItem.h
//  ESIB@PAD
//
//  Created by Elias Medawar on 16.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemDelegate.h"

/**
 This class represent an Item of the menu with here Desciption text and here Logo
 */
@interface MenuItem : UIView {
    UIImage *_logo;
    UILabel *_label;
    UIButton *_btn;
    NSString *_texte;
}
@property (nonatomic, assign) id <MenuItemDelegate> delegate;

@property (retain) UIImage *logo;
@property (retain) NSString *texte;

@end

