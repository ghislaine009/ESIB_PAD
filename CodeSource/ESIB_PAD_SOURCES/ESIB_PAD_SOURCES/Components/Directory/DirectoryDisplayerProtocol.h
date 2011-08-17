//
//  DirectoryDisplayerProtocol.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 15.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
/**
 Protocol to bee implemented by object how wants to display the Directory.
 */
@protocol DirectoryDisplayerProtocol <NSObject>
-(void) displayMainMenu;
-(void) displaySubMenu:(NSString *)SubMenuOption;
-(void) displayListOfPerson:(NSArray *)listOfPerson;
-(void) displayRectoratServ;
-(void) displayDetailOfPerson:(Person *)Person;
-(void) displayIsLoadingData:(BOOL) loadingInprogress;
-(void) displayInformation:(NSString *) title andSubtitle:(NSString *) texte;

@end
