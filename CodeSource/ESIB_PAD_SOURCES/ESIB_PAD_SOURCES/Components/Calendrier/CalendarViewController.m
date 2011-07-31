//
//  CalendarViewController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "CalendarViewController.h"
#define xCenter 0
#define yCenter 0

#define widthLand 798
#define heightLand 602
#define widthPort 542
#define heightPort 858


@implementation CalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    calendar= [[GCCalendarPortraitView alloc] init] ;

	calendar.dataSource = self;
    calendar.delegate = self;

    self.view = calendar.view;
    calendar.view.frame = self.view.frame;
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRotate:)
                                                 name:@"UIDeviceOrientationDidChangeNotification" object:nil];
       
    [self resizeCenterSubviews];

}
-(void) resizeCenterSubviews{
    UIInterfaceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    
    if (currentOrientation == UIDeviceOrientationUnknown ||
		currentOrientation == UIDeviceOrientationFaceUp ||
		currentOrientation == UIDeviceOrientationFaceDown){
		currentOrientation = self.interfaceOrientation;
    }
    UIView *_centerView = calendar.view;
    if( UIDeviceOrientationIsLandscape(currentOrientation)){
        CGRect r = [_centerView frame];
        r.origin.x = xCenter;
        r.origin.y = yCenter;
        r.size.width = widthLand;
        r.size.height = heightLand;
        [_centerView setFrame:r];
        [_centerView setNeedsDisplay];
        [_centerView setNeedsLayout];
    
    }else{
        
        CGRect r = [_centerView frame];
        r.origin.x = xCenter;
        r.origin.y = yCenter;
        r.size.width = widthPort;
        r.size.height = heightPort;
        [_centerView setFrame:r];
        [_centerView setNeedsDisplay];
        [_centerView setNeedsLayout];    
    }

        [calendar resize];
}
- (void) didRotate:(NSNotification *)notification
{	
    [self resizeCenterSubviews];
}


- (void)viewDidUnload
{
       
    [super viewDidUnload];

}



#pragma mark GCCalendarDataSource
- (NSArray *)calendarEventsForDate:(NSDate *)date {
	NSMutableArray *events = [NSMutableArray array];
	
	NSDateComponents *components = [[NSCalendar currentCalendar] components:
									(NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit)
																   fromDate:date];
	[components setSecond:0];
    
        // create 5 calendar events that aren't all day events
	for (NSInteger i = 0; i < 5; i++) {
		GCCalendarEvent *event = [[GCCalendarEvent alloc] init];
		event.color = [[GCCalendar colors] objectAtIndex:i];
		event.allDayEvent = NO;
		event.eventName = [event.color capitalizedString];
		event.eventDescription = event.eventName;
		
		[components setHour:12 + i];
		[components setMinute:0];
		
		event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
		
		[components setMinute:50];
		
		event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
		
		[events addObject:event];
        event = [[GCCalendarEvent alloc] init];
		event.color = [[GCCalendar colors] objectAtIndex:i+1];
		event.allDayEvent = NO;
		event.eventName = [event.color capitalizedString];
		event.eventDescription = event.eventName;
		
		[components setHour:12 + i];
		[components setMinute:0];
		
		event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
		
		[components setMinute:20];
		
		event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];

        [events addObject:event];

		[event release];
	}
    
    
	GCCalendarEvent *evt = [[GCCalendarEvent alloc] init];
	evt.color = [[GCCalendar colors] objectAtIndex:1];
	evt.allDayEvent = NO;
	evt.eventName = @"Test event";
	evt.eventDescription = @"Description for test event. This is intentionnaly too long to stay on a single line.";
	[components setHour:18];
	[components setMinute:0];
	evt.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
	[components setHour:20];
	evt.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
	[events addObject:evt];
	[evt release];
	
   
	
	return events;
}

#pragma mark GCCalendarDelegate
- (void)calendarTileTouchedInView:(GCCalendarView *)view withEvent:(GCCalendarEvent *)event {
	NSLog(@"Touch event %@", event.eventName);
}
- (void)calendarViewAddButtonPressed:(GCCalendarView *)view {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
