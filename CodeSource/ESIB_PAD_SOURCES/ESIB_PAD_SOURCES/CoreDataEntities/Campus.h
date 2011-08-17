//
//  Campus.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.06.11.
//  Copyright (c) 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 Represent a single elements in the Data Base of the table Campus
 */
@interface Campus : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * campus;
@property (nonatomic, retain) NSString * resp_def;
@property (nonatomic, retain) NSString * titre_resp;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * prenom_resp;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * img;
@property (nonatomic, retain) NSString * nom_resp;
@property (nonatomic, retain) NSString * adresse;
@property (nonatomic, retain) NSString * extension;

@end
