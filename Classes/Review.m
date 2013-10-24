//
//  Review.m
//  iJoomer
//
//  Created by Tailored Solutions on 13/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Review.h"


@implementation Review

@synthesize Id;
@synthesize title;
@synthesize text;
@synthesize reviewersName;
@synthesize reviewersEmail;
@synthesize reviewersRating;
@synthesize reviewersDate;
@synthesize grouparray;
@synthesize commentarray;
@synthesize userId;

- (id)init {
	
	if(self = [super init]) {
		title = @"";
		text =@"";
		reviewersName = @"";
		reviewersEmail =@"";
		reviewersDate = @"";
		grouparray = [[NSMutableArray alloc] init];
		commentarray = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
	[title release];
	[text release];
	[reviewersName release];
	[reviewersEmail release];
	[reviewersDate release];
	[grouparray release];
	[commentarray release];

}

@end
