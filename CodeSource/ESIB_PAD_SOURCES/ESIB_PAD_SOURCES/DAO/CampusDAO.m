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
    [set loadValues];
    self.predicateForReturnValue = @"(latitude != %@)";  
    self.arrgumentPredicate = [[[NSArray alloc] initWithObjects:@"0", nil] autorelease];
   int crntCount = [self numberEntityInCacheWithPredicates:[NSPredicate predicateWithFormat:@"(latitude != %d)", 0]];
    if(crntCount==0 || ![self areDataUpToDate:set.lastUpCampus]){
        [set loadValues];
        [self deleteFromCacheWithPredicates:nil];
        NSString * postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@", 
                                set.login,set.pasword,@"listeCampus"]; 
        afterLoading = @selector(finishLoadingCampusList);
        [self addToCache:postParam];
    }else{
        [self getDataFromCacheWithPredicates:[NSPredicate predicateWithFormat:self.predicateForReturnValue argumentArray:self.arrgumentPredicate] ];
        [self finishLoadingCampusList];
    }
 }

- (void)getCampusAndDisplayOnMap{

    [set loadValues];
    self.predicateForReturnValue = @"(latitude != %d)";  
    self.arrgumentPredicate = [[[NSArray alloc] initWithObjects:@"0", nil] autorelease];
    int crntCount = [self numberEntityInCacheWithPredicates:[NSPredicate predicateWithFormat:@"(latitude != %d)", 0]];
    if(crntCount==0 || ![self areDataUpToDate:set.lastUpCampus]){
        [set loadValues];
        [self deleteFromCacheWithPredicates:nil];
        NSString * postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@", 
                                set.login,set.pasword,@"listeCampus"]; 
        afterLoading = @selector(returnForDisplay);
        [self addToCache:postParam];
    }else{        
        [self getDataFromCacheWithPredicates:[NSPredicate predicateWithFormat:self.predicateForReturnValue argumentArray:self.arrgumentPredicate]];
        [self returnForDisplay];
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
        //NSString * recivedDataText = [NSString stringWithUTF8String:[receivedData bytes]];
        // NSLog(@"DATA: %@",recivedDataText);
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
    [self.managedObjectContext updatedObjects];    
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityDescription inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:self.predicateForReturnValue argumentArray:self.arrgumentPredicate]];
    
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
