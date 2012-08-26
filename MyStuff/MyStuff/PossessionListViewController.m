//
//  PossessionListViewController.m
//  MyStuff
//
//  Created by macbook on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PossessionListViewController.h"
#import "Possession.h"
#import "PossessionDetalleViewController.h"
#import "PossessionListTableViewCell.h"

@interface PossessionListViewController(){
    NSMutableArray *_possessions;
}

-(void)addItemButtonPressed:(id)sender;
-(Possession *)possessionAtIndex:(NSUInteger *)index;
-(NSString *)possessionsArchivePath;
-(void)savePossessionToDisk;
-(void)loadPossessionFromDisk;

@end;

@implementation PossessionListViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        [self setTitle:@"My Stuff"];
        
        UIBarButtonItem *addItemButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemButtonPressed:)];
        
        [[self navigationItem] setRightBarButtonItem:addItemButton];
        
        /*Possession *iPhone = [[Possession alloc] init];
        [iPhone setName:@"iPhone 4S"];
        [iPhone setValue:[NSNumber numberWithInt:649]];
        
        Possession *iPad = [[Possession alloc] init];
        [iPad setName:@"iPad 2"];
        [iPad setValue:[NSNumber numberWithInt:499]];
        
        _possessions = [NSMutableArray arrayWithObjects:iPhone, iPad, nil];*/
        
        [self loadPossessionFromDisk];
    }
    
    return self;
    
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_possessions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PossessionCell";
    
    PossessionListTableViewCell *cell = (PossessionListTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PossessionListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Possession *possession=[self possessionAtIndex:indexPath.row];
    [cell setPossession:possession];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PossessionDetalleViewController *detailViewController =
    [[PossessionDetalleViewController alloc] initWithNibName:nil
                                                     bundle:nil];
    
    [detailViewController setDelegate:self];
    
    Possession *possession=[self possessionAtIndex:indexPath.row];
    
    [detailViewController setPossession:possession];
    
    [[self navigationController] pushViewController:detailViewController
                                           animated:YES];
}

-(Possession *)possessionAtIndex:(NSUInteger *)index
{
    return [_possessions objectAtIndex:index];
}

-(void)addItemButtonPressed:(id)sender
{
    PossessionDetalleViewController *detailViewController=[[PossessionDetalleViewController alloc] initWithNibName:nil bundle:nil];
    
    [detailViewController setDelegate:self];
    
    [detailViewController setModal:YES];
    
    UINavigationController *navigationController=[[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    [self presentModalViewController:navigationController animated:YES];
}

-(void)possessionDetalleViewController:(PossessionDetalleViewController *)detailViewController didEditPossession:(Possession *) possession
{
    if([_possessions containsObject:possession]==NO){
        [_possessions addObject:possession];
        NSIndexPath *newIndexPath=[NSIndexPath indexPathForRow:[_possessions indexOfObject:possession] inSection:0];
        NSArray *indexPaths=[NSArray arrayWithObject:newIndexPath];
        [[self tableView] insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    [self savePossessionToDisk];
}

-(void)savePossessionToDisk
{
    
    [NSKeyedArchiver archiveRootObject:_possessions toFile:[self possessionsArchivePath]];
}

-(void)loadPossessionFromDisk
{
    _possessions = [NSKeyedUnarchiver unarchiveObjectWithFile:[self possessionsArchivePath]];
    
    if (_possessions == nil) {
        _possessions = [NSMutableArray array];
    }
}

-(NSString *)possessionsArchivePath{
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentPath stringByAppendingPathComponent:@"possessions.archive"];
}

@end
