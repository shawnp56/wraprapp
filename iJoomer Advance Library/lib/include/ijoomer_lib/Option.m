//
//  Option.m
//  iJoomer
//
//  Created by Tailored Solutions on 29/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Option.h"


@implementation Option

@synthesize name;
@synthesize caption;
@synthesize value;
@synthesize isSelected;
@synthesize isSeletionRequired;
@synthesize tempName,price,ID,url,operand;

@synthesize contactId;
@synthesize email;
@synthesize thumbImg;
@synthesize isSelectedEmail;
@synthesize isSelectedOnsite;
@synthesize isSelectedPush;

-(id)init
{
	if(self = [super init]) {
		name = @"";
        caption = @"";
		value = @"";
		isSelected = NO;
        isSeletionRequired = NO;
        
        tempName = @"";
        price=0.00;
        ID = @"";
        url = @"";
        
        contactId = 0;
        email = @"";
        thumbImg = nil;

	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
