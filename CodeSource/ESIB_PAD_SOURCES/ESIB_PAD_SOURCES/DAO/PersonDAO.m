    //
//  PersonnDAO.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 27.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "PersonDAO.h"


@implementation PersonDAO
@synthesize delegate;

-(id) init{
    self = [super initWithEntityName:@"Person"];
    return self;
}
-(void) finishLoadingPersonWithLocalisationForDomaine{
    [self.delegate consumeListOfPerson:self.crntListOfObject];
    
}

-(void)getPersonsForDomaine:(NSString *)domaineName{
    self.crntListOfObject = nil;
    NSPredicate * onlyDomaine =  [NSPredicate predicateWithFormat:@"(campus = %@)", domaineName]; 
    self.predicateForReturnValue = @"(campus = %@)";  
    self.arrgumentPredicate = [NSArray arrayWithObjects:domaineName, nil] ;
    InstitutionDAO * institutionAcces = [[InstitutionDAO alloc] init];
    int crntCount = [self numberEntityInCacheWithPredicates:onlyDomaine];
    if([institutionAcces numberEntityInCacheWithPredicates:onlyDomaine]!=0){
        [institutionAcces getDataFromCacheWithPredicates:onlyDomaine];
        for (Institution * i in institutionAcces.crntListOfObject) {
            NSPredicate * thisInst = [NSPredicate predicateWithFormat:@"(Institution = %@)", i.code];
            self.postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@&param0=%@", 
                              self.set.login,self.set.pasword,@"listeEmpInst",i.code]; 
            if([self numberEntityInCacheWithPredicates:thisInst] ==0 && ![self areDataUpToDate:[self.set getLastUpdateTimeForKey:self.postParam]]){
                [self.set setLastUpdateTimeForKey:self.postParam lastUpdate:[NSDate date]];
                crntCount = 0;// Replace this strategie with a loading of data for the spécific institution 
                break;
            }
        }
    }
    self.postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@&param0=%@", 
                            self.set.login,self.set.pasword,@"listeEmpCampus",domaineName]; 
    if(crntCount==0 || ![self areDataUpToDate:[self.set getLastUpdateTimeForKey:self.postParam]]){
        [self.set loadValues];
        [self deleteFromCacheWithPredicates: onlyDomaine];
        self.afterLoading = @selector(finishLoadingPersonWithLocalisationForDomaine);
        [self addToCache:self.postParam];
    }else{
        [self getDataFromCacheWithPredicates:onlyDomaine];
        [self finishLoadingPersonWithLocalisationForDomaine];
    }
    [institutionAcces release];

}
- (void)getPersonsWithLocalisationForDomaine:(NSString*)domaineName{
    self.crntListOfObject = nil;

    NSPredicate * onlyDomaine =  [NSPredicate predicateWithFormat:@"(campus = %@)", domaineName]; 
    NSPredicate * withLocalisation =  [NSPredicate predicateWithFormat:@"(campus = %@ AND latitude != %d)",domaineName,0];  
    self.predicateForReturnValue = @"(campus = %@ AND latitude != %@)";  
    self.arrgumentPredicate = [NSArray arrayWithObjects:domaineName,@"0", nil]  ;
  
    int crntCount = [self numberEntityInCacheWithPredicates:onlyDomaine];
    self.postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@&param0=%@", 
                            self.set.login,self.set.pasword,@"listeEmpCampus",domaineName]; 
    if(crntCount==0 || ![self areDataUpToDate:[self.set getLastUpdateTimeForKey:self.postParam]]){
        [self.set loadValues];
        [self deleteFromCacheWithPredicates: onlyDomaine];

        self.afterLoading = @selector(finishLoadingPersonWithLocalisationForDomaine);
        [self addToCache:self.postParam];
        return;
    }else{
        [self getDataFromCacheWithPredicates:withLocalisation];
        [self finishLoadingPersonWithLocalisationForDomaine];
    }
}


- (void)getPersonsForInstitution:(NSString *)instCode{
    self.crntListOfObject = nil;
    
    NSPredicate * onlyInst =  [NSPredicate predicateWithFormat:@"(Institution = %@)", instCode]; 
  
    self.predicateForReturnValue = @"Institution = %@ ";  
    self.arrgumentPredicate = [NSArray arrayWithObjects:instCode, nil] ;
    
    int crntCount = [self numberEntityInCacheWithPredicates:onlyInst];
    self.postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@&param0=%@", 
                            self.set.login,self.set.pasword,@"listeEmpInst",instCode]; 
    if(crntCount==0 || ![self areDataUpToDate:[self.set getLastUpdateTimeForKey:self.postParam]]){
        [self.set loadValues];
        [self deleteFromCacheWithPredicates: onlyInst];
      
        self.afterLoading = @selector(finishLoadingPersonWithLocalisationForDomaine);
        [self addToCache:self.postParam];
        return;
    }else{
        [self getDataFromCacheWithPredicates:onlyInst];
        [self finishLoadingPersonWithLocalisationForDomaine];
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
    if(self.predicateForReturnValue)
    [request setPredicate:[NSPredicate predicateWithFormat:self.predicateForReturnValue argumentArray:self.arrgumentPredicate]];
    
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
        NSString * string = self.crntCharacters;
        if([self.crntCharacters isEqualToString:@""] || [string isEqualToString:@" "] || !string){
            return;
        }
        [self verifyError:string];
        
        if([self.crntElementName isEqualToString:@"latitude"]){
            [self.crntObject setValue:[NSNumber numberWithFloat:[string floatValue]] forKey:@"latitude"];
        }
        if([self.crntElementName isEqualToString:@"longitude"]){
            [self.crntObject setValue:[NSNumber numberWithFloat:[string floatValue]] forKey:@"longitude"];
        }
        
        
        if([self.crntElementName isEqualToString:@"campus"] ){
            [self.crntObject setValue:string forKey:@"campus"];
        }
        if([self.crntElementName isEqualToString:@"code"]){
            [self.crntObject setValue:string forKey:@"Institution"];
        }
        if([self.crntElementName isEqualToString:@"titre"]){
            [self.crntObject setValue:string forKey:@"titre"];
            
        }
        if([self.crntElementName isEqualToString:@"nom"]){
            [self.crntObject setValue:string forKey:@"nom"];
            
        }
        if([self.crntElementName isEqualToString:@"prenom"]){
            
            [self.crntObject setValue:string forKey:@"prenom"];
        }
        if([self.crntElementName isEqualToString:@"extension"]){
            [self.crntObject setValue:string forKey:@"extension"];
            
        }
        if([self.crntElementName isEqualToString:@"email"]){
            [self.crntObject setValue:string forKey:@"email"];
            
        }
        if([self.crntElementName isEqualToString:@"carriere"]){
            [self.crntObject setValue:string forKey:@"carriere"];
            
        }
        
        self.crntElementName =@"";        
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

