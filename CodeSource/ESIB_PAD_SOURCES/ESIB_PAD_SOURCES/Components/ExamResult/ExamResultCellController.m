//
//  ExamResultCellController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 03.08.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "ExamResultCellController.h"


@implementation ExamResultCellController
@synthesize reussi,titre,ss_titre,moyene;

-(void) setTitre:(NSString *)newTitre{
    [titreLbl setText:newTitre];
}
-(void) setMoyene:(NSString *)newMoyenne{
    NSString * s = [[NSString alloc] initWithFormat:@"Moyenne: %@",newMoyenne];
    [moyenLbl setText:s];
    [s release];
}
-(void) setSs_titre:(NSString *)newSs_titre{
    [ss_titreLbl setText:newSs_titre];
}
-(void) setReussi:(NSNumber *)newReussiStatus{
    if([newReussiStatus intValue] == 1){
        ss_titreLbl.textColor = [UIColor greenColor];
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        ss_titreLbl.textColor = [UIColor redColor];
        self.accessoryType = UITableViewCellAccessoryNone;


    }
}

@end
