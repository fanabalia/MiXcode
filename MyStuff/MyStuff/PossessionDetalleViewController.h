//
//  PossessionDetalleViewController.h
//  MyStuff
//
//  Created by macbook on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PossessionDetalleViewDelegate.h"

@class Possession;

@interface PossessionDetalleViewController : UIViewController

@property (weak) IBOutlet UITextField *nameField;
@property (weak) IBOutlet UITextField *valueField;
@property (strong) Possession *possession;
@property (getter = isModal) BOOL modal;
@property (weak) id<PossessionDetalleViewDelegate> delegate;

@end
