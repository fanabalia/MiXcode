//
//  PossessionListTableViewCell.m
//  MyStuff
//
//  Created by macbook on 25/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PossessionListTableViewCell.h"

#import "Possession.h"

static NSString * const kPossessionNamePath=@"name";
static NSString * const kPossessionValuePath=@"value";

@implementation PossessionListTableViewCell{
    BOOL isObservingPossession;
}

@synthesize possession=_possession;

-(void)dealloc
{
    if(isObservingPossession==YES){
        [_possession removeObserver:self forKeyPath:kPossessionNamePath];
        [_possession removeObserver:self forKeyPath:kPossessionValuePath];
        isObservingPossession=NO;
    }
}

-(void)setPossession:(Possession *)possession
{

    
    if(isObservingPossession==YES){
        [_possession removeObserver:self forKeyPath:kPossessionNamePath];
        [_possession removeObserver:self forKeyPath:kPossessionValuePath];
        isObservingPossession=NO;
    }
    _possession=possession;
    if(_possession!=nil){
        [_possession addObserver:self forKeyPath:kPossessionNamePath options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:NULL];
        [_possession addObserver:self forKeyPath:kPossessionValuePath options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:NULL]; 
        isObservingPossession=YES;
    }
}

-(void)prepareForReuse
{
    [self setPossession:nil];
    [super prepareForReuse];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(object==[self possession]){
        if([keyPath isEqualToString:kPossessionNamePath]){
            [[self textLabel] setText:[change objectForKey:NSKeyValueChangeNewKey]];
        }else if([keyPath isEqualToString:kPossessionValuePath]){
            [[self detailTextLabel] setText:[[change objectForKey:NSKeyValueChangeNewKey] stringValue]];
        }
    }
}



@end
