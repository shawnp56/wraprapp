//
//  UpdateTimeList.m
//  iJoomer
//
//  Created by Tailored Solutions on 01/05/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "ActivityHeader.h"


@implementation ActivityHeader
@synthesize time;
@synthesize updates;

-(id)init
{
	if(self = [super init]) {
		time = @"";
		updates = [[NSMutableArray alloc]init];
	}
	return self;
}

- (void)dealloc {
	[updates release];
	[time release];
    [super dealloc];
}


@end
