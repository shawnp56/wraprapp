//
//  FindFirstResponder.m
//  iJoomer
//
//  Created by Tailored Solutions on 28/04/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "FindFirstResponder.h"

@implementation UIView (firstResponder)

- (UIView *)findFirstResponder
{
	if ([self isFirstResponder]) {
		return self;
	}
	
	for (UIView *subview in [self subviews]) {
		UIView *firstResponder = [subview findFirstResponder];
		if (nil != firstResponder) {
			return firstResponder;
		}
	}
	
	return nil;
}


@end
