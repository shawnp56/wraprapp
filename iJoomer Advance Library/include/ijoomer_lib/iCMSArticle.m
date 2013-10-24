//
//  iCMSArticle.m
//  iJoomer
//
//  Created by Tailored Solutions on 3/20/13.
//
//

#import "iCMSArticle.h"

@implementation iCMSArticle

@synthesize article_id, article_title, article_desc, thumbImg, thumbURL,introtext,catid,created_by_id,shareLink,created_date,parent_id,parent_title,author;
@synthesize alias;
@synthesize category_alias;
@synthesize category_title;
@synthesize created_by_alias;
@synthesize publish_down,publish_up;
@synthesize full_img,image_fulltext;
@synthesize isDownloaded;

- (id)init {
	
	if(self = [super init]) {
        
        article_id = 0;
        catid = 0;
        created_by_id = 0;
        parent_id = 0;
        
        article_title = @"";
        author = @"";
        article_desc = @"";
        introtext = @"";
        created_date = @"";
        parent_title = @"";
        shareLink = @"";
        alias = @"";
        category_alias = @"";
        category_title = @"";
        created_by_alias = @"";
        publish_down = @"";
        publish_up = @"";
        
        full_img = nil;
        image_fulltext = @"";
        
        thumbImg = nil;
        thumbURL = @"";
        
        isDownloaded = NO;
    }
	return self;
}

- (void)dealloc {
    [article_desc release];
    [article_title release];
    [author release];
    [introtext release];
    [shareLink release];
    [parent_title release];
    [thumbURL release];
    [thumbImg release];
    [created_date release];
    [alias release];
    [category_alias release];
    [category_title release];
    [created_by_alias release];
    [publish_down release];
    [publish_up release];
    [image_fulltext release];
    [full_img release];
    [super dealloc];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return thumbURL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	if([self.thumbURL isEqual:imageKey] && !thumbImg) {
		self.thumbImg = image;
	}else if([self.image_fulltext isEqual:imageKey]) {
		self.full_img = image;
	}
}

- (void)imageDownloadingError:(NSObject *)imageKey {
	if([self.thumbURL isEqual:imageKey]) {
		self.thumbURL = @"";
	}else if([self.image_fulltext isEqual:imageKey]) {
		self.image_fulltext = @"";
	}
}

@end
