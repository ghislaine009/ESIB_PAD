    //
//  SalleDAO.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 29.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "SalleDAO.h"


@implementation SalleDAO
@synthesize delegate;
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
    self.predicateForReturnValue = @"(campus_id = %@ AND latitude != %@)";  
    self.arrgumentPredicate = [NSArray arrayWithObjects:domaineName,@"0", nil] ;

    int crntCount = [self numberEntityInCacheWithPredicates:onlyDomaine];
    self.postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@&param0=%@", 
                            self.set.login,self.set.pasword,@"listeSalles",domaineName]; 
    if(crntCount==0 ||  ![self areDataUpToDate:[self.set getLastUpdateTimeForKey:self.postParam]]){
        [self.set loadValues];
        [self deleteFromCacheWithPredicates: onlyDomaine];
               self.afterLoading = @selector(finishLoadingSallesWithLocalisationForDomaine);
        [self addToCache:self.postParam];
        return;
    }else{
        [self getDataFromCacheWithPredicates:withLocalisation];
        [self finishLoadingSallesWithLocalisationForDomaine];
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
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Salle" inManagedObjectContext:self. managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:self.predicateForReturnValue argumentArray:self.arrgumentPredicate]];
    
    NSError *error;
    NSArray *items = [self.managedObjectContext executeFetchRequest:request error:&error];
    [request release];
    if(!self.crntListOfObject)
        self.crntListOfObject = [[NSMutableArray  alloc]init];
    for (NSManagedObject *managedObject in items) {
        Salle *p =(Salle *)managedObject;
        [self.crntListOfObject addObject:p ];
    }
    [self performSelector:self.afterLoading];
 

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
