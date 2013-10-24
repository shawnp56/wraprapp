//
//  Image.m
//  iJoomer
//
//  Created by Tailored Solutions on 25/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Image.h"


@implementation Image

@synthesize imgURL;
@synthesize imgSource;
@synthesize bigImgURL;
- (id)init {
	
	if(self == [super init]) {
		imgURL = @"";
		imgSource = nil;
		bigImgURL = @"";
	}
	
	return self;
}

- (void)dealloc {
	[imgSource release];
	[imgURL release];
	[bigImgURL release];
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
