//
//  NewsCellViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 05.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncImageView.h"

@interface NewsCellViewController : UITableViewCell {
    
    IBOutlet AsyncImageView * img;
    IBOutlet UILabel * titreLbl;
    NSString * titre;
    NSString * ss_titre;
    UIImage * images;
    IBOutlet UILabel * ss_titreLbl;
}

@property(nonatomic,retain)  AsyncImageView * img;
@property(nonatomic,retain)  NSString * titre;
@property(nonatomic,retain)  NSString * ss_titre;

@end
