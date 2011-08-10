//
//  MenuItem.m
//  ESIB@PAD
//
//  Created by Elias Medawar on 16.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "MenuItem.h"


@implementation MenuItem
@synthesize texte = _texte;
@synthesize logo =_logo;
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(15, 0, 64, 64);
        [_btn addTarget:self action:@selector(btnCliked:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
        _label = [[UILabel alloc]init];
        _label.frame = CGRectMake(0,68,99, 20);
        _label.textAlignment = UITextAlignmentCenter;
        _label.textColor =[UIColor whiteColor];
        _label.backgroundColor = [UIColor clearColor];
        [self addSubview:_label];
        [self addSubview:_btn];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
}
 */

- (void)btnCliked:(id)sender {// TODO Other strat then networkActivityIndicatorVisible
    if(![UIApplication sharedApplication].networkActivityIndicatorVisible){
        [self.delegate menuClicked:self];
        
    }
}

- (void) setLogo:(UIImage *)logo{
    [_btn setImage:logo forState: UIControlStateNormal];
}
- (void) setTexte:(NSString *)texte{
    [_texte release];
    _texte = texte;
    [_label setText:texte];
}

- (void)dealloc
{
    [_texte release];
    _texte = nil;
    [_logo release];
    _logo = nil;
    [_label release];
    _label = nil; 
    [_btn release];
    _btn = nil;   
    [super dealloc];
}

@end
