//
//  DirectoryViewControllerIPad.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 15.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainFilterTableViewController.h"
#import "DirectoryDisplayerProtocol.h"
#import <QuartzCore/QuartzCore.h>

@interface DirectoryViewControllerIPad : UIViewController<DirectoryDisplayerProtocol> {
    IBOutlet UITableView * mainMenuFilter;
    IBOutlet UITableView * subMenuFilter;
    IBOutlet UIView * backView;
    IBOutlet UILabel * mainChoise;
    CGRect mainBeforeModif;
    CGRect subBeforeModif;

}
@property (nonatomic,retain)  UITableView * mainMenuFilter;
@property (nonatomic,retain)  UITableView * subMenuFilter;
@property (nonatomic,retain)  UIView * backView;


@property (nonatomic,retain)  UILabel * mainChoise;

@end
