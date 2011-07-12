//
//  ESIB_PAD_SOURCESTests.h
//  ESIB_PAD_SOURCESTests
//
//  Created by Elias Medawar on 21.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "SettingsDAO.h"
#import "CampusDAO.h"
#import "Campus.h"
#import "MapDisplayerDelegate.h"

@interface ESIB_PAD_SOURCESTests : SenTestCase <MapDisplayerDelegate,UIAlertViewDelegate>{
@private
    NSArray * persons ;
    NSArray * salles ;
    NSArray * listCampus;
    NSArray * listCampus2;

    NSArray * listBatiment;
    NSCondition * condition;
    BOOL dataRecieved;
    BOOL finishListCampus;

}
-(void)aMethod:(id)param;
-(void)viewAlert:(id)param;
@end
