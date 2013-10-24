//
//  ApplicationMenuItem.m
//  iJoomer
//
//  Created by tailored on 3/21/13.
//
//

#import "ApplicationMenuItem.h"

@implementation ApplicationMenuItem

@synthesize dict_itemdata;
@synthesize itemid;
@synthesize str_itemcaption;
@synthesize str_itemview;

@synthesize icon_URL;
@synthesize tab_active_URL;
@synthesize tab_URL;
@synthesize thumb_icon;
@synthesize thumb_tab;
@synthesize thumb_tab_active;
@synthesize viewname;
@synthesize iconpath;
@synthesize tabActpath;
@synthesize tabpath;
@synthesize itemdata_id;

-(id)init
{
    self = [super init];
	if(self)
    {
        itemid = 0;
        itemdata_id = 0;
        dict_itemdata = [[NSDictionary alloc] init];
        str_itemcaption = @"";
        str_itemview = @"";
        
        icon_URL = @"";
        tab_active_URL = @"";
        tab_URL = @"";
        viewname = @"";
        thumb_icon = [[UIImage alloc] init];
        thumb_tab = [[UIImage alloc] init];
        thumb_tab_active = [[UIImage alloc] init];
        
        iconpath = @"";
        tabpath = @"";
        tabActpath = @"";
	}
	return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getImageURL {
    return self.icon_URL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
    if([self.icon_URL isEqual:imageKey] && !thumb_icon) {
        self.thumb_icon = image;
    }
}

- (void)imageDownloadingError:(NSObject *)imageKey {
    if([self.icon_URL isEqual:imageKey]) {
        self.icon_URL = @"";
    }
}
@end
