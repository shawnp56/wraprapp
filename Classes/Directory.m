//
//  Directory.m
//  iJoomer
//
//  Created by Tailored Solutions on 07/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Directory.h"


@implementation Directory

@synthesize directoryId;
@synthesize directoryName;
@synthesize section;

- (id)init {
	self = [super init];
	if(self) {
		directoryName = @"";
		section = [[NSMutableArray alloc]init];
	}
	return self;
}

- (void)dealloc {
	[directoryName release];
	[section release];
    [super dealloc];
}
@end
