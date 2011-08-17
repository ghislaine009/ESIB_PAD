//
//  EventOnMapDisplayer.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 04.08.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import "SettingsDAO.h"
#import "Horraires.h"
#import "MapLocations.h"

#define METERS_PER_MILE_DET 2000

/**
 Dispalay a map with an anotation at the palce  course occured.
 */
@interface EventOnMapDisplayer : UIViewController {
    MKMapView *_map;
    Horraires * horraire;
}
@property (nonatomic, retain)  Horraires *horraire;

@end
