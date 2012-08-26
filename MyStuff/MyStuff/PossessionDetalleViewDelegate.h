//
//  PossessionDetalleViewDelegate.h
//  MyStuff
//
//  Created by macbook on 24/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Possession;
@class PossessionDetalleViewController;

@protocol PossessionDetalleViewDelegate <NSObject>

@required
-(void)possessionDetalleViewController:(PossessionDetalleViewController *)detailViewController didEditPossession:(Possession *) possession;

@end
