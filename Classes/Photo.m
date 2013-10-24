//
//  PhotoList.m
//  iJoomer
//
//  Created by Tailored Solutions on 30/04/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Photo.h"


@implementation Photo
@synthesize	photoID;
@synthesize photoURL;
@synthesize photoImg;
@synthesize thumbImg;
@synthesize thumbURL;
@synthesize tempImg;
@synthesize downloaded;
@synthesize downloading;
@synthesize name;
@synthesize commentList;

@synthesize delegate;
@synthesize shareLink,likeCount,commentCount,dislikeCount,isLiked,isDisliked;

- (id)init {
	
	if (self == [super init]) {
		photoURL = @"";
		photoImg = nil;
        thumbURL = @"";
		thumbImg = nil;
		tempImg  = nil;
        name = @"";
        shareLink = @"";
        commentList = [[NSMutableArray alloc] init];
        isLiked = NO;
        isDisliked = NO;
	}
	
	return self;
}

- (void)dealloc {
	[photoImg release];
	[photoURL release];
    [thumbImg release];
	[thumbURL release];
	[tempImg release];
    [name release];
    [shareLink release];
    [commentList release];
    [super dealloc];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

//- (NSString *)getImageURL {
//	return self.photoURL;
//}
//
//- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
//	if([self.thumbURL isEqual:imageKey] && !thumbImg) {
//		self.thumbImg = image;
//        if([self.thumbURL isEqualToString:self.photoURL]) {
//        self.photoImg = self.thumbImg;
//        }
//	} else if([self.photoURL isEqual:imageKey]) {
//		self.photoImg = image;
//	}
//}
//
//- (void)imageDownloadingError:(NSObject *)imageKey {
//	if([self.thumbURL isEqual:imageKey] && !thumbImg) {
//		self.thumbURL = @"";
//	} else if([self.photoURL isEqual:imageKey]) {
//		self.photoURL = @"";
//	}
//}


- (NSString *)getImageURL {
	return self.photoURL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	if([self.thumbURL isEqual:imageKey]) {
		self.thumbImg = image;
	} 
    if([self.photoURL isEqual:imageKey]) {
		self.photoImg = image;
	}
}

- (void)imageDownloadingError:(NSObject *)imageKey {
	if([self.thumbURL isEqual:imageKey]) {
		self.thumbURL = @"";
	}
    if([self.photoURL isEqual:imageKey]) {
		self.photoURL = @"";
	}
}


@end
