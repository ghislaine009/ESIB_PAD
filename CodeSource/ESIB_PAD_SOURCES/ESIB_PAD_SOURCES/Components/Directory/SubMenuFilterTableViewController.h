//
//  SubMenuFilterTableViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 18.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CampusDAO.h"
#import "InstitutionDAO.h"
#import "PersonDAO.h"
#import "DirectoryDisplayerProtocol.h"
@interface SubMenuFilterTableViewController : UITableViewController<CampusDAOProtocol,PersonDAOProtocol,InstitutionDAOProtocol> {
    NSMutableArray *currentData;// Array of Array
    NSMutableArray *sectionName;// Array of strings
    BOOL campusAsSection;
    NSString * filterName;
    UIImageView * backgroundView;
}

@property (nonatomic, assign) id <DirectoryDisplayerProtocol> delegate;

@property(nonatomic,assign)    NSMutableArray *currentData;
@property(nonatomic,assign)    NSMutableArray *sectionName;
@property(nonatomic,readonly)  NSString * filterName;


-(id)initWithFilterName:(NSString *) name;
-(void) initListCampus;
-(void) initListInstition;
@end
