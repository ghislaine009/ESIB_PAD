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

@protocol MapDisplayerDelegate
-(void) displayPersonList: (NSArray *)personArray;
-(void) displaySallesList: (NSArray *)salleArray;
-(void) displayPersonOnMap:(Person *)person;
-(void) displaySalleOnMap:(Salle *)salle;
-(void) displayListOfCampus:(NSArray *)campusArray;
-(void) displayAllCampusOnMap:(NSArray *)campusArray;

-(void) displayBatiments:(NSArray *)batimetnsArray;
-(void) campusSelected:(NSNumber *)selectedCampusIndex;
-(void) removeListFromTopView;

@end
