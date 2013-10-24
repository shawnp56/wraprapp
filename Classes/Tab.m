//
//  Tab.m
//  iJoomer
//
//  Created by Tailored Solutions on 19/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Tab.h"


@implementation Tab

@synthesize dict_itemdata;

@synthesize itemdata_id;
@synthesize itemid;

@synthesize title;
@synthesize classname;
@synthesize tabimg;
@synthesize tabimgUrl;
@synthesize thumbImg;
@synthesize thumbURL;
@synthesize showicon;
@synthesize showtab;
@synthesize smallImg;
@synthesize smallURL;
@synthesize tabactiveimgpath;
@synthesize tabimgpath;

-(id)init
{
	self = [super init];
    if(self)
    {
        dict_itemdata = [[NSDictionary alloc] init];
        
        itemdata_id = 0;
        itemid = 0;
        
		title = @"";
		classname= @"";
		tabimgUrl = @"";
        showtab = NO;
        showicon = NO;
        smallURL = @"";
        thumbURL = @"";
        tabimg = nil;
        thumbImg = nil;
        smallimg = nil;
        
        tabactiveimgpath = @"";
        tabimgpath = @"";
	}
	return self;
}

- (void)dealloc
{
	[title release];
	[classname release];
    [tabimgUrl release];
    [smallURL release];
    [thumbURL release];
    [tabimgUrl release];
    [smallimg release];
    [tabimg release];
    [thumbImg release];
    [super dealloc];
}

- (NSString *)getImageURL {
	return self.tabimgUrl;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	if([self.thumbURL isEqual:imageKey] && !thumbImg) {
		self.thumbImg = image;
//        if([self.thumbURL isEqualToString:self.tabimgUrl]) {
//            self.tabimg = self.thumbImg;
//        }
//        if([self.thumbURL isEqualToString:self.smallURL]){
//            self.smallImg = self.thumbImg;
//        }
	} 
    if([self.tabimgUrl isEqual:imageKey]) {
		self.tabimg = image;
	}
    if([self.smallURL isEqual:imageKey]) {
		self.smallImg = image;
	}
}

- (void)imageDownloadingError:(NSObject *)imageKey {
	if([self.thumbURL isEqual:imageKey]) {
		self.thumbURL = @"";
	}
    if([self.tabimgUrl isEqual:imageKey]) {
		self.tabimgUrl = @"";
	}
    if([self.smallURL isEqual:imageKey]) {
		self.smallURL = @"";
	}
}

@end
