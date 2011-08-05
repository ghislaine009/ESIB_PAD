//
//  MenuItemIPad.m
//  ESIB@PAD
//
//  Created by Elias Medawar on 17.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "MenuItemIPad.h"


@implementation MenuItemIPad
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect frameBt = CGRectMake(7, 0, 64, 64);
        [_btn setFrame:frameBt]; 
        frameBt = CGRectMake(79,25,99, 20);
        [_label setFrame:frameBt]; 
        _label.textAlignment = UITextAlignmentLeft;
        [self layoutSubviews];
    }
    return self;
}
@end
