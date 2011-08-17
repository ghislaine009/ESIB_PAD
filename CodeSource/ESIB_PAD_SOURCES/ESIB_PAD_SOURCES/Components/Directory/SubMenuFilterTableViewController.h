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

/**
 Manage the submenu filters view.
 */
@interface SubMenuFilterTableViewController : UITableViewController<CampusDAOProtocol,PersonDAOProtocol,InstitutionDAOProtocol> {
    /**
     Array of objects(Campus or institution) to dispaly 
     */
    NSMutableArray *currentData;
    BOOL campusAsSection;
    NSString * filterName;
    UIImageView * backgroundView;
}

@property (nonatomic, assign) id <DirectoryDisplayerProtocol> delegate;

@property(nonatomic,assign)    NSMutableArray *currentData;
@property(nonatomic,readonly)  NSString * filterName;


-(id)initWithFilterName:(NSString *) name;
/**
 Load a list of campus to choise the sub filter
 */
-(void) initListCampus;
/**
 Load a list of institution to choise the sub filter
 */
-(void) initListInstition;
@end
