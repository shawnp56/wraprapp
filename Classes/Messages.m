//
//  Messages.m
//  iJoomer
//
//  Created by Tailored Solutions on 30/08/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Messages.h"


@implementation Messages

@synthesize	msgID;
@synthesize subject;
@synthesize body;
@synthesize msgDate;
@synthesize fromName;
@synthesize unread;
@synthesize msgRead;
@synthesize toName;
@synthesize fromid;
@synthesize toId;
@synthesize poston;
@synthesize replyList;
@synthesize ID;
@synthesize parentID;

@synthesize outgoing;

//userdata
@synthesize user_avatar;
@synthesize user_id;
@synthesize user_name;
@synthesize user_profile,avatarImg;
@synthesize playVoice;


- (id)init {
	
	if(self == [super init]) {
		fromName = @"";
		msgDate = @"";
		subject = @"";
		body = @"";
		toName = @"";
        replyList =  [[NSMutableArray alloc] init];
        avatarImg = nil;
        //userdata.
        user_avatar = @"";
        user_name = @"";
        
	}
	
	return self;
}

- (void)dealloc {
	
	[fromName release];
	[msgDate release];
	[body release];
	[subject release];
	[toName release];
	[poston release];
    [replyList release];
    [avatarImg release];
	[playVoice release]
    ;[super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return self.user_avatar;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
    if (image) {
        self.avatarImg = image;
    }
    self.user_avatar = @"";
}

- (void)imageDownloadingError:(NSString *)imageKey {
    user_avatar = @"";
}

@end
