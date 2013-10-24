//
//  SettingsObj.h
//  iJoomer
//
//  Created by Tailored Solutions on 24/05/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Privacy : NSObject {

	NSString *privacyProfile;
	NSString *privacyFriends;
	NSString *privacyPhoto;
	NSInteger notifyEmailSystem;
	NSInteger notifyEmailApps;
	NSInteger notifyWallComment;
	NSInteger isOnlinePush;
	NSInteger isMailPush;
	NSInteger isRequestOnline;
}

@property (nonatomic, retain) NSString *privacyProfile;
@property (nonatomic, retain) NSString *privacyFriends;
@property (nonatomic, retain) NSString *privacyPhoto;
@property (nonatomic, readwrite) NSInteger notifyEmailSystem;
@property (nonatomic, readwrite) NSInteger notifyEmailApps;
@property (nonatomic, readwrite) NSInteger notifyWallComment;
@property (nonatomic, readwrite) NSInteger isOnlinePush;
@property (nonatomic, readwrite) NSInteger isMailPush;
@property (nonatomic, readwrite) NSInteger isRequestOnline;

@end
