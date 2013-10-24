//
//  Video.m
//  iJoomer
//
//  Created by Tailored Solutions on 27/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Video.h"


@implementation Video
@synthesize videoID;
@synthesize videoURL;
@synthesize videoTitle;
@synthesize videoName;
@synthesize videoDesc;
@synthesize videos;
@synthesize videoThumbUrl;
@synthesize videoIcon;
@synthesize webIcon;

@synthesize catID;
@synthesize groupid;
@synthesize permissions;
@synthesize creatorType;
@synthesize groupname;
@synthesize userName;
@synthesize date;
@synthesize location;
@synthesize isProfileView;
@synthesize userId;
@synthesize likes;
@synthesize disllikes;
@synthesize comments;
@synthesize isLiked;
@synthesize isDisliked;
@synthesize isDeleteAllowed;
@synthesize shareLink;
@synthesize commentList;

@synthesize categoryId;
@synthesize tags;
@synthesize user_avatar;
@synthesize user_profile;
-(id)init
{
	if(self == [super init]) {
		videoTitle = @"";
		videoName = @"";
		videoDesc = @"";
        videoURL = @"";
		videoThumbUrl =@"";
		videos = [[NSMutableArray alloc] init];
		videoIcon = nil;
		webIcon = nil;
        creatorType = @"";
        groupname = @"";
        userName = @"";
        date = @"";
        location = @"";
        shareLink = @"";
        commentList = [[NSMutableArray alloc]init];
        
        user_avatar = @"";
        categoryId = 0;
        tags = 0;
        user_profile = 0;
	}
	return self;
}
- (void)dealloc
{
	[videos release];
	[videoIcon release];
    [videoURL release];
	[webIcon release];
	[videoDesc release];
	[videoName release];
	[videoTitle release];
	[videoThumbUrl release];
    [userName release];
    [date release];
    [location release];
    [shareLink release];
    [commentList release];
	[super dealloc];
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return self.videoThumbUrl;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	self.videoIcon = image;
}

- (void)imageDownloadingError:(NSObject *)imageKey {
	self.videoThumbUrl = @"";
}

@end
