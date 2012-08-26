//
//  Possession.m
//  MyStuff
//
//  Created by macbook on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Possession.h"

static NSString * const kNameKey=@"name";
static NSString * const kValueKey=@"value";

@implementation Possession

@synthesize name=_name;
@synthesize value=_value;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    self=[self init];
    
    if(self){
        [self setName:[aDecoder decodeObjectForKey:kNameKey]];
        [self setValue:[aDecoder decodeObjectForKey:kValueKey]];
    }
    
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[self name] forKey:kNameKey];
    [aCoder encodeObject:[self value] forKey:kValueKey];
}

@end
