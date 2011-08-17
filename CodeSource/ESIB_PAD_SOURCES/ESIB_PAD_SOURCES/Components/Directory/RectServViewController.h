//
//  RectServViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 20.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Manage the view of cells in the RectServTabviewController
 */
@interface RectServViewController : UITableViewCell {
    IBOutlet UILabel * titreLbl;
    NSString * titre;
    NSString * ss_titre;
    IBOutlet UILabel * ss_titreLbl;  
}
@property(nonatomic,retain)  NSString * titre;
@property(nonatomic,retain)  NSString * ss_titre;
@end
