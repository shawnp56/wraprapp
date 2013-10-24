//
//  DirectorySection.m
//  iJoomer
//
//  Created by Tailored Solutions on 07/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Section.h"


@implementation Section

@synthesize sectionId;
@synthesize sectionName;
@synthesize categorys;
@synthesize totalArticles;

- (id)init {
	self = [super init];
	if(self) {
		sectionName = @"";
		categorys = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc {
	[sectionName release];
	[categorys release];
    [super dealloc];
}

@end
