//
//  Possession.h
//  MyStuff
//
//  Created by macbook on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Possession : NSObject <NSCoding>

@property(copy) NSString *name;
@property(strong) NSNumber *value;

@end
