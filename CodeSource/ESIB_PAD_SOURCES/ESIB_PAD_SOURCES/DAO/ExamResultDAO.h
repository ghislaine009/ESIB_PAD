//
//  ExamResultDAO.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 03.08.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDAO.h"
#import "ExamResult.h"

@protocol ExamResultDAOProtocol 
-(void) displayExamResult: (NSArray *)listOfExam;
@end

@interface ExamResultDAO : GenericDAO {
    
}
@property (retain)  id<ExamResultDAOProtocol> delegate;

- (void)getExamResult;
@end






