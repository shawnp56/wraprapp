//
//  TableCellOwner.h
//  iJoomer
//
//  Created by Tailored Solutions on 21/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TableCellOwner : UITableViewCell {
	UITableViewCell *cell;
}

@property (nonatomic, retain) IBOutlet UITableViewCell *cell;

- (BOOL)loadMyNibFile:(NSString *)nibName;

@end
