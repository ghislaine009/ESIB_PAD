//
//  ServRectora.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.06.11.
//  Copyright (c) 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ServRectora : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * responsable;
@property (nonatomic, retain) NSString * titre_resp;
@property (nonatomic, retain) NSString * nom_resp;
@property (nonatomic, retain) NSString * prenom_resp;
@property (nonatomic, retain) NSString * extension;
@property (nonatomic, retain) NSString * email;

@end
