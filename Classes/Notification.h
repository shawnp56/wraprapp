//
//  NotificationList.h
//  iJoomer
//
//  Created by Tailored Solutions on 10/05/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"

@interface Notification : NSObject <IconRecord>{

	NSInteger connectionID;
    NSInteger userID;
	NSInteger connectFrom;
	NSString *user_name;
	NSInteger connectTo;
    NSInteger user_profile;
    NSString *thumbUrl;
    UIImage *thumbImg;
	NSString *message;
    NSString *notificationType;
}

@property (nonatomic,readwrite) NSInteger userID;
@property (nonatomic,readwrite) NSInteger user_profile;
@property (nonatomic, retain) NSString *notificationType;

@property (nonatomic, readwrite) NSInteger connectionID;
@property (nonatomic, readwrite) NSInteger connectFrom;
@property (nonatomic, retain) NSString *user_name;
@property (nonatomic, readwrite) NSInteger connectTo;
@property (nonatomic, retain) NSString *thumbUrl;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) UIImage *thumbImg;
@end
