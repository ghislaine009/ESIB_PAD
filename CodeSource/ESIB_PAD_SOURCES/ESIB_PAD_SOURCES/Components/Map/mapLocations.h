//
//  mapLocations.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 24.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
/**
 Controller for dispaling the annotation for a specific element on a map
 */
@interface MapLocations : NSObject<MKAnnotation> {
    NSString *_name;
    NSString *_description;
    CLLocationCoordinate2D _coordinate;
}

@property (copy) NSString *name;
@property (copy) NSString *description;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name description:(NSString*)description coordinate:(CLLocationCoordinate2D)coordinate;
@end
