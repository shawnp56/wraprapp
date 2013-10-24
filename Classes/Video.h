//
//  Video.h
//  iJoomer
//
//  Created by Tailored Solutions on 27/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"


@interface Video : NSObject<IconRecord> {
	NSInteger videoID;
	NSString *videoURL;
	NSString *videoTitle;
	NSString *videoThumbUrl;
	NSString *videoName;
	NSString *videoDesc;
	NSMutableArray *videos;
	UIImage *videoIcon;
	UIWebView *webIcon;
    NSInteger catID;
    NSInteger permissions;
    NSString *creatorType;
    NSInteger groupid; 
    NSString *groupname;
    
    NSString *userName;
    NSString *date;
    NSString *location;
    BOOL isProfileView;
    int userId;
    int likes;
    int disllikes;
    int comments;
    BOOL isLiked;
    BOOL isDisliked;
    BOOL isDeleteAllowed;
    NSString *shareLink;
    NSMutableArray *commentList;
    
    int categoryId;
    int tags;
    int user_profile;
    NSString *user_avatar;
}
@property (nonatomic, readwrite) NSInteger videoID;
@property (nonatomic, retain) NSString *videoURL;
@property (nonatomic, retain) NSString *videoTitle;
@property (nonatomic, retain) NSString *videoThumbUrl;
@property (nonatomic, retain) NSString *videoName;
@property (nonatomic, retain) NSString *videoDesc;
@property (nonatomic, retain) UIImage *videoIcon;
@property (nonatomic, retain) UIWebView *webIcon;

@property (nonatomic, retain) NSMutableArray *videos;

@property (nonatomic, readwrite) NSInteger catID;
@property (nonatomic, readwrite) NSInteger  groupid;  
@property (nonatomic, readwrite) NSInteger permissions;
@property (nonatomic, retain) NSString *creatorType;
@property (nonatomic, retain) NSString *groupname;

@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, readwrite) BOOL isProfileView;
@property (nonatomic, readwrite) int userId;
@property (nonatomic, readwrite) int likes;
@property (nonatomic, readwrite) int disllikes;
@property (nonatomic, readwrite) int comments;
@property (nonatomic, readwrite) BOOL isLiked;
@property (nonatomic, readwrite) BOOL isDisliked;
@property (nonatomic, readwrite) BOOL isDeleteAllowed;
@property (nonatomic, retain) NSString *shareLink;
@property (nonatomic, retain) NSMutableArray *commentList;

@property (nonatomic, retain) NSString *user_avatar;
@property (nonatomic, readwrite) int categoryId;
@property (nonatomic, readwrite) int tags;
@property (nonatomic, readwrite) int user_profile;
@end
