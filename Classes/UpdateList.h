//
//  UpdateList.h
//  iJoomer
//
//  Created by Harshal Kothari on 01/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UpdateList : NSObject {

	NSString *updateTitle;
	NSString *updateDate;
	NSString *updateTime;
	NSInteger updateID;
	
}

@property (nonatomic, retain) NSString *updateTitle;
@property (nonatomic, retain) NSString *updateDate;
@property (nonatomic, retain) NSString *updateTime;
@property (nonatomic, readwrite) NSInteger updateID;

@end
