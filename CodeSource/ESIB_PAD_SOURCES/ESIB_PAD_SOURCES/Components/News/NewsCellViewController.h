//
//  NewsCellViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 05.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NewsCellViewController : UITableViewCell {
    
    IBOutlet UIImageView * img;
    IBOutlet UILabel * titreLbl;
    NSString * titre;
    NSString * ss_titre;
    UIImage * images;
    IBOutlet UILabel * ss_titreLbl;
}

@property(nonatomic,retain)  UIImage * images;
@property(nonatomic,retain)  NSString * titre;
@property(nonatomic,retain)  NSString * ss_titre;

@end
