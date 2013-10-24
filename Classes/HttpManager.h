//
//  HttpManager.h
//  mm4mp
//
//  Created by Tailored Solutions on 13/04/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTPManagerDelegate;

@interface HttpManager : NSObject {
	NSMutableURLRequest *theRequest;
	NSData *theResponseData;
	id<HTTPManagerDelegate> delegate;
}

@property (nonatomic, assign)id<HTTPManagerDelegate> delegate;
@property (nonatomic, assign)NSData *theResponseData;

-(void)asynchronousRequestServerWithXMLPost:(NSString *)urlAddress PostData:(NSString *)postContent;
-(void)asynchronousRequestServerWithDataPost:(NSString *)urlAddress PostData:(NSData *)postContent;
-(void)asynchronousRequestServerWithMultipartPost:(NSString *)urlAddress PostData:(NSData *)postContent Boundry:(NSString *)contentBoundry;
-(void)sendSyncRequest;

-(NSString *)encodeStringForURL:(NSString *)originalURL;

@end

@protocol HTTPManagerDelegate

- (void) connectionDidFail:(HttpManager *)theConnection;
- (void) connectionDidFinish:(HttpManager *)theConnection;

@end

