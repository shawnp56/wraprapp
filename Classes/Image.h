//
//  Image.h
//  iJoomer
//
//  Created by Tailored Solutions on 25/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"


@interface Image : NSObject<IconRecord> {

	NSString *imgURL;
	UIImage *imgSource;
	NSString *bigImgURL;

}

@property (nonatomic, retain) NSString *imgURL;
@property (nonatomic, retain) UIImage *imgSource;
@property (nonatomic, retain) NSString *bigImgURL;
@end
