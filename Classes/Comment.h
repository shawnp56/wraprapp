//
//  Comment.h
//  iJoomer
//
//  Created by Tailored Solutions on 20/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"


@interface Comment : UIView <IconRecord>{

	int commentId;
	NSString *commentText;
	NSString *dateTime;
	NSString *thumbURL;
	UIImage *thumbImg;
	NSString *date;
	NSString *creatorname;
	NSString *timestamp;
    int userId;
    BOOL isProfileView;
    BOOL isDeleteAllowed;
    NSString *playVoice;
}
@property (nonatomic, retain)NSString *playVoice;
@property (assign)int commentId;
@property (nonatomic, retain)NSString *commentText;
@property (nonatomic, retain)NSString *dateTime;
@property (nonatomic, retain)NSString *thumbURL;
@property (nonatomic, retain)UIImage *thumbImg;
@property (nonatomic, retain)NSString *date;
@property (nonatomic, retain)NSString *creatorname;
@property (nonatomic, retain)NSString *timestamp;
@property (assign)int userId;
@property (assign)BOOL isProfileView;
@property (assign)BOOL isDeleteAllowed;
@end
