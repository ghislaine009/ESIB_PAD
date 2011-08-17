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
#import "HorraireDAO.h"
#import "EventOnMapDisplayer.h"
#import "RotableUINavController.h"
/** 
 Class responsible to matnage the content of the calendar.
 */
@interface CalendarViewController : UIViewController<GCCalendarDataSource, GCCalendarDelegate,HorraireDAOProtocol,UIGestureRecognizerDelegate> {
	
    /**
     The view of the calendar
     */
     GCCalendarPortraitView *calendar;
    /** 
     The DAO to acces the data
     */
    HorraireDAO * hDao;

}
/**
 Function responsible to recize the calendar when we rotate the device.
 */
-(void) resizeCenterSubviews;
@end
