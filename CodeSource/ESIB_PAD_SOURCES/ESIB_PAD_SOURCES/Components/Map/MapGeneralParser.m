//
//  MapGeneralParser.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 23.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "MapGeneralParser.h"


@implementation MapGeneralParser

-(id) init{
    
    self = [super init];
    _crntElementName = [[NSString alloc] init];
    return self;
}
- (void)dealloc
{
    [_crntElementName release];
    [_crntListOfObject release];
    [super dealloc];
}

-(NSArray *)getMapFromXML:(NSData * )xmlData{
    _crntListOfObject = [[NSMutableArray alloc]init];
    NSXMLParser *parseur=[[NSXMLParser alloc] initWithData:xmlData];
    
    [parseur setDelegate: self];
    [parseur parse];
    return [_crntListOfObject autorelease];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"batiement"]){
        NSNumber * latitude = [NSNumber numberWithFloat:[[attributeDict valueForKey:@"latitude"] floatValue]];
        NSNumber * longitude = [NSNumber numberWithFloat:[[attributeDict valueForKey:@"longitude"] floatValue]];
        NSString * name = [attributeDict valueForKey:@"name"];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue;            
        MapLocations *annotation = [[[MapLocations alloc] initWithName:name description:@"SimpleDesc" coordinate:coordinate] autorelease];
        [_crntListOfObject addObject:annotation];
    }
}
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"Error %@ , %@",parseError,parser);
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //NSLog(@"Element : %@ containt : %@",_crntElementName,string);
}
@end
