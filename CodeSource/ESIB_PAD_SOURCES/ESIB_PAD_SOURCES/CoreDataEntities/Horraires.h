//
//  Horraires.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.07.11.
//  Copyright (c) 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Horraires : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * fromDate;
@property (nonatomic, retain) NSDate * toDate;
@property (nonatomic, retain) NSNumber * dayOfTheWeek;
@property (nonatomic, retain) NSDate * begin;
@property (nonatomic, retain) NSDate * end;
@property (nonatomic, retain) NSString * professeur;
@property (nonatomic, retain) NSString * extension;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * lieu;
@property (nonatomic, retain) NSNumber * latitude;

@end
