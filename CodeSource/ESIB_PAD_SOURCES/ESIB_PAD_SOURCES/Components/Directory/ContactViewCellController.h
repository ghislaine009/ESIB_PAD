//
//  ContactViewCellController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContactViewCellController : UITableViewCell {
    IBOutlet UILabel * leftLbl;
    IBOutlet UILabel * rightLbl;  
    NSString * left;
    NSString * right;
}
@property(nonatomic,retain)  NSString * left;
@property(nonatomic,retain)  NSString * right;

@end
