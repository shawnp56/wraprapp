//
//  Like.m
//  iJoomer
//
//  Created by Tailored Solutions on 20/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Like.h"


@implementation Like


@synthesize likeId;
@synthesize name;
@synthesize userId;
@synthesize description;
@synthesize code;
@synthesize Error_msg;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        name = @"";
        description = @"";
        Error_msg = @"";
    }
    return self;
}


- (void)dealloc {
    if (name) {
        
        [name release];
    }
    if (description) {
        
        [description release];
    }
    if (Error_msg) {
        
        [Error_msg release];
    }

    [super dealloc];
}


@end
