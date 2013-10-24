//
//  User.h
//  iJoomer
//
//  Created by Tailored Solutions on 13/05/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IconDownloader.h"

@interface User : NSObject <IconRecord>{


}
@property BOOL isFullProfileAvailable;
@property(nonatomic,retain) NSString *playVoice;
@property(assign) int TotalGroup;
@property(assign) int TotalFriends;
@property(assign) int TotalPhotos;
@property(assign) int Likes;
@property(assign) int Dislikes;
@property(nonatomic,readwrite) BOOL Liked;
@property(nonatomic,readwrite) BOOL Disliked;
@property(nonatomic,readwrite) BOOL isLikeAllowed;
@property(assign) int code;
@property(assign) int viewCount;
@property(assign) int userId;
@property(assign) int profile;
@property(assign) int photo;
@property(assign) int totalWall;
@property(assign) int totalAlbum;
@property(assign) int friends_count;
@property(assign) int member_count;
@property(assign) int search_count;
@property(nonatomic,retain) NSString *Error_msg;
@property(nonatomic,retain) NSString *userName;
@property(nonatomic,retain) NSString *fbuserName;
@property(nonatomic,retain) NSString *sessionid;
@property(nonatomic,retain) NSString *status;
@property(nonatomic,retain) NSString *thumbURL;
@property(nonatomic,retain) UIImage *thumbImg;
@property(nonatomic,retain) NSString *avatarURL;
@property(nonatomic,retain) NSString *coverpicURL;
@property(nonatomic,retain) UIImage *avatarImg;
@property(nonatomic,retain) UIImage *coverImg;
@property(nonatomic,retain) NSString *sendMessage;
@property(nonatomic,retain) NSString *addFriend;

@property(nonatomic,retain) NSString *facebookId;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *passwordtoken;

@property(nonatomic,retain) NSDictionary *profile_video;

@property(nonatomic,retain)NSMutableArray *albumListarray;
@property(nonatomic,retain)NSMutableArray *videoListarray;
@property(nonatomic,retain)NSMutableArray *wallList;
@property(nonatomic,retain)NSMutableArray *groupList;
@property(nonatomic, retain)NSMutableArray *friendList;

@property(nonatomic,assign)float latitude;
@property(nonatomic,assign)float longitude;

@property(nonatomic,readwrite) BOOL online;
@property(nonatomic,readwrite) BOOL pending;
@property(nonatomic,readwrite) BOOL isCounted;
@property(nonatomic,readwrite) BOOL isFriend;
@property(nonatomic,readwrite) BOOL isInvited;
@property(nonatomic,readwrite) BOOL isAdmin;
@property(nonatomic,readwrite) BOOL isCreator;
@property(nonatomic,readwrite) BOOL isCommunityAdmin;
@property(nonatomic,readwrite) BOOL canBan;
@property(nonatomic,readwrite) BOOL canUser;
@property(nonatomic,readwrite) BOOL canAdmin;
@property(nonatomic,readwrite) BOOL canRemove;

// vm

@property (nonatomic,readwrite)	BOOL userstatus;

@end
