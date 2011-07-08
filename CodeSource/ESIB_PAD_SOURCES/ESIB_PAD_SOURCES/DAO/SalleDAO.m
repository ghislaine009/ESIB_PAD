    //
//  SalleDAO.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "SalleDAO.h"


@implementation SalleDAO

-(id) init{
    self = [super initWithEntityName:@"Salle"];
    return self;
}
-(void) finishLoadingSallesWithLocalisationForDomaine{
    [self.delegate displaySallesList:self.crntListOfObject];

}

- (void)getSallesWithLocalisationForDomaine:(NSString *) domaineName{
    NSPredicate * onlyDomaine =  [NSPredicate predicateWithFormat:@"(campus_id = %@)", domaineName]; 
    NSPredicate * withLocalisation =  [NSPredicate predicateWithFormat:@"(campus_id = %@ AND latitude != %d)",domaineName, 0];  
    int crntCount = [self numberEntityInCacheWithPredicates:[[[NSArray alloc] initWithObjects:onlyDomaine, nil] autorelease]];

    NSArray * p = [[[NSArray alloc] initWithObjects:withLocalisation, nil] autorelease];
    if(crntCount==0 || ![self areDataUpToDate:set.lastUpSalle]){
        [set loadValues];
        [self deleteFromCacheWithPredicates: [[[NSArray alloc] initWithObjects:onlyDomaine, nil] autorelease]];
        NSString * postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@&param0=%@", 
                        set.login,set.pasword,@"listeSalles",domaineName]; 
        self.predicateForReturnValue = p;
        afterLoading = @selector(finishLoadingSallesWithLocalisationForDomaine);
        [self addToCache:postParam];
        return;
    }else{
        [self getDataFromCacheWithPredicates:p];
        [self finishLoadingSallesWithLocalisationForDomaine];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSXMLParser *parseur=[[NSXMLParser alloc] initWithData:receivedData];
    set.lastUpSalle = [NSDate date];
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
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Salle" inManagedObjectContext:self. managedObjectContext];
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
        Salle *p =(Salle *)managedObject;
        [self.crntListOfObject addObject:p ];
    }
    [self performSelector:afterLoading];
 

}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if([string isEqualToString:@""] || [string isEqualToString:@" "] || !string){
        return;
    }
    [self verifyError:string];
    
    if([self.crntElementName isEqualToString:@"latitude"]){
        [self.crntObject setValue:[NSNumber numberWithFloat:[string floatValue]] forKey:@"latitude"];
    }
    if([self.crntElementName isEqualToString:@"longitude"]){
        [self.crntObject setValue:[NSNumber numberWithFloat:[string floatValue]] forKey:@"longitude"];
    }
    if([self.crntElementName isEqualToString:@"campus_id"] ){
        [self.crntObject setValue:string forKey:@"campus_id"] ;
    }
    if([self.crntElementName isEqualToString:@"batiment"]){
        [self.crntObject setValue:string forKey:@"batiment"] ;
    }
    if([self.crntElementName isEqualToString:@"etage"]){
        [self.crntObject setValue:string forKey:@"etage"] ;
    }
    if([self.crntElementName isEqualToString:@"num_salle"]){
        [self.crntObject setValue:string forKey:@"num_salle"] ;
    }
    if([self.crntElementName isEqualToString:@"extension"]){
        [self.crntObject setValue:string forKey:@"extension"] ;
    }
    self.crntElementName =@"";
    
}


@end