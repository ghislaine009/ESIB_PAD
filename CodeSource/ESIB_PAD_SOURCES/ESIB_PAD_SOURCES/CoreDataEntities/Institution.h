//
//  Institution.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.06.11.
//  Copyright (c) 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 Represent a single elements in the Data Base of the table Institution
 */
@interface Institution : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * institution;
@property (nonatomic, retain) NSString * titre;
@property (nonatomic, retain) NSString * responsable;
@property (nonatomic, retain) NSString * prenom;
@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) NSString * extension;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * campus;

@end
