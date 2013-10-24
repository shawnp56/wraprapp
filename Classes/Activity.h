//
//  Activity.h
//  iJoomer
//
//  Created by Tailored Solutions on 01/05/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Activity : NSObject {

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
