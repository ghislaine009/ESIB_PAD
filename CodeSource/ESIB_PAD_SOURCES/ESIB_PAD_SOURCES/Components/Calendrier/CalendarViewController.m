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

#define widthLandiPHone 480
#define heightLandiPHone 252
#define widthPortiPHone 320
#define heightPortiPHone 402


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

-(void) planningDataLoadedFromInternet{
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    if(!hDao)
        hDao = [[HorraireDAO alloc] init];
    hDao.delegate = self;
    [hDao loadHorraire];
 
    
}
-(void) resizeCenterSubviews{
    UIInterfaceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    if(currentOrientation == UIDeviceOrientationFaceUp ||
       currentOrientation == UIDeviceOrientationFaceDown){
        return;
    }
    if (currentOrientation == UIDeviceOrientationUnknown){
		currentOrientation = self.interfaceOrientation;
    }
    UIView *_centerView = calendar.view;
    if( UIDeviceOrientationIsLandscape(currentOrientation)){
        CGRect r = [_centerView frame];
        if(![[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] && ! [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
        r.origin.x = xCenter;
        r.origin.y = yCenter;
        r.size.width = widthLand;
                r.size.height = heightLand;
        }else{
            r.size.width = widthLandiPHone;
            r.size.height= heightLandiPHone;
        }
        [_centerView setFrame:r];
        [_centerView setNeedsDisplay];
        [_centerView setNeedsLayout];
    
    }else{
        
        CGRect r = [_centerView frame];
        if(![[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] && ! [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
            r.origin.x = xCenter;
            r.origin.y = yCenter;
            r.size.width = widthPort;
            r.size.height = heightPort;
        }else{
            r.size.width = widthPortiPHone;
            r.size.height= heightPortiPHone;
        }
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
	
    NSDateComponents *dayComponent = [[NSCalendar currentCalendar] components:
                                      (NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit)
                                                                     fromDate:date];
	[dayComponent setSecond:0];

    NSArray* result = [[hDao getHorraireForDate:date] retain];

    for (Horraires * h in result) {
        GCCalendarEvent *event = [[GCCalendarEvent alloc] init];
		event.allDayEvent = NO;
		event.eventName = [h.title capitalizedString];
        event.userInfo = h;
		event.eventDescription = [NSString stringWithFormat:@"%@ %@",h.professeur,h.extension];
		NSCalendar *calendarBegin = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendarBegin components:(kCFCalendarUnitHour | kCFCalendarUnitMinute) fromDate:h.begin];
        
        int weekday = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday];    
        weekday = (weekday-2);
        if (weekday ==-1){
            weekday =6;
        } 

        
        event.color = [[GCCalendar colors] objectAtIndex:weekday];
        NSInteger hour = [components hour];
        NSInteger minute = [components minute];
        [dayComponent setHour:hour];
		[dayComponent setMinute:minute];
        
		event.startDate = [[NSCalendar currentCalendar] dateFromComponents:dayComponent];
		components = [calendarBegin components:(kCFCalendarUnitHour | kCFCalendarUnitMinute) fromDate:h.end];
		[dayComponent setHour:[components hour]];
		[dayComponent setMinute:[components minute]];		
        
		event.endDate = [[NSCalendar currentCalendar] dateFromComponents:dayComponent];
		
		[events addObject:event];
        [event release];
    }
	[result release];
	return events;
}

#pragma mark GCCalendarDelegate
- (void)calendarTileTouchedInView:(GCCalendarView *)view withEvent:(GCCalendarEvent *)event {
    EventOnMapDisplayer * eDisp = [[EventOnMapDisplayer alloc] init];
    eDisp.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    RotableUINavController *navController = [[RotableUINavController alloc] initWithRootViewController:eDisp];
    [eDisp setHorraire:event.userInfo];


    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    if(![[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] && ! [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
        navController.modalPresentationStyle = UIModalPresentationPageSheet;
    }
    [self presentModalViewController:navController animated:YES];
    navController.navigationBar.tintColor = [UIColor colorWithRed:26/255.0 green:99/255.0 blue:140/255.0 alpha:1.0];
    eDisp.title =@"Calendar evnet localisation.";
    UIBarButtonItem *b = [[UIBarButtonItem alloc ]initWithTitle:@"Calendrier" style:UIBarButtonSystemItemPlay target:self action:@selector(back)];
    eDisp.navigationItem.leftBarButtonItem = b;
    [navController.view sizeToFit];
    [eDisp release];


    [navController release];
}
-(void)calendarViewAddButtonPressed:(GCCalendarView *)view{
    
}
-(void) back{
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
