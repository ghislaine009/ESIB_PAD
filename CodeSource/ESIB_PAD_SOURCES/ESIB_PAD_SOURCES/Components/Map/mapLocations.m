//
//  mapLocations.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 24.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "MapLocations.h"


@implementation MapLocations
@synthesize name = _name;
@synthesize description = _description;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString*)name description:(NSString*)description coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name = [name copy];
        _description = [description copy];
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _description;
}

- (void)dealloc
{
    [_name release];
    _name = nil;
    [_description release];
    _description = nil;    
    [super dealloc];
}
@end
