//
//  UserDetailList.h
//  iJoomer
//
//  Created by Harshal Kothari on 13/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IconDownloader.h"

@interface UserDetailList : NSObject<IconRecord> {

	int		 userId;
	NSString *sessionid;
	NSString *userName;
	NSString *status;
	NSString *thumbURL;
	UIImage  *thumbImg;
	NSString *avatarURL;
	UIImage  *avatarImg;
	int		 viewCount;
	
	NSString *Gender;
	NSString *BirthDate;
	NSString *AboutMe;
	NSString *Mobile;
	NSString *Address;
	NSString *State;
	NSString *City;
	NSString *Country;
	NSString *WebSite;
	NSString *College;
	NSString *Graduation;
	float	 latitude;
	float	 longitude;
	BOOL	 online;
	BOOL	 pending;
	int		 photo;
	int		 profile;
	BOOL     isCounted;
	BOOL	 isFullProfileAvailable;	
}

@property(assign) int userId;
@property(nonatomic,retain) NSString *userName;
@property(nonatomic,retain) NSString *sessionid;
@property(nonatomic,retain) NSString *status;
@property(nonatomic,retain) NSString *thumbURL;
@property(nonatomic,retain) UIImage *thumbImg;
@property(nonatomic,retain) NSString *avatarURL;
@property(nonatomic,retain) UIImage *avatarImg;
@property(assign) int viewCount;

@property(nonatomic,retain) NSString *Gender;
@property(nonatomic,retain) NSString *BirthDate;
@property(nonatomic,retain) NSString *AboutMe;
@property(nonatomic,retain) NSString *Mobile;
@property(nonatomic,retain) NSString *Address;
@property(nonatomic,retain) NSString *State;
@property(nonatomic,retain) NSString *City;
@property(nonatomic,retain) NSString *Country;
@property(nonatomic,retain) NSString *WebSite;
@property(nonatomic,retain) NSString *College;
@property(nonatomic,retain) NSString *Graduation;

@property (nonatomic, assign)float latitude;
@property (nonatomic, assign)float longitude;
@property (nonatomic, readwrite) BOOL online;
@property (nonatomic, readwrite) BOOL pending;
@property (nonatomic, readwrite) BOOL isCounted;
@property(assign) int profile;
@property(assign) int photo;
@property BOOL isFullProfileAvailable;


@end
