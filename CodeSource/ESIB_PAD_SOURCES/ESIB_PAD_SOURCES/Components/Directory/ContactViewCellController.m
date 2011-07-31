//
//  ContactViewCellController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "ContactViewCellController.h"


@implementation ContactViewCellController
@synthesize left,right;
-(void) setLeft:(NSString *)newLeft{
    [leftLbl setText:newLeft];
}
-(void) setRight:(NSString *)newRight{
    [rightLbl setText:newRight];
}

@end
