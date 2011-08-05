//
//  ExamResultCellController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 03.08.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExamResultCellController : UITableViewCell {
    IBOutlet UILabel * titreLbl;
    NSString * titre;
    NSString * moyene;

    NSString * ss_titre;
    NSNumber * reussi;
    IBOutlet UILabel * ss_titreLbl;
    IBOutlet UILabel * moyenLbl;

}

@property(nonatomic,retain)  NSNumber * reussi;
@property(nonatomic,retain)  NSString * titre;
@property(nonatomic,retain)  NSString * ss_titre;
@property(nonatomic,retain)  NSString * moyene;



@end
