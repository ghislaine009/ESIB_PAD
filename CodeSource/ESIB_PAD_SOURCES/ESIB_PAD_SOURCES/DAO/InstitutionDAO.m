//
//  InstitutionDAO.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 19.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "InstitutionDAO.h"


@implementation InstitutionDAO

@synthesize delegate;

-(id) init{
    self = [super initWithEntityName:@"Institution"];
    return self;
}
-(void) finishLoadingInstitution{
    [self.delegate consumeListOfInstitution:self.crntListOfObject];
    
}
-(void)getInstitutionForDomaine:(NSString *) domaineCode{
    NSPredicate * onlyDomaine =  [NSPredicate predicateWithFormat:@"(campus = %@)", domaineCode]; 
    self.crntListOfObject = nil;
    self.predicateForReturnValue = @"(campus = %@)";  
    self.arrgumentPredicate = [NSArray arrayWithObjects:domaineCode, nil];
    
    int crntCount = [self numberEntityInCacheWithPredicates:onlyDomaine];
    self.postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@&param0=%@", 
                 self.set.login,self.set.pasword,@"listeInst",domaineCode]; 
    if(crntCount==0 ||![self areDataUpToDate:[self.set getLastUpdateTimeForKey:self.postParam]]){
        [self.set loadValues];
        [self deleteFromCacheWithPredicates: onlyDomaine];
        self.afterLoading = @selector(finishLoadingInstitution);
        [self addToCache:self.postParam];
        return;
    }else{
        [self getDataFromCacheWithPredicates:onlyDomaine];
        [self finishLoadingInstitution];
    }

}
-(void)getInstitution{
    self.crntListOfObject = nil;
    int crntCount = [self numberEntityInCacheWithPredicates:nil];
    self.postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@", 
                            self.set.login,self.set.pasword,@"listeInst"]; 


    if(crntCount==0 || ![self areDataUpToDate:[self.set getLastUpdateTimeForKey:self.postParam]]){
        [self.set loadValues];
        [self deleteFromCacheWithPredicates: nil];
        self.afterLoading = @selector(finishLoadingInstitution);
        [self addToCache:self.postParam];
        return;
    }else{
        [self getDataFromCacheWithPredicates:nil];
        [self finishLoadingInstitution];
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
       
        
        if([self.crntElementName isEqualToString:@"campus"] ){
            [self.crntObject setValue:string forKey:@"campus"];
        }
        if([self.crntElementName isEqualToString:@"code"]){
            [self.crntObject setValue:string forKey:@"code"];
        }
        if([self.crntElementName isEqualToString:@"responsable"]){
            [self.crntObject setValue:string forKey:@"responsable"];
            
        }
        if([self.crntElementName isEqualToString:@"institution"]){
            [self.crntObject setValue:string forKey:@"institution"];
            
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
        if([self.crntElementName isEqualToString:@"titre"]){
            [self.crntObject setValue:string forKey:@"titre"];
            
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

