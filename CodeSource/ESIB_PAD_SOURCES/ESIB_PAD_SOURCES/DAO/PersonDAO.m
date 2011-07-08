//
//  PersonnDAO.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 27.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "PersonDAO.h"


@implementation PersonDAO

-(id) init{
    self = [super initWithEntityName:@"Person"];
    return self;
}
-(void) finishLoadingPersonWithLocalisationForDomaine{
    [self.delegate displayPersonList:self.crntListOfObject];
    
}

- (void)getPersonsWithLocalisationForDomaine:(NSString*)domaineName{
    NSPredicate * onlyDomaine =  [NSPredicate predicateWithFormat:@"(campus = %@)", domaineName]; 
    NSPredicate * withLocalisation =  [NSPredicate predicateWithFormat:@"(campus = %@ AND latitude != %d)",domaineName,0];  
    int crntCount = [self numberEntityInCacheWithPredicates:[[[NSArray alloc] initWithObjects:onlyDomaine, nil] autorelease]];
    
    NSArray * p = [[[NSArray alloc] initWithObjects:withLocalisation, nil] autorelease];
    if(crntCount==0 || ![self areDataUpToDate:set.lastUpPerson]){
        [set loadValues];
        [self deleteFromCacheWithPredicates: [[[NSArray alloc] initWithObjects:onlyDomaine, nil] autorelease]];
        NSString * postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@&param0=%@", 
                                set.login,set.pasword,@"listeEmpCampus",domaineName]; 
        self.predicateForReturnValue = p;
        afterLoading = @selector(finishLoadingPersonWithLocalisationForDomaine);
        [self addToCache:postParam];
        return;
    }else{
        [self getDataFromCacheWithPredicates:p];
        [self finishLoadingPersonWithLocalisationForDomaine];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSXMLParser *parseur=[[NSXMLParser alloc] initWithData:receivedData];
    set.lastUpPerson = [NSDate date];
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
   

    if([_crntElementName isEqualToString:@"campus"] ){
        [self.crntObject setValue:string forKey:@"campus"];
    }
    if([_crntElementName isEqualToString:@"code"]){
        [self.crntObject setValue:string forKey:@"Institution"];
    }
    if([_crntElementName isEqualToString:@"titre"]){
        [self.crntObject setValue:string forKey:@"titre"];

    }
    if([_crntElementName isEqualToString:@"nom"]){
        [self.crntObject setValue:string forKey:@"nom"];

    }
    if([_crntElementName isEqualToString:@"prenom"]){
        
        [self.crntObject setValue:string forKey:@"prenom"];
    }
    if([_crntElementName isEqualToString:@"extension"]){
        [self.crntObject setValue:string forKey:@"extension"];

    }
    if([_crntElementName isEqualToString:@"email"]){
        [self.crntObject setValue:string forKey:@"email"];

    }
    if([_crntElementName isEqualToString:@"carriere"]){
        [self.crntObject setValue:string forKey:@"carriere"];

    }

    _crntElementName =@"";

}

@end

