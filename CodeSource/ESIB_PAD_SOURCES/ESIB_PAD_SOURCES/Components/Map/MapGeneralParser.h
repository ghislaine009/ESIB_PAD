//
//  MapGeneralParser.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 23.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MapLocations.h"

@interface MapGeneralParser : NSObject<NSXMLParserDelegate> {
    NSString * _crntElementName;
    NSMutableArray * _crntListOfObject;
}
-(NSArray *)getMapFromXML:(NSData * )xmlData;
@end
