//
//  AppconfigThemedetail.m
//  iJoomer
//
//  Created by tailored on 3/20/13.
//
//

#import "AppconfigThemedetail.h"

@implementation AppconfigThemedetail

@synthesize icon_URL;
@synthesize tab_active_URL;
@synthesize tab_URL;

@synthesize thumb_icon;
@synthesize thumb_tab;
@synthesize thumb_tab_active;

@synthesize icon_imgpath;
@synthesize tab_active_imgpath;
@synthesize tab_imgpath;

@synthesize viewname;

-(id)init
{
    self = [super init];
	if(self)
    {
		icon_URL = @"";
        tab_active_URL = @"";
        tab_URL = @"";
        viewname = @"";
        
        thumb_icon = [[UIImage alloc] init];
        thumb_tab = [[UIImage alloc] init];
        thumb_tab_active = [[UIImage alloc] init];
        
        icon_imgpath = @"";
        tab_active_imgpath = @"";
        tab_imgpath = @"";
	}
	return self;
}

- (void)dealloc
{
    [super dealloc];
}


@end
