//
//  PhotoList.h
//  iJoomer
//
//  Created by Tailored Solutions on 30/04/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"

@protocol PhotoStatusHandler

-(void)imageDownloaded:(NSInteger)photoID DownloadedImage:(UIImage *)newImage;

@end


@interface Photo : NSObject<IconRecord> {

	NSInteger photoID;
	NSString *photoURL;
	UIImage *photoImg;
    NSString *thumbURL;
	UIImage *thumbImg;
	UIImage *tempImg;
	BOOL downloaded;
	BOOL downloading;
    NSString *name;
    NSMutableArray *commentList;
    NSString *shareLink;
    int likeCount;
    int commentCount;
    int dislikeCount;
    BOOL isLiked;
    BOOL isDisliked;
	id<PhotoStatusHandler> delegate;
}
@property(nonatomic, readwrite) BOOL isLiked;
@property(nonatomic, readwrite) BOOL isDisliked;
@property (nonatomic, readwrite) NSInteger photoID;
@property (nonatomic, retain) NSString *photoURL;
@property (nonatomic, retain) UIImage *photoImg;
@property (nonatomic, retain) NSString *thumbURL;
@property (nonatomic, retain) UIImage *thumbImg;
@property (nonatomic, retain) UIImage *tempImg;
@property (nonatomic, readwrite) BOOL downloaded;
@property (nonatomic, readwrite) BOOL downloading;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *commentList;
@property (nonatomic, retain) NSString *shareLink;
@property (nonatomic, readwrite) int likeCount;
@property (nonatomic, readwrite) int commentCount;
@property (nonatomic, readwrite) int dislikeCount;
@property (nonatomic, assign) id<PhotoStatusHandler> delegate;


@end
