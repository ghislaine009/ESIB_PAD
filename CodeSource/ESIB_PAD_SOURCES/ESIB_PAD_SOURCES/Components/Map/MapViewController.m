//
//  MapViewController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 23.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "MapViewController.h"
#import "PersonDAO.h"
#import "SalleDAO.h"
#import "CampusDAO.h"
#import "Campus.h"
#import "BatimentDAO.h"
#import "Batiment.h"
#import <MapKit/MapKit.h>


@implementation MapViewController
@synthesize map =_map;
@synthesize delegate =_delegate;
@synthesize searchBar,searchBarCTRL,personViewController=_personViewController,popOverControllerPersonne=_popOverControllerPersonne,persons = _persons,salles =_salles,searchPersonButton,searchSalles,loading,subViews,sallesViewController = _sallesViewController,campusSelector,listCampus,crntCampus,listBatiment,chooseCampusBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [_map release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CampusDAO * cDAO = [[CampusDAO alloc] init];
    [cDAO setDelegate:self];
    [cDAO getCampusAndDisplayOnMap];
    [cDAO release];    
    
    [searchBar setBackgroundColor:[UIColor clearColor]];
     searchBar.barStyle                 = UIBarStyleBlackTranslucent;
     searchBar.showsCancelButton        = NO;
     searchBar.autocorrectionType       = UITextAutocorrectionTypeNo;
     searchBar.autocapitalizationType   = UITextAutocapitalizationTypeNone;
     for (UIView *subview in searchBar.subviews)
     {
         if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground") ] ) 
             subview.alpha = 0.0;  
     
         if ([subview isKindOfClass:NSClassFromString(@"UISegmentedControl") ] ){
             subview.alpha = 0.0;  
             [subview setOpaque:NO];
             [subview setHidden:YES];
         }
     }
    [searchBar setDelegate:self];
    [loading stopAnimating];
    [self.crntCampus.intValue:(int)-1];
} 
- (void)viewDidUnload
{
    [self setMap:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

// ************************ IB ACTION 
- (IBAction)goHome:(id)sender{
    [_delegate unloadModalView];
}
-(IBAction) searchPersonn:(id)sender{
    [loading startAnimating];
    if(!self.crntCampus || [self.crntCampus intValue] ==-1){
        UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"Choose a campus" message:@"Please first select a campus." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [a show];
        [a release];
        [self chooseCampus:nil];
        return;
    }
    if(!_persons){
        PersonDAO * pDao = [[PersonDAO alloc ]init] ;
        pDao.delegate = self;
        Campus * c = [self.listCampus objectAtIndex:[self.crntCampus intValue]];
        [pDao getPersonsWithLocalisationForDomaine:c.code];
        [pDao release];
    }else{
        [self displayPersonList:_persons];
    }
}
-(IBAction) searchSalle:(id)sender{
    [loading startAnimating];
    if(!self.crntCampus || [self.crntCampus intValue] ==-1){
        UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"Choose a campus" message:@"Please first select a campus." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [a show];
        [a release];
        [self chooseCampus:nil];

        return;
    }
    if(!_salles){
        SalleDAO * sDao = [[SalleDAO alloc ]init] ;
        sDao.delegate = self;
        Campus * c = [self.listCampus objectAtIndex:[self.crntCampus intValue]];

        [sDao getSallesWithLocalisationForDomaine:c.code ];
        [sDao release];
    }else{
        [self displaySallesList:_salles];
    }
}


-(IBAction) chooseCampus:(id)sender{
    if(![loading isAnimating])
    [loading startAnimating];
    if(!self.listCampus){
        CampusDAO * cDao = [[CampusDAO alloc ]init];
        cDao.delegate = self;
        [cDao getCampusListAndDisplay];
        [cDao release];
    }else{
        [self displayListOfCampus:self.listCampus];
    }
}
-(void)campusSelected:(NSNumber *)selectedCampusIndex{
    if(self.crntCampus == selectedCampusIndex)
        return;
    if(crntCampus)
        [crntCampus release];
    if(_persons){
        [_persons release];
        _persons =nil;
    }
    if(_salles){
        [_salles release];
        _salles =nil;
    }
   
    self.crntCampus =selectedCampusIndex;
    BatimentDAO * bDao = [[BatimentDAO alloc ]init];
    [bDao setDelegate:self];
    if([selectedCampusIndex intValue]>0 && [selectedCampusIndex intValue]< ([self.listCampus count] -1) ){
        Campus * c = [self.listCampus objectAtIndex:[selectedCampusIndex intValue]];
          
        [bDao getBatimentWithLocalisationForDomaine:c.code];
        [bDao release];
    }
}
-(void)back{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)zoomToFitMapAnnotations:(MKMapView*)mapView
{
    if([mapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(MapLocations *annotation in mapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.5; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.5; // Add a little extra space on the sides
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}


//****** MapDisplayerDelegate *******

-(void)displayPersonOnMap:(Person *)person{
    [_map removeAnnotations:_map.annotations];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [person.latitude doubleValue];
    
    coordinate.longitude = [person.longitude doubleValue];            
    NSString * s  = [[NSString alloc]initWithFormat:@"%@ %@ %@",person.titre,person.nom, person.prenom];
    MapLocations *annotation = [[[MapLocations alloc] initWithName:s description:person.carriere coordinate:coordinate] autorelease];
    [_map addAnnotation:annotation];
    [s release];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, _map.region.span.latitudeDelta, _map.region.span.longitudeDelta);
    MKCoordinateRegion adjustedRegion = [_map regionThatFits:viewRegion];     
    [_map setRegion:adjustedRegion animated:YES];   
    
}

- (void) displayPersonList: (NSArray *)personArray{
    if(_persons){
        [_persons release];
    }
    
    _persons = [personArray retain];
    
    if (_personViewController == nil ||[self.popOverControllerPersonne contentViewController] != _personViewController) {
        self.personViewController = [[PersonTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.personViewController setDelegate:self];
        if(![[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] && ! [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
            
            self.popOverControllerPersonne = [[[UIPopoverController alloc] initWithContentViewController:_personViewController] autorelease];    
        }             
    }
    if([[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] || [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_personViewController];
        self.personViewController.persons = personArray;
        
        navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:navController animated:YES];
        navController.navigationBar.tintColor = [UIColor colorWithRed:26/255.0 green:99/255.0 blue:140/255.0 alpha:1.0];
        
        UIBarButtonItem *b = [[UIBarButtonItem alloc ]initWithTitle:@"Map" style:UIBarButtonSystemItemPlay target:self action:@selector(back)];
        self.personViewController.navigationItem.leftBarButtonItem = b;
        //[navController pushViewController:self.personViewController animated: YES];
        [b release];
        
        [navController release];
    }else{
        self.personViewController.persons = personArray;
        // Present the popover from the button that was tapped in the detail view.
        [_popOverControllerPersonne presentPopoverFromRect:searchPersonButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    }
    [loading stopAnimating];
    
}
-(void) displayBatiments:(NSArray *)batimetnsArray{
    if(listBatiment){
        [listBatiment release];
    }
    if([batimetnsArray count]==0){
        [_map removeAnnotations:_map.annotations];

        Campus * c = [self.listCampus objectAtIndex:[self.crntCampus intValue]];
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [c.latitude doubleValue];
        
        coordinate.longitude = [c.longitude doubleValue];            
        NSString * s  = [[[NSString alloc]initWithFormat:@"%@",c.campus]autorelease];
        MapLocations *annotation = [[[MapLocations alloc] initWithName:s description:[[[NSString alloc]initWithFormat:@"Responsable: %@ %@ %@",c.titre_resp,c.prenom_resp,c.nom_resp] autorelease] coordinate:coordinate] autorelease];
            // UIImage * imgCmps = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:c.img]]]; 
            
        [_map addAnnotation:annotation];
        
        [self zoomToFitMapAnnotations:_map];
        [loading stopAnimating];
        return;
    }

    self.listBatiment = [batimetnsArray retain];
    [_map removeAnnotations:_map.annotations];
    for (Batiment * c in batimetnsArray) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [c.latitude doubleValue]; 
        coordinate.longitude = [c.longitude doubleValue];            
        NSString * s  = [[[NSString alloc]initWithFormat:@"%@",c.nom]autorelease];
        MapLocations *annotation = [[[MapLocations alloc] initWithName:s description:@"" coordinate:coordinate] autorelease];
        [_map addAnnotation:annotation];
    }
    
    [self zoomToFitMapAnnotations:_map];
    [loading stopAnimating];

}
-(void)displaySallesList:(NSArray *)salleArray{
    if(_salles){
        [_salles release];
    }
    
    _salles = [salleArray retain];
    
    if (_sallesViewController == nil || [self.popOverControllerPersonne contentViewController] != _sallesViewController) {
        self.sallesViewController = [[SalleTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.sallesViewController setDelegate:self];
        if(![[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] && ! [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
            
            self.popOverControllerPersonne = [[[UIPopoverController alloc] initWithContentViewController:_sallesViewController] autorelease];            
        }             
    }
    if([[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] || [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_sallesViewController];
        self.sallesViewController.salle = salleArray;
        
        navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:navController animated:YES];
        navController.navigationBar.tintColor = [UIColor colorWithRed:26/255.0 green:99/255.0 blue:140/255.0 alpha:1.0];
        
        UIBarButtonItem *b = [[UIBarButtonItem alloc ]initWithTitle:@"Map" style:UIBarButtonSystemItemPlay target:self action:@selector(back)];
        self.sallesViewController.navigationItem.leftBarButtonItem = b;
        [b release];
        
        [navController release];
    }else{
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_sallesViewController];
        [_popOverControllerPersonne setContentViewController:navController animated:YES];
        self.sallesViewController.salle = salleArray;
        
        // Present the popover from the button that was tapped in the detail view.
        [_popOverControllerPersonne presentPopoverFromRect:searchSalles.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [navController release];
    }
    [loading stopAnimating];

}
-(void)displaySalleOnMap:(Salle *)salle{
    [_map removeAnnotations:_map.annotations];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [salle.latitude doubleValue];
    
    coordinate.longitude = [salle.longitude doubleValue];            
    NSString * s  = [[[NSString alloc]initWithFormat:@"%@ %@",salle.batiment,salle.num_salle]autorelease];
    MapLocations *annotation = [[[MapLocations alloc] initWithName:s description:[[[NSString alloc]initWithFormat:@"Etage: %@",salle.etage] autorelease] coordinate:coordinate] autorelease];
    [_map addAnnotation:annotation];
    [self zoomToFitMapAnnotations:_map];
}
-(void)removeListFromTopView{
    if(![[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] && ! [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
        [self.popOverControllerPersonne dismissPopoverAnimated:YES];
    }else{
        [self dismissModalViewControllerAnimated:YES];
        
    }
    
}



-(void) displayListOfCampus:(NSArray *)campusArray{
    if(listCampus){
        [listCampus release];
    }
    self.listCampus = [campusArray retain];
    
    if (campusSelector == nil || [self.popOverControllerPersonne contentViewController] != campusSelector) {
        self.campusSelector = [[SelectionListViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.campusSelector setDelegate:self];
        if(![[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] && ! [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
            
            self.popOverControllerPersonne = [[[UIPopoverController alloc] initWithContentViewController:self.campusSelector] autorelease];            
        }             
    }
    if([[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] || [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.campusSelector];
        
        self.campusSelector.initialSelection = [self.crntCampus intValue];

        self.campusSelector.list = campusArray;
        navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:navController animated:YES];
        navController.navigationBar.tintColor = [UIColor colorWithRed:26/255.0 green:99/255.0 blue:140/255.0 alpha:1.0];
        
        UIBarButtonItem *b = [[UIBarButtonItem alloc ]initWithTitle:@"Map" style:UIBarButtonSystemItemPlay target:self action:@selector(back)];
        self.sallesViewController.navigationItem.leftBarButtonItem = b;
        [b release];
        
        [navController release];
    }else{
        UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:self.campusSelector]autorelease];
        navController.navigationBar.tintColor = [UIColor colorWithRed:26/255.0 green:99/255.0 blue:140/255.0 alpha:1.0];
        [self.popOverControllerPersonne setContentViewController:navController];
        self.campusSelector.initialSelection = [self.crntCampus intValue];

        self.campusSelector.list = campusArray;
        
        // Present the popover from the button that was tapped in the detail view.
        [_popOverControllerPersonne presentPopoverFromRect:chooseCampusBtn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    [loading stopAnimating];
}
-(void)displayAllCampusOnMap:(NSArray *)campusArray{
    if(listCampus){
        [listCampus release];
    }
    self.listCampus = [campusArray retain];
    [_map removeAnnotations:_map.annotations];
    for (Campus * c in campusArray) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [c.latitude doubleValue];
        
        coordinate.longitude = [c.longitude doubleValue];            
        NSString * s  = [[[NSString alloc]initWithFormat:@"%@",c.campus]autorelease];
        MapLocations *annotation = [[[MapLocations alloc] initWithName:s description:[[[NSString alloc]initWithFormat:@"Responsable: %@ %@ %@",c.titre_resp,c.prenom_resp,c.nom_resp] autorelease] coordinate:coordinate] autorelease];
        [_map addAnnotation:annotation];
    }
    
    [self zoomToFitMapAnnotations:_map];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    /* Afin de ne pas saturer la mémoire, on va utiliser ici un mécanisme de réutilisation des MKAnnotationView */
    static NSString *AnnotationViewID = @"annotationViewID";
    MKAnnotationView *annotationView =[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    /* si pas en stock, on alloue */
    if (annotationView == nil)
    {
        annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease]; 
        /* on pourra utiliser MKPinAnnotationView pour avoir un pin's */
    }
    /* sinon, on recycle */
    else {
        annotationView.annotation = annotation;
    }
    
    /* si on veut customiser notre annotation */
    annotationView.image=[UIImage imageNamed:@"CASiteClip.png"];
    /* si on veut que notre annotation produise un pop up quand l'utilisateur "tape" dessus */		
    [annotationView setCanShowCallout:YES];
    /* ici, on veut que le pop up dispose d'un bouton à droite... */	
    UIButton * disclosure=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * customDisclosure=[UIImage imageNamed:@"CACustomDisclosure"];
    disclosure.frame=CGRectMake(0, 0, customDisclosure.size.width, customDisclosure.size.height);
    [disclosure setImage:customDisclosure forState:UIControlStateNormal];
    annotationView.rightCalloutAccessoryView = disclosure;
    /* on peut décaler l'annotation de qques pixels */
    //annotationView.centerOffset=unOffset;
    /* et voilà ! on retourne la toute nouvelle MKAnnotationView à notre map */
    return annotationView;
}


@end
