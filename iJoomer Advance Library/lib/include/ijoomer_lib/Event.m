//
//  Event.m
//  iJoomer
//
//  Created by Tailored Solutions on 30/12/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Event.h"
#import "Article.h"


@implementation Event

@synthesize Id;
@synthesize hits;
@synthesize attendees;
@synthesize confirmedSeats;
@synthesize availableSeats;
@synthesize totalSeats;
@synthesize eventCreatorId;
@synthesize eventAdminId;
@synthesize eventLikeCount;
@synthesize eventDisLikeCount;
@synthesize userEventStatus;
@synthesize date;
@synthesize title;
@synthesize desc;
@synthesize createdBy;
@synthesize tags;
@synthesize catName;
@synthesize publishUp;
@synthesize time;
@synthesize locationName;
@synthesize latitude;
@synthesize reportName;
@synthesize longitude;
@synthesize thumbURL;
@synthesize fullURL;
@synthesize contact;
@synthesize thumbImg;
@synthesize fullImg;
@synthesize repeatList;
//@synthesize article;
@synthesize userInfo;
@synthesize category;
@synthesize eventList;
@synthesize adminList;
@synthesize guestList;
@synthesize waitingList;
@synthesize blockedList;
@synthesize eventOptionList;
@synthesize reportList;
@synthesize operationUrl;
@synthesize operationName;
@synthesize eventType;
@synthesize guestType;
@synthesize groupList;
@synthesize jomFriendList;
@synthesize eventReportList;
@synthesize isCommunityAdmin;
@synthesize isMapDisplay;
@synthesize jomWallList;
@synthesize isBtnYourResponsShow;
@synthesize isLiked;
@synthesize isDisLiked;
@synthesize jomTotalAdmins;
@synthesize jomTotalGuest;
@synthesize jomTotalBlocked;
@synthesize jomTotalWaitingUser;
@synthesize jomTotalFriend;
@synthesize showEditAvtar;
@synthesize showSendMail;
@synthesize showEditEvent;
@synthesize showInviteFriend;
@synthesize showIgnoreEvent;
@synthesize showDeleteEvent;
@synthesize showYourResponse;

@synthesize summary;
@synthesize isOpen;
@synthesize isInvitation;
@synthesize wallCount;
@synthesize shareLink;
@synthesize isWaitingApproval;
@synthesize invitemsg;
@synthesize inviteurl;
@synthesize inviteimage;
- (id)init {
    self = [super init];
	if(self) {
        time = @"";
		date = @"";
		title = @"";
		desc = @"";
		createdBy = @"";
		tags = @"";
		catName = @"";
		publishUp = @"";
		time = @"";
        
		locationName = @"";
		thumbURL =@"";
		fullURL = @"";
		invitemsg = @"";
        inviteurl = @"";
        contact = @"";
		operationUrl = @"";
		operationName = @"";
		reportName = @"";
		eventType = YES;
		guestType = YES;
		isCommunityAdmin = NO;
		isMapDisplay = NO;
		isBtnYourResponsShow = NO;
		isLiked = NO;
		isDisLiked = NO;
        jomTotalAdmins = 0;
        jomTotalGuest = 0;
        jomTotalBlocked = 0;
        jomTotalWaitingUser = 0;
        jomTotalFriend = 0;
		repeatList = [[NSArray alloc] init];
		eventList = [[NSMutableArray alloc] init];
		adminList = [[NSMutableArray alloc] init];
		guestList = [[NSMutableArray alloc] init];
		waitingList = [[NSMutableArray alloc] init];
		eventOptionList = [[NSMutableArray alloc] init];
		reportList = [[NSMutableArray alloc] init];
		groupList = [[NSMutableArray alloc] init];
		jomFriendList = [[NSMutableArray alloc] init];
		eventReportList = [[NSMutableArray alloc] init];
		blockedList = [[NSMutableArray alloc] init];
		jomWallList = [[NSMutableArray alloc] init];
		//article = [[Article alloc] init];
		userInfo = [[User alloc] init];
        showEditAvtar = NO;
        showSendMail = NO;
        showEditEvent = NO;
        showInviteFriend = NO;
        showIgnoreEvent = NO;
        showDeleteEvent = NO;
        showYourResponse = NO;
        summary = @"";
        isOpen = NO;
        isInvitation = NO;
        wallCount = 0;
        shareLink = @"";
        isWaitingApproval = NO;
        inviteimage = [[UIImage alloc]init];
	}
	return self;
}

- (void)dealloc {
	
    if (date) {
        [date release];
    }
	if (title) {
        [title release];
    }
	if (desc) {
        [desc release];
    }
    if (createdBy) {
        [createdBy release];
    }
	if (tags) {
        [tags release];
    }
    if (catName) {
        [catName release];
    }
    if (publishUp) {
        [publishUp release];
    }
	if (time) {
        [time release];
    }
    if (locationName) {
        [locationName release];
    }
	if (thumbURL) {
        [thumbURL release];
    }
	if (fullURL) {
        [fullURL release];
    }
	if (contact) {
        [contact release];
    }
	if (repeatList) {
        [repeatList release];
    }
    if (reportName) {
        [reportName release];
    }
	if (eventList) {
        [eventList release];
    }
    if (adminList) {
        [adminList release];
    }
    if (guestList) {
        [guestList release];
    }
    if (waitingList) {
        [waitingList release];
    }
    if (blockedList) {
        [blockedList release];
    }
    if (eventOptionList) {
        [eventOptionList release];
    }
    if (reportList) {
        [reportList release];
    }
    if (groupList) {
        [groupList release];
    }
    if (jomFriendList) {
        [jomFriendList release];
    }
    if (eventReportList) {
        [eventReportList release];
    }
    if (jomWallList) {
        [jomWallList release];
    }
    if (userInfo) {
        [userInfo release];
    }
    [summary release];
    [shareLink release];
    [invitemsg release];
    [inviteurl release];
    [inviteimage release];
    //[article release];
	[super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return self.thumbURL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	if ([imageKey isEqualToString:self.thumbURL]) {
		if (image) {
			self.thumbImg = image;
		}
		self.thumbURL = @"";
	}
	if ([imageKey isEqualToString:self.fullURL]) {
		if (image) {
			self.fullImg = image;
		}
		self.thumbURL = @"";
	}	
}

- (void)imageDownloadingError:(NSString *)imageKey {
	if ([imageKey isEqualToString:self.thumbURL])
		thumbURL = @"";
	if ([imageKey isEqualToString:self.fullURL])
		fullURL = @"";
}

@end
