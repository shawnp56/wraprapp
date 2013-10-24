//
//  UpdateTimeList.h
//  iJoomer
//
//  Created by Tailored Solutions on 01/05/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ActivityHeader : NSObject {

	NSString *time;
	NSMutableArray *updates;
}

@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSMutableArray *updates;

@end
