//
//  Field.m
//  iJoomer
//
//  Created by Tailored Solutions on 18/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Field.h"


@implementation Field

@synthesize name;
@synthesize value;
@synthesize caption;
@synthesize fields;
@synthesize fieldType;

-(id)init
{
	if(self = [super init]) {
		name = @"";
		value = @"";
		fieldType = @"";
		caption = @"";
		fields = [[NSMutableArray alloc] init];
	}
	return self;
}
- (void)dealloc {
	[super dealloc];
	[name release];
	[value release];
	[caption release];
	[fields release];
	[fieldType release];

}
@end
