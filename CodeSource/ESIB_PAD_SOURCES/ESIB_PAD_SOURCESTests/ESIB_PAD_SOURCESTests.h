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
#import "PersonDAO.h"
#import "HorraireDAO.h"
#import "ExamResultDAO.h"

@interface ESIB_PAD_SOURCESTests : SenTestCase <CampusDAOProtocol,UIAlertViewDelegate,NewsDADProtocol,PersonDAOProtocol,HorraireDAOProtocol,ExamResultDAOProtocol>{
@private
    NSArray * persons ;
    NSArray * salles ;
    NSArray * listFirstCall;
    NSArray * listSeconCall;

    NSArray * listBatiment;
    NSCondition * condition;
    NSString * tmpHost;
    BOOL dataRecieved;
    BOOL finishAsyncOperation;

}

-(void) waitForEnableConnection;

-(void) waitForDisableConnection;

@end
