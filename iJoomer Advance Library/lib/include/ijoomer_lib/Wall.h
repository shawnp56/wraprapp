//
//  Wall.h
//  iJoomer
//
//  Created by Tailored Solutions on 20/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"
#import "Video.h"
@class User,Event,Group,Article,Topic;
//@class Category;

@interface Wall : UIView<IconRecord> {
}
@property(assign) int total_updates;
@property(assign) int code;
@property (assign)int Id;
@property (assign)int wallId;
@property(nonatomic,retain) NSString *Error_msg;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *creatorname;
@property (nonatomic, retain) NSMutableArray *imageList;
@property (nonatomic, retain) NSMutableArray *commentList;
@property (nonatomic, retain) NSMutableArray *likeList;
@property (nonatomic, retain) NSString *thumbURL;
@property (nonatomic, retain) UIImage *thumbImg;
@property (nonatomic, retain) NSString *videoURL;
@property (nonatomic, retain) NSString *videoThumbUrl;
@property (nonatomic, retain) UIImage *videoIcon;
@property bool isCommentAllowed;
@property bool isLikeAllowed;
@property (nonatomic, readwrite)BOOL isDeleteAllowed;
@property (nonatomic, retain) User *userdetail;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) Event *eventDetail;
@property (nonatomic, retain) Group *groupDetail;
@property (nonatomic, retain) Article *articleDetail;
@property (nonatomic, retain) Topic *topicDetail;
@property (nonatomic, retain) User *tempUser;
@property (nonatomic, readwrite)BOOL liked;
@property (nonatomic, readwrite)int likes;
@property (nonatomic, readwrite)int comments;

@property (nonatomic, retain) NSString *liketype;
@property (nonatomic, retain) NSString *commenttype;
@property (nonatomic, retain) Video *videoObj;
@property (nonatomic, retain) NSString *playVoice;
@property (nonatomic, retain) NSString *playVoiceContent;

//@property (nonatomic, retain) Category *albumObj;


@end
