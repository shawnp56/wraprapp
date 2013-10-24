//
//  Application_config.m
//  iJoomer
//
//  Created by tailored on 3/18/13.
//
//

#import "Application_config.h"

@implementation Application_config

@synthesize thumbURL;
@synthesize thumbImg;
@synthesize Tabicon_thumURL;
@synthesize user_thumURL;
@synthesize userIcon;
@synthesize TabIcon;

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return self.thumbURL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
    if ([imageKey isEqualToString:thumbURL]) {
        self.thumbImg = image;
    }
    if ([imageKey isEqualToString:Tabicon_thumURL]) {
        self.TabIcon = image;
    }
	
}

- (void)imageDownloadingError:(NSObject *)imageKey {
    if ([imageKey isEqual:thumbURL]) {
        self.thumbURL = @"";
    }
    if ([imageKey isEqual:Tabicon_thumURL]) {
        self.Tabicon_thumURL = @"";
    }
}


@end
