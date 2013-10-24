//
//  Event.h
//  iJoomer
//
//  Created by Tailored Solutions on 30/12/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"
#import "Article.h"
#import "User.h"
#import "Option.h"

@interface Event : NSObject<IconRecord> {
    
}

@property(assign)int Id;
@property(assign)int hits;

@property(assign)int attendees;

@property(assign)int confirmedSeats;


@property(assign)int eventAdminId;



@property(nonatomic, readwrite) BOOL guestType;
@property(nonatomic, readwrite) BOOL eventType;
@property(nonatomic, readwrite) BOOL isBtnYourResponsShow;


@property(nonatomic, retain)NSString *time;
@property(nonatomic, retain)NSString *date;
@property(nonatomic, retain)NSString *title;

@property(nonatomic, retain)NSString *tags;

@property(nonatomic, retain)NSString *publishUp;
@property(nonatomic, retain)NSString *locationName;
@property(nonatomic, retain)NSString *thumbURL;
@property(nonatomic, retain)NSString *fullURL;
@property(nonatomic, retain)NSString *contact;
@property(nonatomic, retain)UIImage  *thumbImg;
@property(nonatomic, retain)UIImage  *fullImg;
@property(nonatomic, retain)NSString *reportName;
@property(nonatomic, retain)NSArray *repeatList;

@property(nonatomic, retain) NSMutableArray *eventList;
@property(nonatomic, retain) NSMutableArray *guestList;
@property(nonatomic, retain) NSMutableArray *adminList;
@property(nonatomic, retain) NSMutableArray *waitingList;
@property(nonatomic, retain) NSMutableArray *blockedList;
@property(nonatomic, retain) NSMutableArray *eventOptionList;
@property(nonatomic, retain) NSMutableArray *reportList;
@property(nonatomic, retain) NSMutableArray *groupList;
@property(nonatomic, retain) NSMutableArray *jomFriendList;
@property(nonatomic, retain) NSString *operationName;
@property(nonatomic, retain) NSString *operationUrl;
@property(nonatomic, retain) NSMutableArray *eventReportList;
@property(nonatomic, retain) NSMutableArray *jomWallList;
//@property(nonatomic, retain)Article  *article;
@property(nonatomic, retain)User	 *userInfo;
@property(nonatomic, retain)Category *category;
@property(nonatomic, readwrite)int jomTotalFriend;
@property(nonatomic, readwrite)int jomTotalAdmins;

@property(nonatomic, readwrite)int jomTotalGuest;
@property(nonatomic, readwrite)int jomTotalBlocked;

// Menu
@property(nonatomic, readwrite)BOOL showEditAvtar;//
@property(nonatomic, readwrite)BOOL showSendMail;//
@property(nonatomic, readwrite)BOOL showEditEvent;//
@property(nonatomic, readwrite)BOOL showInviteFriend;//
@property(nonatomic, readwrite)BOOL showIgnoreEvent;//
@property(nonatomic, readwrite)BOOL showDeleteEvent;//
@property(nonatomic, readwrite)BOOL showYourResponse;//

//other config and variables
@property(nonatomic, retain)NSString *catName;
@property(nonatomic, retain)NSString *desc;
@property(nonatomic, retain)NSString *summary;//
@property(assign)int eventCreatorId;
@property(nonatomic, retain)NSString *createdBy;
@property(assign)float latitude;
@property(assign)float longitude;
@property(nonatomic, readwrite)BOOL isOpen;//
@property(nonatomic, readwrite) BOOL isCommunityAdmin;
@property(nonatomic, readwrite) BOOL isMapDisplay;
@property(nonatomic, readwrite)BOOL isInvitation;//
@property (nonatomic,retain) NSString *invitemsg;//
@property (nonatomic,retain) NSString *inviteurl;//
@property (nonatomic, retain) UIImage *inviteimage;//
@property(nonatomic, readwrite)int wallCount;//
@property(assign)int availableSeats;
@property(assign)int totalSeats;
@property(assign)int userEventStatus;
@property(assign,readwrite)int eventLikeCount;
@property(assign,readwrite)int eventDisLikeCount;
@property(nonatomic, readwrite) BOOL isLiked;
@property(nonatomic, readwrite) BOOL isDisLiked;
@property(nonatomic, retain)NSString *shareLink;//
@property(nonatomic, readwrite)int jomTotalWaitingUser;
@property(nonatomic, readwrite) BOOL isWaitingApproval;//

@end
