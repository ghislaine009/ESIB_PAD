//
//  EventOnMapDisplayer.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 04.08.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "EventOnMapDisplayer.h"


@implementation EventOnMapDisplayer
@synthesize horraire;

-(void)setHorraire:(Horraires *)newHorraire{
    horraire = [newHorraire retain];
    MKMapView * map = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview: map];
    map.showsUserLocation=YES;  
    SettingsDAO * s = [[SettingsDAO alloc] init];
    
    if([s.mapType isEqualToString:@"sat"]){
        [map setMapType:MKMapTypeSatellite];
    }else{
        [map setMapType:MKMapTypeStandard];
    }
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [newHorraire.latitude doubleValue];
    
    coordinate.longitude = [newHorraire.longitude doubleValue];
    
    MapLocations *annotation = [[[MapLocations alloc] initWithName:newHorraire.title description:newHorraire.professeur coordinate:coordinate] autorelease];
    [map addAnnotation:annotation];
    [s release];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 0.5*METERS_PER_MILE_DET, 0.5*METERS_PER_MILE_DET);
        // 3
    MKCoordinateRegion adjustedRegion = [map regionThatFits:viewRegion];                
        // 4
    [map setRegion:adjustedRegion animated:YES]; 
    [map release];

}
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
