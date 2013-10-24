//
//  Messages.h
//  iJoomer
//
//  Created by Tailored Solutions on 30/08/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"

@interface Messages : NSObject <IconRecord>
{
	NSInteger msgID;
	NSString *subject;
	NSString *body;
	NSString *msgDate;
	NSString *fromName;
	BOOL unread;
	BOOL msgRead;
	NSString *toName;
	NSString *poston;
	NSInteger fromid;
	NSInteger toId;
    NSMutableArray *replyList;
    NSInteger ID;
    NSInteger parentID;
    int outgoing;
    
    //userdata/////
    
    NSString *user_avatar;
    UIImage *avatarImg;
    NSString *user_name;
    NSInteger user_id;
    NSInteger user_profile;
    NSString *playVoice;
}
@property (nonatomic, retain)NSString *playVoice;

@property (nonatomic, readwrite) NSInteger msgID;
@property (nonatomic, readwrite) NSInteger parentID;
@property (nonatomic, readwrite) NSInteger ID;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *msgDate;
@property (nonatomic, retain) NSString *fromName;
@property (assign) BOOL unread;
@property (assign) BOOL msgRead;
@property (assign) int outgoing;
@property (nonatomic, retain) NSString *toName;
@property (nonatomic, readwrite) NSInteger toId;
@property (nonatomic, readwrite) NSInteger fromid;
@property(nonatomic, retain) NSMutableArray *replyList;
@property (nonatomic, retain) NSString *poston;

//userdata/////
@property (nonatomic, retain) NSString *user_avatar;
@property (nonatomic, retain) NSString *user_name;
@property (nonatomic, readwrite) NSInteger user_id;
@property (nonatomic, readwrite) NSInteger user_profile;
@property (nonatomic, retain) UIImage *avatarImg;
@end
