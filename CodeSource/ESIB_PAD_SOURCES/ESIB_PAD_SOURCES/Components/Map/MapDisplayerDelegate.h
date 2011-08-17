//
//  MapDelegate.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 28.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Salle.h"
/**
 This protocol define function to be implemented by the map displayer component.
 */
@protocol MapDisplayerDelegate

-(void) displaySalleOnMap:(Salle *)salle;
-(void) displayPersonOnMap:(Person *)person;
-(void) campusSelected:(NSNumber *)selectedCampusIndex;
-(void) removeListFromTopView;

@end
