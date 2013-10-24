//
//  User.m
//  iJoomer
//
//  Created by Tailored Solutions on 13/05/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "User.h"


@implementation User

@synthesize Liked;
@synthesize Likes;
@synthesize isLikeAllowed;
@synthesize Disliked;
@synthesize Dislikes;
@synthesize TotalFriends;
@synthesize TotalGroup;
@synthesize TotalPhotos;
@synthesize Error_msg;
@synthesize code;
@synthesize userId;
@synthesize sessionid;
@synthesize userName;
@synthesize fbuserName;
@synthesize status;
@synthesize thumbURL;
@synthesize thumbImg;
@synthesize avatarURL;
@synthesize coverpicURL;
@synthesize avatarImg;
@synthesize viewCount;
@synthesize totalWall;
@synthesize sendMessage;
@synthesize addFriend;
@synthesize facebookId;
@synthesize email;
@synthesize passwordtoken;
@synthesize totalAlbum;
@synthesize online;
@synthesize latitude;
@synthesize longitude;
@synthesize pending;
@synthesize profile;
@synthesize photo;
@synthesize isCounted;
@synthesize isFullProfileAvailable;
@synthesize albumListarray;
@synthesize videoListarray;
@synthesize wallList;
@synthesize groupList;
@synthesize isFriend;
@synthesize isInvited;
@synthesize isAdmin;
@synthesize isCreator;
@synthesize isCommunityAdmin;

@synthesize friends_count;
@synthesize search_count;
@synthesize member_count;
@synthesize profile_video;
//vm
@synthesize userstatus;
@synthesize canBan;
@synthesize canUser;
@synthesize canAdmin;
@synthesize canRemove,friendList;
@synthesize playVoice;
@synthesize coverImg;

- (id)init {
	
	if(self = [super init]) {
        userId = 0;
        friends_count = 0;
        search_count = 0;
        member_count = 0;
        
		userName = @"";
        fbuserName = @"";
		status = @"";
		thumbURL = @"";
		thumbImg = nil;
		avatarURL = @"";
        coverpicURL = @"";
		avatarImg = nil;
        coverImg = nil;
		email = @"";
		passwordtoken = @"";
		facebookId = @"";
		isCounted = NO;
		isFullProfileAvailable = NO;
		isInvited = NO;
		isAdmin = NO;
		albumListarray = [[NSMutableArray alloc] init];
		videoListarray = [[NSMutableArray alloc]init];
		wallList = [[NSMutableArray alloc]init];
		groupList = [[NSMutableArray alloc]init];
        profile_video = [[NSDictionary alloc] init];
        friendList = [[NSMutableArray alloc]init];
        isCreator = NO;
        isCommunityAdmin = NO;
    }
	return self;
}

- (void)dealloc {
    
    if (fbuserName) {
        [fbuserName release];
    }
    if (userName) {
        [userName release];
    }
    if (status) {
        [status release];
    }
    if (thumbURL) {
        [thumbURL release];
    }
    if (thumbImg) {
        [thumbImg release];
    }
    if (avatarURL) {
        [avatarURL release];
    }
    if (avatarImg) {
        [avatarImg release];
    }
    if (facebookId) {
        [facebookId release];
    }
    if (email) {
        [email release];
    }
    if (passwordtoken) {
        [passwordtoken release];
    }
    if (albumListarray) {
        [albumListarray release];
    }
    if (videoListarray) {
        [videoListarray release];
    }
    if (wallList) {
        [wallList release];
    }
    if (groupList) {
        [groupList release];
    }
    if (profile_video) {
        
        [profile_video release];
    }
    [friendList release];
    
    [super dealloc];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return avatarURL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	if([self.thumbURL isEqual:imageKey] && !thumbImg) {
		self.thumbImg = image;
	} else if([self.avatarURL isEqual:imageKey]) {
		self.avatarImg = image;
	}
}

- (void)imageDownloadingError:(NSObject *)imageKey {
	if([self.thumbURL isEqual:imageKey]) {
		self.thumbURL = @"";
	} else if([self.avatarURL isEqual:imageKey]) {
		self.avatarURL = @"";
	}
	
}

@end
