//
//  ImageUploader.h
//  JeddahFood
//
//  Created by Tailored Solutions on 16/02/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "HttpManager.h"

@class AppRecord;

@protocol ImageUploaderDelegate;

@interface ImageUploader : NSObject
{
    id <ImageUploaderDelegate> delegate;
	
	HttpManager *httpManager;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
	NSMutableURLRequest *theRequest;
	
	UIProgressView *progressView;
}

@property(nonatomic, retain)HttpManager *httpManager;
@property (nonatomic, assign) id <ImageUploaderDelegate> delegate;
@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;
@property (nonatomic, retain) UIProgressView *progressView;

- (void)startUpload:(NSString *)urlAddress PostData:(NSData *)postContent Boundry:(NSString *)contentBoundry;
- (void)cancelUpload;

@end

@protocol ImageUploaderDelegate 

- (void)appImageDidUpload;

@end
