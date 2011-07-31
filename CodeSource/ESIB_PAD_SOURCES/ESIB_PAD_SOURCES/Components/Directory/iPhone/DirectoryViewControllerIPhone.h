//
//  DirectoryViewControllerIPhone.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 15.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainFilterTableViewController.h"
#import "SubMenuFilterTableViewController.h"
#import "DirectoryDisplayerProtocol.h"
#import "RectoServTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PersonListViewController.h"
@interface DirectoryViewControllerIPhone : UINavigationController<DirectoryDisplayerProtocol> {
    SubMenuFilterTableViewController *subCtrl;

}

@end
