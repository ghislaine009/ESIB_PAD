//
//  CalendarViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCCalendar.h"
#import "GCCalendarDayView.h"



@interface CalendarViewController : UIViewController<GCCalendarDataSource, GCCalendarDelegate> {
	UITabBarController *tabController;
    GCCalendarPortraitView *calendar;
}
-(void) resizeCenterSubviews;
@end
