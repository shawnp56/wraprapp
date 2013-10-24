//
//  Criteria.h
//  iJoomer
//
//  Created by Tailored Solutions on 05/02/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Criteria : NSObject {

	NSString *name;
	BOOL required;
	int rating;
}

@property(nonatomic,retain)NSString *name;
@property(assign)BOOL required;
@property(assign)int rating;

@end
