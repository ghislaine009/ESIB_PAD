//
//  CampusDAO.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "CampusDAO.h"


@implementation CampusDAO

-(id) init{
    self = [super initWithEntityName:@"Campus"];
    return self;
}
-(void) returnForDisplay{
    [self.delegate displayAllCampusOnMap:self.crntListOfObject]; 
}
-(void) finishLoadingCampusList{
    [self.delegate displayListOfCampus:self.crntListOfObject];
    
}

- (void)getCampusListAndDisplay{
    NSPredicate * withLocalisation =  [NSPredicate predicateWithFormat:@"(latitude != %d)", 0];  
    
    NSArray * p = [[[NSArray alloc] initWithObjects:withLocalisation, nil] autorelease];
     int crntCount = [self numberEntityInCacheWithPredicates:p];
        if(crntCount==0 || ![self areDataUpToDate:set.lastUpCampus]){
        [set loadValues];
        [self deleteFromCacheWithPredicates:p];
        NSString * postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@", 
                                set.login,set.pasword,@"listeCampus"]; 
        self.predicateForReturnValue = p;
        afterLoading = @selector(finishLoadingCampusList);
        [self addToCache:postParam];
        return;
    }else{
        [self getDataFromCacheWithPredicates:nil];
        [self finishLoadingCampusList];
    }
}

- (void)getCampusAndDisplayOnMap{
    NSPredicate * withLocalisation =  [NSPredicate predicateWithFormat:@"(latitude != %d)", 0];  

    NSArray * p = [[[NSArray alloc] initWithObjects:withLocalisation, nil] autorelease];
    [set loadValues];

    int crntCount = [self numberEntityInCacheWithPredicates:p];
    if(crntCount==0 || ![self areDataUpToDate:set.lastUpCampus]){
        [set loadValues];
        [self deleteFromCacheWithPredicates:nil];
        NSString * postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@", 
                                set.login,set.pasword,@"listeCampus"]; 
        self.predicateForReturnValue = p;
        afterLoading = @selector(returnForDisplay);
        [self addToCache:postParam];
        return;
    }else{
        [self getDataFromCacheWithPredicates:p];
        [self returnForDisplay];
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString * recivedDataText = [NSString stringWithUTF8String:[receivedData bytes]];
    NSLog(@"DATA: %@",recivedDataText);
    NSXMLParser *parseur=[[NSXMLParser alloc] initWithData:receivedData];
    set.lastUpCampus = [NSDate date];
    [set save];
    [parseur setDelegate: self];
    if([parseur parse] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Please connect to internet to solve this problem or chek your webservice url settings." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    }
    
    [parseur release];
    [receivedData release];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; 
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityDescription inManagedObjectContext:self. managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    for (NSPredicate * p in self.predicateForReturnValue) {
        [request setPredicate:p];
    }
    NSError *error;
    NSArray *items = [self.managedObjectContext executeFetchRequest:request error:&error];
    [request release];
    if(!self.crntListOfObject)
        self.crntListOfObject = [[NSMutableArray  alloc]init];
    for (NSManagedObject *managedObject in items) {
        [self.crntListOfObject addObject:managedObject ];
    }
    [self performSelector:afterLoading];
    
    
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if(self.crntCharacters){
        [self verifyError:self.crntCharacters];
        if([elementName isEqualToString:@"latitude"]){
            [self.crntObject setValue:[NSNumber numberWithFloat:[self.crntCharacters floatValue]] forKey:@"latitude"];
            return;
        }
        if([elementName isEqualToString:@"longitude"]){
            [self.crntObject setValue:[NSNumber numberWithFloat:[self.crntCharacters floatValue]] forKey:@"longitude"];
            return;

        }
        
        if([elementName isEqualToString:@"code"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"code"];
            return;

        }
        if([elementName isEqualToString:@"campus"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"campus"];
            return;
        }
        if([elementName isEqualToString:@"adresse"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"adresse"];
            return;

        }
        if([elementName isEqualToString:@"responsable"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"resp_def"];
            return;

        }
        if([elementName isEqualToString:@"titre"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"titre_resp"];
            return;

        }
        if([elementName isEqualToString:@"nom"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"nom_resp"];
            return;

        }
        if([elementName isEqualToString:@"prenom"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"prenom_resp"];
            return;

        }
        if([elementName isEqualToString:@"extension"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"extension"];
            return;

        }
        if([elementName isEqualToString:@"email"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"email"];
            return;

        }
        if([elementName isEqualToString:@"img"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"img"];
            return;

        }
    }
    if([elementName isEqualToString:@"row"]){
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        return;
    }
    
}



@end
