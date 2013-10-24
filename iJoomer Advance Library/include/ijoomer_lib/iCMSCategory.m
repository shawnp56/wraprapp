//
//  iCMSCategory.m
//  iJoomer
//
//  Created by Tailored Solutions on 3/20/13.
//
//

#import "iCMSCategory.h"

@implementation iCMSCategory

@synthesize category_id,category_name,totalArticles,thumbImg,thumbURL,articles,subCategories;
@synthesize category_desc,hits,totalCategories,parent_id;


- (id)init {
	
	if(self = [super init]) {
        
        category_id = 0;
        totalArticles = 0;
        hits = 0;
        totalCategories = 0;
        
        category_name = @"";
        category_desc = @"";
        parent_id = @"";
        thumbImg = nil;
        thumbURL = @"";
        
        articles = [[NSMutableArray alloc] init];
        subCategories = [[NSMutableArray alloc] init];
    }
	return self;
}


- (void)dealloc {
    [category_name release];
    [category_desc release];
    [parent_id release];
    [thumbURL release];
    [thumbImg release];
    [articles release];
    [subCategories release];
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
	}
}

- (void)imageDownloadingError:(NSObject *)imageKey {
	if([self.thumbURL isEqual:imageKey]) {
		self.thumbURL = @"";
	}
}

@end
