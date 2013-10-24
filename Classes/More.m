//
//  more.m
//  iJoomer
//
//  Created by Tailored Solutions on 23/11/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "More.h"


@implementation More
@synthesize name;
@synthesize thumbImg;
-(id)init
{
	if(self = [super init]) {
		name = @"";
		thumbImg = nil;
	}
	return self;
}
- (void)dealloc {
	[name release];
	[thumbImg release];
	[super dealloc];
}

@end
