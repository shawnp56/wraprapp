//
//  RequestManager.h
//  iJoomer
//
//  Created by Tailored Solutions on 30/03/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"
#import "AppConstantsList.h"


@protocol RequestDelegate

-(void)requestCompleted;

@end

@interface RequestManager : NSObject<HTTPManagerDelegate> {
	
	HttpManager *httpManager;
	HTTPRequest requestType;
	
	// Objects required for forming request or parsing response
	NSMutableArray *extraInfoObjectArray;
	
	// RequestManagerDelegate objects
	NSMutableArray *delegateArray;
}

@property(nonatomic, retain)HttpManager *httpManager;

+(RequestManager*)sharedInstance;

-(void)initialize;
-(void)setRequestPropery:(id<RequestDelegate>)delegate ExtraInfo:(NSObject *)infoObject;
-(void)removeRequestProperty:(id<RequestDelegate>)delegate ExtraInfo:(NSObject *)infoObject;

-(void)sendGetHttpRequest:(NSString *)requestURL RequestType:(HTTPRequest)request;
-(void)sendPostHttpRequest:(NSString *)requestURL RequestType:(HTTPRequest)request PostContent:(NSString *)xmlContent ;
-(void)sendPostHttpMultipartRequest:(NSString *)requestURL RequestType:(HTTPRequest)request PostContent:(NSData *)content Boundry:(NSString *)contentBoundry;
-(void)cancleRequest;

@end
