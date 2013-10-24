//
//  Announcement.h
//  iJoomer
//
//  Created by Tailored Solutions on 10/11/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"

@interface Announcement : NSObject<IconRecord> {
    
    NSInteger Id;
    NSInteger creator;
    NSString *name;
    NSString *title;
    NSString *date;
    NSString *msg;
    UIImage *thumbImg;
    NSString *thumbUrl;
    NSMutableArray *replyList1;
    int replies;
    BOOL isLocked;
    NSString *iconUrl;
    UIImage *iconImg;
    
    int files;
    NSString *shareLink;
    BOOL isProfileView;
    BOOL isFilePermission;
}

@property (nonatomic)NSInteger Id;
@property (nonatomic)int replies;
@property (nonatomic) NSInteger creator;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *date;
@property (nonatomic,retain) NSString *msg;
@property (nonatomic,retain) UIImage *thumbImg;
@property (nonatomic,retain) UIImage *iconImg;
@property (nonatomic,retain)  NSString *thumbUrl;
@property (nonatomic,retain)  NSString *iconUrl;
@property (nonatomic,retain) NSMutableArray *replyList1;
@property (nonatomic ,retain)NSMutableArray *fileList;
@property (nonatomic,readwrite) BOOL isLocked;
@property (nonatomic,readwrite) int files;
@property (nonatomic,retain) NSString *shareLink;
@property (nonatomic,readwrite) BOOL isProfileView;
@property (nonatomic,readwrite) BOOL isFilePermission;
@end
