//
//  AllMenudetail.m
//  iJoomer
//
//  Created by tailored on 3/20/13.
//
//

#import "AllMenudetail.h"

@implementation AllMenudetail

@synthesize arrmenuitem;
@synthesize arrMenuscreens;
@synthesize menuid;
@synthesize menuname;
@synthesize menuposition;

-(id)init
{
    self = [super init];
	if(self)
    {
		arrmenuitem = [[NSMutableArray alloc] init];
        arrMenuscreens = [[NSMutableArray alloc] init];
        menuid = 0;
        menuposition = 0;
        menuname = @"";
	}
	return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
