//
//  Comment.m
//  iJoomer
//
//  Created by Tailored Solutions on 20/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Comment.h"


@implementation Comment


@synthesize commentId;
@synthesize commentText;
@synthesize dateTime;
@synthesize thumbURL;
@synthesize thumbImg;
@synthesize date;
@synthesize creatorname;
@synthesize timestamp,userId,isProfileView,isDeleteAllowed;
@synthesize playVoice;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        commentText = @"";
		dateTime = @"";
		thumbURL = @"";
		thumbImg = nil;
		date = @"";
		creatorname = @"";
    }
    return self;
}


- (void)dealloc {
	[commentText release];
	[dateTime release];
	[thumbURL release];
	[thumbImg release];
	[date release];
	[creatorname release];
	[timestamp release];
    [playVoice release];
    [super dealloc];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return self.thumbURL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	self.thumbImg = image;
}

- (void)imageDownloadingError:(NSObject *)imageKey {
	self.thumbURL = @"";
}

@end
