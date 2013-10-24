//
//  UpdateList.m
//  iJoomer
//
//  Created by Harshal Kothari on 01/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UpdateList.h"


@implementation UpdateList

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
