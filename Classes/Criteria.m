//
//  Criteria.m
//  iJoomer
//
//  Created by Tailored Solutions on 05/02/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Criteria.h"


@implementation Criteria


@synthesize required;
@synthesize name;
@synthesize rating;

-(id)init
{
	if(self = [super init]) {
        name = @"";
    }
    return self;
}


- (void)dealloc {
	[name release];
    [super dealloc];
}

@end
