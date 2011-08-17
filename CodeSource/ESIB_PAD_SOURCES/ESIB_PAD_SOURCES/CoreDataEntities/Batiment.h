//
//  Batiment.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.06.11.
//  Copyright (c) 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 Represent a single elements in the Data Base of the table Batiment
 */
@interface Batiment : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * campus;
@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;

@end
