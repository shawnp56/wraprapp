//
//  Notification.m
//  iJoomer
//
//  Created by Tailored Solutions on 10/05/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Notification.h"


@implementation Notification

@synthesize userID;
@synthesize user_profile;
@synthesize connectionID;
@synthesize connectFrom;
@synthesize user_name;
@synthesize connectTo;
@synthesize thumbUrl,thumbImg,message,notificationType;

- (id)init {
	
	if(self = [super init]) {
		user_name = @"";
        thumbUrl = @"";
        message = @"";
        notificationType = @"";
	}
	
	return self;
}

- (void)dealloc {
	[user_name release];
    [thumbUrl release];
    [message release];
    [notificationType release];
    [super dealloc];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return self.thumbUrl;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	if([self.thumbUrl isEqual:imageKey]) {
		self.thumbImg = image;
	}

}

- (void)imageDownloadingError:(NSString *)imageKey {
	if([self.thumbUrl isEqual:imageKey]) {
		self.thumbUrl = @"";
	}
}



@end
