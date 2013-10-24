//
//  Wall.m
//  iJoomer
//
//  Created by Tailored Solutions on 20/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Wall.h"
#import "User.h"
#import "Event.h"
#import "Group.h"
#import "Article.h"
#import "Category.h"
//#import "Topic.h"

@implementation Wall

@synthesize code;
@synthesize Id;
@synthesize wallId;
@synthesize title;
@synthesize Error_msg;
@synthesize content;
@synthesize date;
@synthesize time;
@synthesize imageList;
@synthesize commentList;
@synthesize likeList;
@synthesize thumbURL;
@synthesize thumbImg;
@synthesize creatorname;
@synthesize isCommentAllowed;
@synthesize isLikeAllowed;
@synthesize userdetail;
@synthesize videoURL;
@synthesize videoThumbUrl;
@synthesize videoIcon;
@synthesize type;
@synthesize eventDetail;
@synthesize groupDetail;
@synthesize articleDetail;
@synthesize topicDetail;
@synthesize tempUser;
@synthesize isDeleteAllowed;
@synthesize liked;
@synthesize likes;
@synthesize comments;
@synthesize playVoice;
@synthesize playVoiceContent;
@synthesize liketype;
@synthesize commenttype,videoObj;
//@synthesize albumObj;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        title = @"";
		content = @"";
		date = @"";
		time = @"";
		thumbURL = @"";
		creatorname = @"";
		thumbImg = nil;
        videoURL = @"";
		videoThumbUrl =@"";
        Error_msg = @"";
        liketype = @"";
        commenttype = @"";
        playVoice = @"";
        playVoiceContent = @"";
        videoIcon = nil;
		imageList = [[NSMutableArray alloc] init];
		commentList = [[NSMutableArray alloc] init];
		likeList = [[NSMutableArray alloc] init];
        isLikeAllowed = YES;
        isCommentAllowed = YES;
        userdetail = [[User alloc] init];
        type = @"";
        articleDetail = [[Article alloc] init];
        eventDetail = [[Event alloc] init];
        groupDetail = [[Group alloc] init];
        tempUser = [[User alloc] init];
        videoObj = [[Video alloc] init];
    }
    return self;
}


- (void)dealloc
{
    if (title) {
        [title release];
    }
    if (content) {
        [content release];
    }
    if (date) {
        [date release];
    }
    if (time) {
        [time release];
    }
    if (imageList) {
        [imageList release];
    }
    if (commentList) {
        [commentList release];
    }
    if (likeList) {
       [likeList release]; 
    }
    if (thumbURL) {
       [thumbURL release]; 
    }
    if (thumbImg) {
        [thumbImg release];
    }
    if (creatorname) {
      [creatorname release];  
    }
    if (userdetail) {
        [userdetail release];
    }
    if (videoThumbUrl) {
        [videoThumbUrl release];
    }
    if (videoIcon) {
        [videoIcon release];
    }
    if (videoURL) {
        [videoURL release];
    }
    if (type) {
        [type release];
    }
    if (articleDetail) {
      [articleDetail release];  
    }
    if (eventDetail) {
      [eventDetail release];  
    }
    if (groupDetail) {
      [groupDetail release];  
    }
    if (topicDetail) {
       [topicDetail release]; 
    }
    if (Error_msg) {
        
        [Error_msg release];
    }
    if (tempUser) {
        [tempUser release];
    }
    if (videoObj) {
        [videoObj release];
    }
    
    if (playVoice) {
        [playVoice release];
    }
    if (playVoiceContent) {
        [playVoiceContent release];
    }
   //    [albumObj release];
	[super dealloc];
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return self.thumbURL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
    if ([imageKey isEqualToString:thumbURL]) {
        self.thumbImg = image;
    }
    if ([imageKey isEqualToString:videoThumbUrl]) {
        self.videoIcon = image;
    }
	
}

- (void)imageDownloadingError:(NSObject *)imageKey {
    if ([imageKey isEqual:thumbURL]) {
        self.thumbURL = @"";
    }
    if ([imageKey isEqual:videoThumbUrl]) {
        self.videoThumbUrl = @"";
    }
}

@end
