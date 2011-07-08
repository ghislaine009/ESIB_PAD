//
//  Actualite.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 06.07.11.
//  Copyright (c) 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Actualite : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * img;
@property (nonatomic, retain) NSString * date_event;
@property (nonatomic, retain) NSNumber * idDB;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * horaire;
@property (nonatomic, retain) NSString * type_event;
@property (nonatomic, retain) NSString * titre;
@property (nonatomic, retain) NSString * ss_titre;

@end
