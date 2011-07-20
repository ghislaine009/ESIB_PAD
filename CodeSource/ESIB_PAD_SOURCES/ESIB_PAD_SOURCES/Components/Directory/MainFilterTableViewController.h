//
//  MainFilterTableViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 15.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectoryDisplayerProtocol.h"

@interface MainFilterTableViewController : UITableViewController {
    NSArray * listMainMenu;
}

@property (nonatomic, retain) NSArray * listMainMenu;
@property (nonatomic, retain) id <DirectoryDisplayerProtocol> delegate;

@end
