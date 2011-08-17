//
//  ExamResultCellController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 03.08.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Class that manage a cell of the exam result table.
 */
@interface ExamResultCellController : UITableViewCell {
    /**
     The label of the title linked in the ExameCell.xib file to the corresponding UILabel
     */
    IBOutlet UILabel * titreLbl;
    /**
     The current title
     */
    NSString * titre;
    /**
     The average obtained for this exam 
     */
    NSString * moyene;
    /**
     The subtitle of the cell used to display the obtained grade
     */
    NSString * ss_titre;
    /**
     A integer value if equl ot 1 the exam is passed... 
     */
    NSNumber * reussi;
    /**
     The label of the subtitel linked in the ExameCell.xib file to the corresponding UILabel
     */
    IBOutlet UILabel * ss_titreLbl;
    /**
     The label of the average linked in the ExameCell.xib file to the corresponding UILabel
     */
    IBOutlet UILabel * moyenLbl;

}

@property(nonatomic,retain)  NSNumber * reussi;
@property(nonatomic,retain)  NSString * titre;
@property(nonatomic,retain)  NSString * ss_titre;
@property(nonatomic,retain)  NSString * moyene;



@end
