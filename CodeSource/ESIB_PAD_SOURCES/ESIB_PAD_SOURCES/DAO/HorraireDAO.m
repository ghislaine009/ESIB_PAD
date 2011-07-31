//
//  HorraireDAO.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "HorraireDAO.h"
#import "Reachability.h"


@implementation HorraireDAO

@synthesize delegate;
-(id) init{
    self = [super initWithEntityName:@"Horraires"];
    return self;
}
-(void) returnForDisplay{
    [self.delegate dataLoadedFromInternet]; 
}
-(void)loadHorraireForDate{
    self.crntListOfObject = nil;
    int crntCount = [self numberEntityInCacheWithPredicates:nil];
    self.postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@", 
                      self.set.login,self.set.pasword,@"listeHorraires"]; 
    if(crntCount==0 ||![self areDataUpToDate:[self.set getLastUpdateTimeForKey:self.postParam]]){
        [self.set loadValues];
        [self deleteFromCacheWithPredicates: nil];
        self.afterLoading = @selector(returnForDisplay);
        [self addToCache:self.postParam];
        return;
    }else{
        [self returnForDisplay];
    }
}
-(NSArray *)getHorraireForDate:(NSDate *)date{
    /*NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityDescription inManagedObjectContext:self. managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"" argumentArray:self.arrgumentPredicate]];
    
    NSError *error;
    NSArray *items = [self.managedObjectContext executeFetchRequest:request error:&error];
    [request release];
    if(!self.crntListOfObject)
        self.crntListOfObject = [[NSMutableArray  alloc]init];
    for (NSManagedObject *managedObject in items) {
        [self.crntListOfObject addObject:managedObject ];
    }
    [self finishLoadingNews];
    [alert show];
    [alert release];
    return;*/
    return nil;

}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self deleteFromCacheWithPredicates:nil];
    
        // NSString * recivedDataText = [NSString stringWithUTF8String:[receivedData bytes]];
    
        //NSLog(@"DATA: %@",recivedDataText);
    NSXMLParser *parseur=[[NSXMLParser alloc] initWithData:self.receivedData];
    [parseur setDelegate: self];
    if([parseur parse] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Please connect to internet to solve this problem or chek your webservice url settings." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    }
    
    [parseur release];
    [self.receivedData release];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; 
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityDescription inManagedObjectContext:self. managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
        // [request setPredicate:[NSPredicate predicateWithFormat:self.predicateForReturnValue argumentArray:self.arrgumentPredicate]];
    
    NSError *error;
    NSArray *items = [self.managedObjectContext executeFetchRequest:request error:&error];
    [request release];
    if(!self.crntListOfObject)
        self.crntListOfObject = [[NSMutableArray  alloc]init];
    for (NSManagedObject *managedObject in items) {
        [self.crntListOfObject addObject:managedObject ];
    }
    [self performSelector:self.afterLoading];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if(self.crntCharacters){
        [self verifyError:self.crntCharacters];
        if([elementName isEqualToString:@"title"]){
            [self.crntObject setValue:self.crntCharacters forKey:@"title"];
            return;
        }
        if([elementName isEqualToString:@"fromDate"]){
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"MM-dd-yyyy"];
            NSDate *myDate = [df dateFromString: self.crntCharacters]; 
            [self.crntObject setValue:myDate forKey:@"fromDate"];
            [df release];
            [myDate release];
            return;
            
        }
        if([elementName isEqualToString:@"toDate"]){
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"MM-dd-yyyy"];
            NSDate *myDate = [df dateFromString: self.crntCharacters]; 
            [self.crntObject setValue:myDate forKey:@"toDate"];
            [df release];
            [myDate release];
            return;
            
        }
        
        if([elementName isEqualToString:@"dayOfTheWeek"] ){
            [self.crntObject setValue:[NSNumber numberWithInt:[self.crntCharacters intValue]] forKey:@"dayOfTheWeek"];
            return;
            
        }
        if([elementName isEqualToString:@"begin"] ){
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"hh:mm"];
            NSDate *myDate = [df dateFromString: self.crntCharacters]; 
            [self.crntObject setValue:myDate forKey:@"toDate"];
            [df release];
            [myDate release];
            [self.crntObject setValue:self.crntCharacters forKey:@"begin"];
            return;
        }
        if([elementName isEqualToString:@"end"] ){
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"hh:mm"];
            NSDate *myDate = [df dateFromString: self.crntCharacters]; 
            [self.crntObject setValue:myDate forKey:@"end"];
            [df release];
            [myDate release];
            [self.crntObject setValue:self.crntCharacters forKey:@"begin"];
            return;
        }
        if([elementName isEqualToString:@"pofesseur"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"pofesseur"];
            return;
            
        }
        if([elementName isEqualToString:@"extension"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"extension"];
            return;
            
        }
        if([elementName isEqualToString:@"extension"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"extension"];
            return;
            
        }
        if([elementName isEqualToString:@"lieu"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"lieu"];
            return;
            
        }
        if([elementName isEqualToString:@"latitude"]){
            [self.crntObject setValue:[NSNumber numberWithFloat:[self.crntCharacters floatValue]] forKey:@"longitude"];
        }
        if([elementName isEqualToString:@"longitude"]){
            [self.crntObject setValue:[NSNumber numberWithFloat:[self.crntCharacters floatValue]] forKey:@"latitude"];
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