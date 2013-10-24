//
//  EventOption.h
//  iJoomer
//
//  Created by Tailored Solutions on 11/08/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"

@interface EventOption : NSObject <IconRecord>{
	
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *value;
@property (nonatomic, retain) NSString *imgURL;
@property (nonatomic, retain) UIImage *imgSource;

@end
