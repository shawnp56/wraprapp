//
//  UserDetailList.m
//  iJoomer
//
//  Created by Harshal Kothari on 13/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserDetailList.h"


@implementation UserDetailList

@synthesize userId;
@synthesize sessionid;
@synthesize userName;
@synthesize status;
@synthesize thumbURL;
@synthesize thumbImg;
@synthesize avatarURL;
@synthesize avatarImg;
@synthesize viewCount;

@synthesize Gender;
@synthesize BirthDate;
@synthesize AboutMe;
@synthesize Mobile;
@synthesize Address;
@synthesize State;
@synthesize City;
@synthesize Country;
@synthesize WebSite;
@synthesize College;
@synthesize Graduation;
@synthesize online;
@synthesize latitude;
@synthesize longitude;
@synthesize pending;
@synthesize profile;
@synthesize photo;
@synthesize isCounted;
@synthesize isFullProfileAvailable;

- (id)init {
	
	if(self = [super init]) {
		userName = @"";
		status = @"";
		thumbURL = @"";
		thumbImg = nil;
		avatarURL = @"";
		avatarImg = nil;
		Gender = @"";
		BirthDate = @"";
		AboutMe = @"";
		Mobile = @"";
		Address = @"";
		State = @"";
		City = @"";
		Country = @"";
		WebSite = @"";
		College = @"";
		Graduation = @"";
		isCounted = NO;
		isFullProfileAvailable = NO;
	}
	
	return self;
}

- (void)dealloc {
	[userName release];
	[status release];
	[thumbURL release];
	[thumbImg release];
	[avatarURL release];
	[avatarImg release];
	[Gender release];
	[BirthDate release];
	[AboutMe release];
	[Mobile release];
	[Address release];
	[State release];
	[City release];
	[Country release];
	[WebSite release];
	[College release];
	[Graduation release];
	
    [super dealloc];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return avatarURL;
	//if([self.thumbURL isEqual:imageKey]) {
//		self.thumbImg = image;
//	} else if([self.mainImageURL isEqual:imageKey]) {
//		self.mainImage = image;
//	}
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	//self.avatarImg = image;
	if([self.thumbURL isEqual:imageKey]) {
		self.thumbImg = image;
	} else if([self.avatarURL isEqual:imageKey]) {
		self.avatarImg = image;
	}
}


@end
