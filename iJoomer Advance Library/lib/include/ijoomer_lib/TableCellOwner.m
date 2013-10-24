//
//  TableCellOwner.m
//  iJoomer
//
//  Created by Tailored Solutions on 21/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "TableCellOwner.h"


@implementation TableCellOwner

@synthesize cell;

- (BOOL)loadMyNibFile:(NSString *)nibName {
    // The myNib file must be in the bundle that defines self's class.
    if ([[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] == nil)
    {
        return NO;
    }	
    return YES;
}

@end
