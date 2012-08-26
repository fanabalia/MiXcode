//
//  PossessionDetalleViewController.m
//  MyStuff
//
//  Created by macbook on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PossessionDetalleViewController.h"
#import "Possession.h"

@interface PossessionDetalleViewController()
-(void)doneButtonPressed:(id)sender;
@end

@implementation PossessionDetalleViewController

@synthesize nameField=_nameField;
@synthesize valueField=_valueField;
@synthesize possession=_possession;
@synthesize modal=_modal;
@synthesize delegate=_delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Item Details"];
        UIBarButtonItem *doneButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed:)];
        [[self navigationItem] setRightBarButtonItem:doneButtonItem];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self nameField] setText:[self.possession name]];
    [[self valueField] setText:[[self.possession value] stringValue]];
}

-(void)doneButtonPressed:(id)sender
{
    
    if([self possession]==nil){
        [self setPossession:[[Possession alloc] init]];
    }
    
    if ([[self.possession name] isEqualToString:[[self nameField] text]] == NO)
    {
        [self.possession setName:[[self nameField] text]];
    }
    
    NSNumber *newValue = [NSNumber numberWithInt:[[[self valueField] text]
                                                  intValue]];
    
    if ([[self.possession value] isEqualToNumber:newValue] == NO) {
        [self.possession setValue:newValue];
    }
    
    [[self delegate] possessionDetalleViewController:self didEditPossession:[self possession]];
     
    
    if([self isModal]==YES){
        [self dismissModalViewControllerAnimated:YES];
    }else{
       [[self navigationController] popViewControllerAnimated:YES]; 
    }
    
}

@end
