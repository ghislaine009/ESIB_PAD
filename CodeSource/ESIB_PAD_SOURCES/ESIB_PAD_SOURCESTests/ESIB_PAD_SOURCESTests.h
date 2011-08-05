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
#import "Actualite.h"
#import "Campus.h"
#import "NewsDAO.h"

@interface ESIB_PAD_SOURCESTests : SenTestCase <CampusDAOProtocol,UIAlertViewDelegate,NewsDADProtocol>{
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

-(void) waitForEnableConnection;

-(void) waitForDisableConnection;

@end
