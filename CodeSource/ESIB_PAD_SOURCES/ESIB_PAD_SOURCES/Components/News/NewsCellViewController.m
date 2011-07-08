//
//  NewsCellViewController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 05.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "NewsCellViewController.h"


@implementation NewsCellViewController
@synthesize images,titre,ss_titre;

-(void) setTitre:(NSString *)newTitre{
    [titreLbl setText:newTitre];
}
-(void) setSs_titre:(NSString *)newSs_titre{
    [ss_titreLbl setText:newSs_titre];
}
-(void) setImages:(UIImage *)newImages{
     [img setImage:newImages ];
}
@end
