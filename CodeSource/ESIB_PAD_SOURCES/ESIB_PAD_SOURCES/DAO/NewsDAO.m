//
//  NewsDAO.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 05.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "NewsDAO.h"
#import "Reachability.h"

@implementation NewsDAO

@synthesize delegate;
-(id) init{
    self = [super initWithEntityName:@"Actualite"];
    return self;
}
-(void) returnForDisplay{
    [self.delegate displayNews:self.crntListOfObject]; 
}
-(void) finishLoadingNews{
    int crntCount = [self numberEntityInCacheWithPredicates:nil];
    if(crntCount==0){
        [self getDataFromCacheWithPredicates:nil];
    }
    [self.delegate displayNews:self.crntListOfObject];
    
}

-(void)getNews{
    Reachability * hostReach = [[Reachability reachabilityWithHostName:@"www.usj.edu.lb"] retain];
    
    NetworkStatus netStatus = [hostReach currentReachabilityStatus];
    
     if( netStatus == NotReachable)    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to access the webServices, the data are those in the cache." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
         
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
         [self finishLoadingNews];
        [alert show];
        [alert release];
         [hostReach release];
        return;
    }
    

    [self.set loadValues];
    
    self.postParam = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@", 
                            self.set.login,self.set.pasword,@"listeActualites"]; 
    self.afterLoading = @selector(finishLoadingNews);
    self.predicateForReturnValue=@"";
    [self addToCache:self.postParam];
    [hostReach release];

    return;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

        // NSString * recivedDataText = [NSString stringWithUTF8String:[receivedData bytes]];
    
        //NSLog(@"DATA: %@",recivedDataText);
    NSXMLParser *parseur=[[NSXMLParser alloc] initWithData:self.receivedData];
    [parseur setDelegate: self];
    if([parseur parse] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Please connect to internet to solve this problem or chek your webservice url settings. The displaed data are those in cache." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
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
        if([elementName isEqualToString:@"id"]){
            [self.crntObject setValue:[NSNumber numberWithInt:[self.crntCharacters intValue]] forKey:@"idDB"];
            return;
        }
        if([elementName isEqualToString:@"titre"]){
             [self.crntObject setValue:self.crntCharacters forKey:@"titre"];
            return;
            
        }
        
        if([elementName isEqualToString:@"ss_titre"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"ss_titre"];
            return;
            
        }
        if([elementName isEqualToString:@"date_event"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"date_event"];
            return;
        }
        if([elementName isEqualToString:@"horaire"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"horaire"];
            return;
            
        }
        if([elementName isEqualToString:@"type_event"] ){
            [self.crntObject setValue:self.crntCharacters forKey:@"type_event"];
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
