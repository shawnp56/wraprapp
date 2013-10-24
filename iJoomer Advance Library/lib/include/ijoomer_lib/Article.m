//
//  Article.m
//  iJoomer
//
//  Created by Tailored Solutions on 07/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Article.h"
#import "Category.h"

@implementation Article


@synthesize Id;
@synthesize articleid;
@synthesize articletitle;
@synthesize introtext;
@synthesize articlehits;
@synthesize writtenby;
@synthesize articledesc;
@synthesize date;
@synthesize articleCount;
@synthesize grouplist;
@synthesize reviewlist;
@synthesize imageList;
@synthesize criteriaList;
@synthesize reviewFieldList;
@synthesize thumbURL;
@synthesize thumbImg;
@synthesize editorRating;
@synthesize editorCount;
@synthesize userRating;
@synthesize userCount;
@synthesize isDetailAvailable;
@synthesize catId;
@synthesize userId;
@synthesize youtubeURL;
@synthesize downloaded;
@synthesize latitude;
@synthesize longitude;
@synthesize distance;
@synthesize isReviewAllow;
@synthesize scal;
@synthesize increment;
@synthesize graphType;
@synthesize reviewTitleMode;
@synthesize reviewContentMode;
@synthesize uploadImageLimit;
@synthesize mapIcon;
@synthesize mapImg;
@synthesize sectionID;

- (id)init {
	self = [super init];
	if (self) {
		articletitle = @"";
		introtext =@"";
		articledesc = @"";
		thumbURL = @"";
		thumbImg = nil;
		isDetailAvailable = NO;
		downloaded = NO;
		isReviewAllow = YES;
		youtubeURL = @"";
		reviewTitleMode = @"Required";
		reviewContentMode = @"Required";
		
        mapIcon =@"";
        mapImg = nil;
        
		grouplist =[[NSMutableArray alloc] init];
		reviewlist = [[NSMutableArray alloc] init];
		imageList = [[Category alloc] init];
		criteriaList = [[NSMutableArray alloc] init];
		reviewFieldList = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc {
    
    if (articletitle) {
       [articletitle release]; 
    }
    if (introtext) {
        [introtext release];
    }
    if (articledesc) {
        [articledesc release];
    }
    if (grouplist) {
        [grouplist release];
    }
    if (reviewlist) {
      [reviewlist release];  
    }
    if (criteriaList) {
        [criteriaList release];
    }
    if (reviewFieldList) {
        [reviewFieldList release];
    }
    if (thumbURL) {
       [thumbURL release]; 
    }
    if (thumbImg) {
        [thumbImg release];
    }
    if (youtubeURL) {
        [youtubeURL release];
    }
    if (reviewTitleMode) {
       [reviewTitleMode release]; 
    }
    if (reviewContentMode) {
        [reviewContentMode release];
    }
    if (mapIcon) {
        [mapIcon release];
    }
    if (mapImg) {
        [mapImg release];
    }
    [super dealloc];
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return self.thumbURL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	if([self.thumbURL isEqual:imageKey]) {
		self.thumbImg = image;
	} 
    if([self.mapIcon isEqual:imageKey]) {
		self.mapImg = image;
	}
}

- (void)imageDownloadingError:(NSString *)imageKey {
	if([self.thumbURL isEqual:imageKey]) {
		self.thumbURL = @"";
	}
    if([self.mapIcon isEqual:imageKey]) {
		self.mapIcon = @"";
	}
}

@end
