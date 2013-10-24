//
//  Directory.h
//  iJoomer
//
//  Created by Tailored Solutions on 07/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Directory : NSObject {

	NSInteger directoryId;
	NSString *directoryName;
	NSMutableArray *section;
}

@property (nonatomic, readwrite) NSInteger directoryId;
@property (nonatomic, retain) NSString *directoryName;
@property (nonatomic, retain) NSMutableArray *section;

@end
