//
//  MapViewController.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 23.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapLocations.h"
#import "MenuItemDelegate.h"
#import "MapDisplayerDelegate.h"
#import "PersonTableViewController.h"
#import "SalleTableViewController.h"
#import "SelectionListViewController.h"
#import "PersonDAO.h"
#import "BatimentDAO.h"
#import "CampusDAO.h"
#import "SalleDAO.h"

#define METERS_PER_MILE 1609.344
/**
 Resposible to diplay the map with different options
 */
@interface MapViewController : UIViewController<UISearchBarDelegate,MapDisplayerDelegate,CampusDAOProtocol,PersonDAOProtocol,BatimentDAOProtocol,SalleDAOProtocol> {
    
    MKMapView *_map;
    UISearchBar * searchBar;
    UISearchDisplayController * searchBarCTRL;
    UIPopoverController * _popOverControllerPersonne;
    UIButton * searchPersonButton;
    UIButton * searchSalles;
    UIButton * chooseCampusBtn;

    PersonTableViewController *_personViewController;
    SalleTableViewController *_sallesViewController;
    SelectionListViewController *campusSelector;
    
    NSArray * _persons ;
    NSArray * _salles ;
    NSArray * listCampus;
    NSArray * listBatiment;

    NSNumber * crntCampus;
    UIActivityIndicatorView *loading;
    BOOL waitingLoad;
}

@property (nonatomic, retain) PersonTableViewController * personViewController;
@property (nonatomic, retain) SalleTableViewController *sallesViewController;
@property (nonatomic, retain)  SelectionListViewController *campusSelector;

@property (nonatomic, retain) UIPopoverController * popOverControllerPersonne;
@property (nonatomic, retain) NSArray * persons ;
@property (nonatomic, retain) NSArray * salles ;
@property (nonatomic, retain) NSArray * listCampus;
@property (nonatomic, retain) NSArray * listBatiment;

@property (nonatomic, retain) NSNumber * crntCampus;


@property (nonatomic, retain) IBOutlet MKMapView * map;
@property (nonatomic, retain) IBOutlet UISearchBar * searchBar;
@property (nonatomic, retain) IBOutlet UISearchDisplayController * searchBarCTRL;
@property (nonatomic, retain) IBOutlet UIButton * searchPersonButton;
@property (nonatomic, retain) IBOutlet UIButton * searchSalles;
@property (nonatomic,retain) IBOutlet UIButton * chooseCampusBtn;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loading;

@property (nonatomic, retain) IBOutlet UINavigationController *subViews;


- (IBAction)searchPersonn:(id)sender;
- (IBAction)searchSalle:(id)sender;
- (IBAction)chooseCampus:(id)sender;
- (IBAction)openSearchDialog:(id)sender;

- (IBAction)goHome:(id)sender;
- (void)zoomToFitMapAnnotations:(MKMapView *) map;

@property (nonatomic, assign) id <MenuItemDelegate> delegate;


@end
