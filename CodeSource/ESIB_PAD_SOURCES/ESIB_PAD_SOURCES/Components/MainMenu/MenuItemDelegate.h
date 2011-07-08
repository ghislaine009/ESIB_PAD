//
//  MenuItemDelegate.h
//  ESIB@PAD
//
//  Created by Elias Medawar on 17.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuItemDelegate 
    - (void) menuClicked: (NSObject *) src;
    - (void)unloadModalView;
@end
