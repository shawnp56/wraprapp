//
//  Announcement.m
//  iJoomer
//
//  Created by Tailored Solutions on 10/11/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Announcement.h"


@implementation Announcement
@synthesize Id;
@synthesize creator;
@synthesize name;
@synthesize title;
@synthesize date;
@synthesize msg;
@synthesize thumbImg;
@synthesize thumbUrl;
@synthesize replyList1;
@synthesize replies;
@synthesize isLocked;
@synthesize iconUrl;
@synthesize iconImg;
@synthesize files,shareLink,isProfileView,isFilePermission,fileList;

-(id)init
{
	self = [super init];
    if(self) {
        name = @"";
		title = @"";
		date = @"";
        msg = @"";
        thumbUrl = @"";
        iconUrl = @"";
        thumbImg = nil;
        iconImg = nil;
        files = 0;
        shareLink = @"";
        isProfileView = NO;
        isFilePermission =NO;
        replyList1 = [[NSMutableArray alloc]init];
        fileList = [[NSMutableArray alloc]init];
        isLocked = NO;
    }
	return self;
}
- (void)dealloc {
    [name release];
    [title release];
    [date release];
    [msg release];
    [thumbUrl release];
    [iconUrl release];
    [thumbImg release];
    [iconImg release];
    [replyList1 release];
    [fileList release];
    [super dealloc];
}
- (NSString *)getImageURL {
	return thumbUrl;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	if([self.thumbUrl isEqual:imageKey]) {
		self.thumbImg = image;
	}
    if([self.iconUrl isEqual:imageKey]) {
		self.iconImg = image;
	}
}

- (void)imageDownloadingError:(NSObject *)imageKey {
	if([self.thumbUrl isEqual:imageKey]) {
		self.thumbUrl = @"";
    }
    if([self.iconUrl isEqual:imageKey]) {
		self.iconUrl = @"";
	}
}

@end
