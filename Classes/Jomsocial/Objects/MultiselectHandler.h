//
//  multiselecthandle.h
//  iJoomer
//
//  Created by Tailored Solutions on 30/04/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UserInfo;
@class TableCellOwner;

@interface MultiselectHandler : UITableViewController <UITableViewDelegate,UITableViewDataSource>{

	NSArray *options;
	
}

@property(nonatomic, assign)NSArray *options;

@end
