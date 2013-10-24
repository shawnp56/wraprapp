//
//  Group.m
//  iJoomer
//
//  Created by Tailored Solutions on 24/11/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Group.h"


@implementation Group
@synthesize Id;
@synthesize creatorid;
@synthesize catId;
@synthesize photopermission;
@synthesize videopermission;
@synthesize albumPermission;
@synthesize eventPermission;
@synthesize grouprecentphotos;
@synthesize grouprecentvideos;
@synthesize creator;
@synthesize catName;
@synthesize name;
@synthesize description;
@synthesize date;
@synthesize thumbURL;
@synthesize avatarURL;
@synthesize thumbImg;
@synthesize avatarImg;
@synthesize fullimage;
@synthesize albumList;
@synthesize videoList;
@synthesize wallList;
@synthesize blogDetailList;
@synthesize webcontent;
@synthesize storelist;
@synthesize price;
@synthesize totalvotes;
@synthesize fullimageURL;
@synthesize productDesc;
@synthesize productPublish;
@synthesize rating;
@synthesize commentList;
@synthesize isjoin;
@synthesize bulletinList;
@synthesize discussionList;
@synthesize groupOptionList;
@synthesize reportOptionList;
@synthesize no_like;
@synthesize no_unlike;
@synthesize isinvite;
@synthesize isCommunityAdmin;
@synthesize groupList;
@synthesize groupFriendList;
@synthesize adminList;
@synthesize memberList;
@synthesize banList;
@synthesize isLike,isdisLike;
@synthesize invitemsg;
@synthesize inviteurl;
@synthesize inviteimage;
@synthesize isAdmin;
@synthesize eventlist;
@synthesize isBanned,isMember;
@synthesize totalWall, totalEvents,totalDiscussions,totalMembers,isProfileAllowed;
@synthesize totalFiles,isLikeAllowed,isPrivate,isWaitingApproval,memberWaiting,shareLink;
@synthesize showShare,showReport,showCreateDiscussion,showCreateEvent,showUploadPhoto;
@synthesize showCreateAlbum,showAddVideo,showJoinGroup,showInviteFrnd,showLeaveGroup,showEdit;
@synthesize showEditAvatar,showSendMail,showCreateAnnouncement,showUnpublishGroup,showDeleteGroup;
@synthesize showMemberList,showalbumList,showvideoList,showeventList,showannouncementList,showdiscussionList;
@synthesize showwallList,fileList;
-(id)init
{
	if(self = [super init]) {
        totalWall = 0;
        totalDiscussions = 0;
        totalMembers = 0;
		creator =@"";
		catName = @"";
		name = @"";
		description =@"";
		date = @"";
		thumbURL = @"";
		avatarURL = @"";
		fullimageURL =@"";
		webcontent = @"";
		productDesc =@"";
		productPublish=@"";
		thumbImg = nil;
		albumList = [[NSMutableArray alloc] init];
		videoList = [[NSMutableArray alloc]init];
		wallList = [[NSMutableArray alloc]init];
		blogDetailList = [[NSMutableArray alloc] init];
		storelist = [[NSMutableArray alloc] init];
		commentList = [[NSMutableArray alloc]init];
        discussionList = [[NSMutableArray alloc]init];
        bulletinList = [[NSMutableArray alloc]init];
        groupOptionList = [[NSMutableArray alloc]init];
        reportOptionList = [[NSMutableArray alloc]init];
        groupList = [[NSMutableArray alloc]init];
        groupFriendList = [[NSMutableArray alloc]init];
        adminList = [[NSMutableArray alloc]init];
        memberList = [[NSMutableArray alloc]init];
        banList = [[NSMutableArray alloc]init];
        fileList = [[NSMutableArray alloc]init];
        isjoin = NO;
        isinvite = NO;
        isCommunityAdmin = NO;
        isdisLike = NO;
        isLike = NO;
        invitemsg = @"";
        isAdmin = NO;
        isBanned = NO;
        isMember = NO;
        isProfileAllowed = NO;
        eventlist = [[NSMutableArray alloc]init];
        isLikeAllowed = NO;
        isPrivate = NO;
        isWaitingApproval = NO;
        memberWaiting = 0;
        shareLink = @"";

	}
	return self;
}

- (void)dealloc {
    if (creator) {
        [creator release];
    }
    if (catName) {
        [catName release];
    }
	if (description) {
        [description release];
    }
    if (name) {
        [name release];
    }
	if (date) {
        [date release];
    }
	if (productDesc) {
        [productDesc release];
    }
	if (productPublish) {
        [productPublish release];
    }
	if (thumbURL) {
        [thumbURL release];
    }
	if (avatarURL) {
        [avatarURL release];
    }
    if (fullimage) {
        [fullimage release];
    }
    if (webcontent) {
        [webcontent release];
    }
	if (thumbImg) {
        [thumbImg release];
    }
	if (fullimageURL) {
        [fullimageURL release];
    }
    if (albumList) {
        [albumList release];
    }
    if (videoList) {
        [videoList release];
    }
	if (wallList) {
        [wallList release];
    }
    if (storelist) {
        [storelist release];
    }
	if (blogDetailList) {
        [blogDetailList release];
    }
	if (commentList) {
        [commentList release];
    }
	if (groupOptionList) {
        [groupOptionList release];
    }
    if (reportOptionList) {
        [reportOptionList release];
    }
    if (groupList) {
        [groupList release];
    }
    if (groupFriendList) {
        [groupFriendList release];
    }
    if (adminList) {
        [adminList release];
    }
    if (memberList) {
        [memberList release];
    }
    if (banList) {
        [banList release];
    }
    if (invitemsg) {
        [invitemsg release];
    }
    if (eventlist) {
        [eventlist release];
    }
    if (shareLink) {
        [shareLink release];
    }
    if (fileList) {
        [fileList release];
    }
    
    [super dealloc];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return avatarURL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	if([self.thumbURL isEqual:imageKey]) {
		self.thumbImg = image;
	} 
    if([self.avatarURL isEqual:imageKey]) {
		self.avatarImg = image;
	}
    if([self.fullimageURL isEqual:imageKey]) {
		self.fullimage = image;
	}
    if([self.inviteurl isEqual:imageKey]){
        self.inviteimage = image;
    }
}

- (void)imageDownloadingError:(NSObject *)imageKey {
	if([self.thumbURL isEqual:imageKey]) {
		self.thumbURL = @"";
	}  
    if([self.avatarURL isEqual:imageKey]) {
		self.avatarURL = @"";
	}
	if([self.fullimageURL isEqual:imageKey]) {
		self.fullimageURL = @"";
	}
    if([self.inviteurl isEqual:imageKey]) {
		self.inviteurl = @"";
	}
}

@end
