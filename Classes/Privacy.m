//
//  SettingsObj.m
//  iJoomer
//
//  Created by Tailored Solutions on 24/05/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Privacy.h"


@implementation Privacy

@synthesize privacyProfile;
@synthesize privacyFriends;
@synthesize privacyPhoto;
@synthesize notifyEmailSystem;
@synthesize notifyEmailApps;
@synthesize notifyWallComment;
@synthesize isOnlinePush;
@synthesize isMailPush;
@synthesize isRequestOnline;

- (id)init {
	if(self == [super init]) {
		privacyProfile = @"";
		privacyPhoto = @"";
		privacyFriends = @"";
	}
	return self;
}

- (void)dealloc {
	[privacyProfile release];
	[privacyPhoto release];
	[privacyFriends release];
    [super dealloc];
}


@end
