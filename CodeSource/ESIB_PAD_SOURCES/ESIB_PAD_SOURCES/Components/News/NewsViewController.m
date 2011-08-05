//
//  NewsViewController.m
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 05.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDAO.h"
#import "Actualite.h"
#import "RotableUINavController.h"
#import "NewsCellViewController.h"
@implementation NewsViewController

@synthesize delegate,cellNib,tmpCell;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void) displayNews: (NSArray *)listOfNews{
    if(_news)
        [_news release];
    _news = [listOfNews retain];
    

    [[self tableView] reloadData];

}

- (void)viewDidLoad {
    NewsDAO * nDAO = [[NewsDAO alloc] init];
    [nDAO setDelegate:self];
    [nDAO getNews];
    [nDAO release];
    self.cellNib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
    [self.tableView setBackgroundView:nil];
    [self.tableView  setBackgroundView:[[[UIView alloc] init] autorelease]];
    [self.tableView  setBackgroundColor:[UIColor whiteColor]];   
    [super viewDidLoad];
}

- (void)dealloc {
    
	[_news release];
	_news = nil;
	[super dealloc];
	
}

#pragma mark Table View methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}/*
-(UITableView *) tableView
- (UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor orangeColor];
    [super beautifyCell:cell atIndexPath:indexPath];
    return nil;

}*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
	return [_news count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        return  71;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        // Return YES for supported orientations
	return YES;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UIViewController * c = [[UIViewController alloc]init];  
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    c.view.autoresizesSubviews = YES;
    
    [c.view addSubview:webView];
    Actualite * a = [_news objectAtIndex:[indexPath row]];
    RotableUINavController *navController = [[RotableUINavController alloc] initWithRootViewController:c];
    NSString * url = [[NSString alloc] initWithFormat:@"http://www.usj.edu.lb/actualites/news.php?id=%@",a.idDB];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [url release];
    [webView release];
    [navController.view sizeToFit];
    [c.view sizeToFit];
    [webView sizeToFit];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
       if(![[[UIDevice currentDevice] model]isEqualToString:@"iPhone"] && ! [[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator" ]){
           navController.modalPresentationStyle = UIModalPresentationPageSheet;
       }
    [self presentModalViewController:navController animated:YES];
    navController.navigationBar.tintColor = [UIColor colorWithRed:26/255.0 green:99/255.0 blue:140/255.0 alpha:1.0];

    UIBarButtonItem *b = [[UIBarButtonItem alloc ]initWithTitle:@"News" style:UIBarButtonSystemItemPlay target:self action:@selector(back)];
    c.navigationItem.leftBarButtonItem = b;
    [navController.view sizeToFit];
    [c.view sizeToFit];
    [webView sizeToFit];
    [c release];
    [b release];

    [navController release];
}
-(void) back{
    [self dismissModalViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"News Cell Identifier";
    NewsCellViewController *cell = (NewsCellViewController *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Actualite * a = [_news objectAtIndex:[indexPath row]];

	if (cell == nil) {

        [self.cellNib instantiateWithOwner:self options:nil];
		cell = tmpCell;
		self.tmpCell = nil;
        cell.backgroundView = [[[UIView alloc] init] autorelease];
        cell.selectedBackgroundView = [[[UIView alloc] init] autorelease];
        UIImage * i = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:a.img]]];
        cell.images = [i autorelease];


	}
  

	cell.titre = a.titre;
    cell.ss_titre = a.ss_titre;

    return cell;
}



@end
