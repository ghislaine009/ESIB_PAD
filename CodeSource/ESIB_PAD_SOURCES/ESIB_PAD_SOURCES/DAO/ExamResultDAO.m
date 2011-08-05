//
//  ExamResultDAO.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 03.08.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "ExamResultDAO.h"
#import "Reachability.h"

@implementation ExamResultDAO

@synthesize delegate;
-(id) init{
    self = [super initWithEntityName:@"ExamResult"];
    return self;
}
-(void) returnForDisplay{
    [self.delegate displayExamResult:self.crntListOfObject]; 
}
-(void) finishLoadingNews{
    int crntCount = [self numberEntityInCacheWithPredicates:nil];
    if(crntCount==0){
        [self getDataFromCacheWithPredicates:nil];
    }
    [self.delegate displayExamResult:self.crntListOfObject];
    
}

-(void)getExamResult{
    Reachability * hostReach = [[Reachability reachabilityWithHostName:@"www.usj.edu.lb"] retain];
    
    NetworkStatus netStatus = [hostReach currentReachabilityStatus];
    [hostReach release];
    if( netStatus == NotReachable)    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to access the webServices, the data are those in the cache." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityDescription inManagedObjectContext:self. managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        
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
        return;
    }
    
    
    [self.set loadValues];
    
    self.postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@", 
                      self.set.login,self.set.pasword,@"listeNotes"]; 
    self.afterLoading = @selector(finishLoadingNews);
    self.predicateForReturnValue=@"";
    [self addToCache:self.postParam];
    return;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
        // NSString * recivedDataText = [NSString stringWithUTF8String:[receivedData bytes]];
    
        //NSLog(@"DATA: %@",recivedDataText);
    NSXMLParser *parseur=[[NSXMLParser alloc] initWithData:self.receivedData];
    [parseur setDelegate: self];
    if([parseur parse] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Please connect to internet to solve this problem or chek your webservice url settings." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    }else{
        [self deleteFromCacheWithPredicates:nil];
        [parseur parse] ;
    }
    
    [parseur release];
    
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
        if([elementName isEqualToString:@"reussi"]){
            [self.crntObject setValue:[NSNumber numberWithInt:[self.crntCharacters intValue]] forKey:@"reussi"];
            return;
        }
        if([elementName isEqualToString:@"title"]){
            [self.crntObject setValue:self.crntCharacters forKey:@"title"];
            return;
            
        }
        
        if([elementName isEqualToString:@"anne"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"anne"];
            return;
            
        }
        if([elementName isEqualToString:@"note"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"note"];
            return;
        }
        if([elementName isEqualToString:@"moyeneClasse"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"moyeneClassee"];
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
