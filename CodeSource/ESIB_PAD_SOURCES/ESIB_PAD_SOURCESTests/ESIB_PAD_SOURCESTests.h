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
#import "NewsDAO.h"
#import "Actualite.h"
#import "Campus.h"
#import "MapDisplayerDelegate.h"
#import "NewsDisplayerProtocol.h"

@interface ESIB_PAD_SOURCESTests : SenTestCase <MapDisplayerDelegate,UIAlertViewDelegate,NewsDisplayerProtocol>{
@private
    NSArray * persons ;
    NSArray * salles ;
    NSArray * listFirstCall;
    NSArray * listSeconCall;

    NSArray * listBatiment;
    NSCondition * condition;
    BOOL dataRecieved;
    BOOL finishAsyncOperation;

}
-(void)aMethod:(id)param;
-(void)viewAlert:(id)param;

-(void) waitForEnableConnection;

-(void) waitForDisableConnection;

@end
