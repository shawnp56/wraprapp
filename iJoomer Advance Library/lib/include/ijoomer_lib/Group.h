//
//  Group.h
//  iJoomer
//
//  Created by Tailored Solutions on 24/11/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"

@interface Group : NSObject<IconRecord> {

}

@property (assign)int Id;
@property (assign)int creatorid;
@property (assign)int catId;
@property (assign)int totalWall, totalEvents;
@property (nonatomic, readwrite) NSInteger totalDiscussions;
@property (nonatomic, readwrite) NSInteger totalMembers;
@property (nonatomic, retain)NSString *creator;
@property (nonatomic, retain)NSString *catName;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *description;
@property (nonatomic, retain)NSString *date;
@property (nonatomic, retain)NSString *thumbURL;
@property (nonatomic, retain)NSString *avatarURL;
@property (nonatomic, retain)NSString *fullimageURL;
@property (nonatomic, retain)NSString *webcontent;
@property (nonatomic, retain)NSString *productDesc;
@property (nonatomic, retain)NSString *productPublish;
@property (nonatomic, readwrite)float price;
@property (nonatomic, readwrite) NSInteger photopermission;
@property (nonatomic, readwrite) NSInteger videopermission;
@property (nonatomic, readwrite) NSInteger albumPermission;
@property (nonatomic, readwrite) NSInteger eventPermission;
@property (nonatomic, readwrite) NSInteger grouprecentphotos;
@property (nonatomic, readwrite) NSInteger grouprecentvideos;
@property (nonatomic, readwrite) NSInteger totalvotes;
@property (nonatomic, readwrite) NSInteger totalFiles;
@property (nonatomic, retain) UIImage *thumbImg;
@property (nonatomic, retain) UIImage *avatarImg;
@property (nonatomic, retain) UIImage *fullimage;
@property (nonatomic, retain) UIImage *inviteimage;
@property (nonatomic ,retain)NSMutableArray *albumList;
@property (nonatomic ,retain)NSMutableArray *videoList;
@property (nonatomic ,retain)NSMutableArray *wallList;
@property (nonatomic ,retain)NSMutableArray *blogDetailList;
@property (nonatomic ,retain)NSMutableArray *storelist;
@property (nonatomic ,retain)NSMutableArray *commentList;
@property(nonatomic, readwrite)float rating;

//@property (assign)int catId;
@property (assign)int no_like;
@property (assign)int no_unlike;
@property (nonatomic ,retain)NSMutableArray *groupOptionList;
@property (nonatomic ,retain)NSMutableArray *reportOptionList;
@property (nonatomic ,retain)NSMutableArray *discussionList;
@property (nonatomic ,retain)NSMutableArray *bulletinList;
@property (nonatomic ,retain)NSMutableArray *groupList;
@property (nonatomic ,retain)NSMutableArray *groupFriendList;
@property (nonatomic ,retain)NSMutableArray *adminList;
@property (nonatomic ,retain)NSMutableArray *memberList;
@property (nonatomic ,retain)NSMutableArray *banList;
@property (nonatomic ,retain)NSMutableArray *eventlist;
@property (nonatomic ,retain)NSMutableArray *fileList;
@property (nonatomic, readwrite) BOOL isjoin;
@property (nonatomic, readwrite) BOOL isinvite,isCommunityAdmin, isAdmin, isBanned,isMember;
@property (nonatomic, readwrite) BOOL isLike,isdisLike;
@property (nonatomic, readwrite) BOOL isProfileAllowed;
@property (nonatomic, readwrite) BOOL isLikeAllowed;
@property (nonatomic, readwrite) BOOL isPrivate;
@property (nonatomic, readwrite) BOOL isWaitingApproval;
@property (nonatomic, readwrite) int memberWaiting;
@property (nonatomic, retain)NSString *shareLink;
@property (nonatomic,retain) NSString *invitemsg;
@property (nonatomic,retain) NSString *inviteurl;

//menu flags
@property (nonatomic, readwrite) BOOL showShare;
@property (nonatomic, readwrite) BOOL showReport;
@property (nonatomic, readwrite) BOOL showCreateDiscussion;
@property (nonatomic, readwrite) BOOL showCreateEvent;
@property (nonatomic, readwrite) BOOL showUploadPhoto;
@property (nonatomic, readwrite) BOOL showCreateAlbum;
@property (nonatomic, readwrite) BOOL showAddVideo;
@property (nonatomic, readwrite) BOOL showJoinGroup;
@property (nonatomic, readwrite) BOOL showInviteFrnd;
@property (nonatomic, readwrite) BOOL showLeaveGroup;

//Admin menu flags
@property (nonatomic, readwrite) BOOL showEdit;
@property (nonatomic, readwrite) BOOL showEditAvatar;
@property (nonatomic, readwrite) BOOL showSendMail;
@property (nonatomic, readwrite) BOOL showCreateAnnouncement;
@property (nonatomic, readwrite) BOOL showUnpublishGroup;
@property (nonatomic, readwrite) BOOL showDeleteGroup;

//options flags
@property (nonatomic, readwrite) BOOL showMemberList;
@property (nonatomic, readwrite) BOOL showalbumList;
@property (nonatomic, readwrite) BOOL showvideoList;
@property (nonatomic, readwrite) BOOL showeventList;
@property (nonatomic, readwrite) BOOL showannouncementList;
@property (nonatomic, readwrite) BOOL showdiscussionList;
@property (nonatomic, readwrite) BOOL showwallList;

@end
