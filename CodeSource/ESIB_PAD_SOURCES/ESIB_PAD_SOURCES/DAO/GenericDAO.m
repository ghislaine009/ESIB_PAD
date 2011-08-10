//
//  GenericDAO.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 30.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "GenericDAO.h"
#import "Reachability.h"

@implementation GenericDAO
@synthesize crntElementName=_crntElementName,entityDescription=_entityDescription, managedObjectContext=_managedObjectContext,crntObject =_crntSalle ,set,receivedData,predicateForReturnValue,crntListOfObject=_crntListOfObject,crntCharacters,arrgumentPredicate,postParam,afterLoading;

-(id) initWithEntityName:(NSString *)EntitiyDescription{
    
    self = [super init];
    self.entityDescription = EntitiyDescription;
    self.managedObjectContext =  [(ESIB_PAD_SOURCESAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    SettingsDAO * s = [[SettingsDAO alloc]init];
    
    self.set =s;
    [s release];
    return self;
}
- (void)dealloc
{
    [_crntElementName release];
    [arrgumentPredicate release];
    
    [_entityDescription release];
    [_managedObjectContext release];
    [_crntSalle release];
    [receivedData release];
    [_crntListOfObject release];
    [crntCharacters release];
    [postParam release];
    [set release];
    [super dealloc];
}
-(void)returnResponse{
    
}
-(NSArray*)getDataFromCacheWithPredicates:(NSPredicate *) predicate{
    NSFetchRequest * crntRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityDescription inManagedObjectContext:self.managedObjectContext];
    if(predicate)
    [crntRequest setPredicate:predicate];

    [crntRequest setEntity:entity];

    NSError *error;
    NSArray *items = [self.managedObjectContext executeFetchRequest:crntRequest error:&error]; 
    if(_crntListOfObject){
        [_crntListOfObject release];
    }
    _crntListOfObject = [[NSMutableArray alloc] init];
    for (NSManagedObject *managedObject in items) {
        NSManagedObject *o =(NSManagedObject *)managedObject;
        [_crntListOfObject addObject:o];
    }
    [crntRequest release];
    return _crntListOfObject;
}
-(int)numberEntityInCacheWithPredicates:(NSPredicate *) predicate{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity: [NSEntityDescription entityForName:self.entityDescription inManagedObjectContext: self.managedObjectContext]];
    NSError *error=nil;
    if(predicate)
    [request setPredicate:predicate];
    

    NSUInteger count = [[self.managedObjectContext executeFetchRequest:request error:&error] count]; 
    [request autorelease];
    if (!error){
        return count;
    }
    else
        return 0;
    
}
- (BOOL) doesAlertViewExist {
    for (UIWindow* window in [UIApplication sharedApplication].windows) {
        for (UIView* view in window.subviews) {
            BOOL alert = [view isKindOfClass:[UIAlertView class]];
            BOOL action = [view isKindOfClass:[UIActionSheet class]];
            if (alert || action)
                return YES;
        }
    }
    return NO;
}
-(bool) areDataUpToDate:(NSDate *)lastUpdateTime{
    if(!lastUpdateTime)return NO;
    NSDate *now =  [NSDate date];
    NSTimeInterval ti = ([set.refreshCacheEvery intValue]*60*60*24);
    NSDate *upTime = [lastUpdateTime dateByAddingTimeInterval:ti] ;
    return ([now compare:upTime]==NSOrderedAscending);  
}

-(void)addToCache:(NSString *) webServicePostHeader{
    NSURL * r = [[NSURL alloc] initWithString:self.set.url];
    Reachability * hostReach = [[Reachability reachabilityWithHostName:[r host]] retain];
    [r release];
    
    NetworkStatus netStatus = [hostReach currentReachabilityStatus];
    
    if( netStatus == NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to access the webServices, please check your connection settings" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
        alert = nil;
        [hostReach release];
        return;
    }

     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:set.url] 
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:120.0]; 
    [request setHTTPMethod:@"POST"]; 
    /*NSString * s = [NSString stringWithFormat:@"usr=%@&pwd=%@&op=%@&param0=CST", 
                    set.login,set.pasword,@"listeSalles"];*/ 
    [request setHTTPBody:[webServicePostHeader dataUsingEncoding:NSASCIIStringEncoding]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; 
    NSURLConnection *connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease]; 
    if (connection) { 
        receivedData = [[NSMutableData data] retain];
    } 
    [hostReach release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    self.crntCharacters =nil;
    if([elementName isEqualToString:@"row"]){
        if(!self.crntObject){
            _crntObject = [NSManagedObject alloc];
        }
        self.crntObject = [NSEntityDescription
                          insertNewObjectForEntityForName:self.entityDescription 
                          inManagedObjectContext:self.managedObjectContext];
    }
    self.crntElementName =elementName;
}
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSString * errorMsg = [[[NSString alloc] initWithFormat:@"%@ \n Please connect to internet to solve this problem or chek your webservice url settings.",error.accessibilityHint] autorelease];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    [alert release];
    alert = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    /*NSString* returnString= [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];*/
    // YOU have to manage this function comportment
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"row"]){
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    
}

- (void) deleteFromCacheWithPredicates:(NSPredicate *) predicate  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityDescription inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    if(predicate)
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *items = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    
    for (NSManagedObject *managedObject in items) {
        [_managedObjectContext deleteObject:managedObject];
    }
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error deleting %@ - error:%@",self.entityDescription,error);
    }
    
}

- (bool) verifyError:(NSString *) texte{
    
    if([self.crntElementName isEqualToString:@"TITLE"]){
        NSString * errorMsg = [[[NSString alloc] initWithFormat:@"%@ \n Please connect to internet to solve this problem."] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
       //[self setDelegate:nil];
        [alert show];
        [alert release];
        alert = nil;

        return YES;
        
    }
    if([_crntElementName isEqualToString:@"message"]){
        NSString * errorMsg = [[NSString alloc] initWithFormat:@"%@ \n Please change the settings and/or check your connectio to solve this problem .",texte] ;
        UIAlertView *alertNoData = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        //[self setDelegate:nil];
        
        [alertNoData show];
        [alertNoData release];
        [errorMsg release];
        return YES;
    }
    return NO;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if([string isEqualToString:@""] || [string isEqualToString:@" "] || !string || [string isEqualToString:@"\t"] || [string isEqualToString:@"\n"]){
        return;
    }
    if(!self.crntCharacters)
        self.crntCharacters = string;
    else{
        NSString *newString = [[NSString alloc] initWithFormat:@"%@%@", crntCharacters,string];
        self.crntCharacters = newString;
        [newString release];
    }
}

@end

