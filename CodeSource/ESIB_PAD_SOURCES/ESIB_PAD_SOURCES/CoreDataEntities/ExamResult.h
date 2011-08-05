//
//  ExamResult.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 03.08.11.
//  Copyright (c) 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ExamResult : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * anne;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * moyeneClassee;
@property (nonatomic, retain) NSNumber * reussi;

@end
