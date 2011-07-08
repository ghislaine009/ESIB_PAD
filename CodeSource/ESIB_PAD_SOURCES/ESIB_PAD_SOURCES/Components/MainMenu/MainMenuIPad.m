//
//  MainMenuIPad.m
//  ESIB@PAD
//
//  Created by Elias Medawar on 17.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "MainMenuIPad.h"


@implementation MainMenuIPad
-(id)init{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuItemsParam" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _menuItems = [[NSMutableArray alloc]init];
    dicMenuItems= [dict valueForKey:@"ListItem"];
    dicMenuItemsLogo = [dict valueForKey:@"ItemLogo"];
    int HeightElement = [[dict valueForKey:@"HeightElementIPad"] intValue];
    for (int i =0; i<[dicMenuItems count];i++) {
        MenuItemIPad *myItem;
        myItem=[[MenuItemIPad alloc]init];
        myItem.logo = [UIImage imageNamed:[dicMenuItemsLogo valueForKey:[dicMenuItems objectAtIndex:i]]];
        myItem.texte =[dicMenuItems objectAtIndex:i];
        myItem.frame = CGRectMake(10, (i*HeightElement), HeightElement, 120);
        [_menuItems addObject:myItem];
        [self addSubview:myItem];
        myItem.delegate = self.delegate;
        [myItem autorelease];
    }    
    [dict release];
    return self;
}
@end
