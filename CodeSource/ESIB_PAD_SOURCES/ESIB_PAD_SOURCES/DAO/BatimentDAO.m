//
//  BatimentDAO.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 01.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "BatimentDAO.h"


@implementation BatimentDAO
@synthesize delegate;
-(id) init{
    self = [super initWithEntityName:@"Batiment"];
    return self;
}
-(void) finishLoadingBatimentWithLocalisationForDomaine{
    if(self.crntListOfObject && self.delegate)
    [self.delegate  consumeListOfBatiments:self.crntListOfObject];
}

- (void)getBatimentWithLocalisationForDomaine:(NSString *) domaineName{
    NSPredicate * onlyDomaine =  [NSPredicate predicateWithFormat:@"(campus = %@)", domaineName];  
    int crntCount = [self numberEntityInCacheWithPredicates:onlyDomaine];
    self.predicateForReturnValue = @"(campus = %@ AND latitude != %@)";  
    [self setArrgumentPredicate:[NSArray arrayWithObjects:domaineName,@"0", nil]];
    self.postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@&param0=%@", 
                 self.set.login,self.set.pasword,@"listeBatiments",domaineName]; 

    if(crntCount==0 || ![self areDataUpToDate:[self.set getLastUpdateTimeForKey:self.postParam]]){
        [self.set loadValues];
        [self deleteFromCacheWithPredicates: onlyDomaine];
        self.afterLoading = @selector(finishLoadingBatimentWithLocalisationForDomaine);
        [self addToCache:self.postParam];
        return;
    }else{
        [self getDataFromCacheWithPredicates:[NSPredicate predicateWithFormat:self.predicateForReturnValue argumentArray:self.arrgumentPredicate]  ];
        [self finishLoadingBatimentWithLocalisationForDomaine];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSXMLParser *parseur=[[NSXMLParser alloc] initWithData:self.receivedData];
    [self.set setLastUpdateTimeForKey:self.postParam lastUpdate:[NSDate date]];
    [parseur setDelegate: self];
    if([parseur parse] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Please connect to internet to solve this problem or chek your webservice url settings." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    }
    
    [parseur release];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; 
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityDescription inManagedObjectContext:self. managedObjectContext];
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
        //if([_crntListOfObject count]!= 0)
    [self performSelector:self.afterLoading];
    
    
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if(self.crntCharacters){
        if( [self verifyError:self.crntCharacters]){
            [parser setDelegate:nil];
            return;
        }
        
        if([elementName isEqualToString:@"latitude"]){
            [self.crntObject setValue:[NSNumber numberWithFloat:[self.crntCharacters floatValue]] forKey:@"longitude"];
        }
        if([elementName isEqualToString:@"longitude"]){
            [self.crntObject setValue:[NSNumber numberWithFloat:[self.crntCharacters floatValue]] forKey:@"latitude"];
        }
        if([elementName isEqualToString:@"campus"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"campus"] ;
        }
        if([elementName isEqualToString:@"batiment"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"nom"] ;
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
