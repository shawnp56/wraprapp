//
//  EventOption.m
//  iJoomer
//
//  Created by Tailored Solutions on 11/08/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "EventOption.h"

@implementation EventOption

@synthesize imgURL;
@synthesize imgSource;
@synthesize name;
@synthesize value;

-(id)init {
	if(self = [super init]) {
		name = @"";
		value = @"";
		imgURL = @"";
		imgSource = nil;
	}
	return self;
}

- (void)dealloc {
    if (name) {
        [name release];
    }
    if (value) {
        [value release];
    }
    if (imgURL) {
        [imgURL release];
    }
    if (imgSource) {
        [imgSource release];
    }
	
    [super dealloc];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return self.imgURL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	self.imgSource = image;
}

- (void)imageDownloadingError:(NSObject *)imageKey {
	self.imgURL = @"";
}

@end
