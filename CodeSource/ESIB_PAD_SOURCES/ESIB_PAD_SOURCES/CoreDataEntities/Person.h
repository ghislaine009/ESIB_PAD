//
//  Person.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.06.11.
//  Copyright (c) 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 Represent a single elements in the Data Base of the table Person
 */
@interface Person : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * prenom;
@property (nonatomic, retain) NSString * Institution;
@property (nonatomic, retain) NSString * carriere;
@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * titre;
@property (nonatomic, retain) NSString * extension;
@property (nonatomic, retain) NSString * campus;

@end
