//
//  videocategories.m
//  iJoomer
//
//  Created by tailored on 3/20/13.
//
//

#import "videocategories.h"

@implementation videocategories

@synthesize arrvideos_categories;
@synthesize code;
@synthesize Id;
@synthesize strdesc;
@synthesize strname;
@synthesize count;
-(id)init
{
    self = [super init];
	if(self)
    {
		arrvideos_categories = [[NSMutableArray alloc] init];
        code = 0;
        count = 0;
        Id = 0;
        strname = @"";
        strdesc = @"";
	}
	return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
