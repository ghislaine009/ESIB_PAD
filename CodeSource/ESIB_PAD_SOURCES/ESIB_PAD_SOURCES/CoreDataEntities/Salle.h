//
//  Salle.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.06.11.
//  Copyright (c) 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 Represent a single elements in the Data Base of the table Salle
 */
@interface Salle : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * num_salle;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * etage;
@property (nonatomic, retain) NSString * campus_id;
@property (nonatomic, retain) NSString * batiment;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * extension;

@end
