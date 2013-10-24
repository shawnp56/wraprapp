//
//  UpdateList.m
//  iJoomer
//
//  Created by Tailored Solutions on 01/05/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Activity.h"


@implementation Activity

@synthesize updateTitle;
@synthesize updateDate;
@synthesize updateTime;
@synthesize updateID;

-(id)init
{
	if(self = [super init]) {
		updateTime = @"";
		updateDate = @"";
		updateTitle = @"";
	}
	return self;
}

- (void)dealloc {
	
	[updateTime release];
	[updateDate release];
	[updateTitle release];
    [super dealloc];
}


@end
