//
//  DirectoryDisplayerProtocol.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 15.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@protocol DirectoryDisplayerProtocol <NSObject>
-(void) displayMainMenu;
-(void) displaySubMenu:(NSString *)SubMenuOption;
-(void) displayListOfPerson:(NSArray *)listOfPerson;
-(void) displayListOfRectoratServ:(NSArray *)rectoratServ;
-(void) displayDetailOfPerson:(Person *)Person;
-(void) displayIsLoadingData:(BOOL) loadingInprogress;
-(void) displayInformation:(NSString *) title andSubtitle:(NSString *) texte;

@end
