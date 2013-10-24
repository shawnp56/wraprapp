//
//  RequestResponseManager.h
//  mm4mp
//
//  Created by Tailored Solutions on 13/04/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"
#import "AppConstantsList.h"
#import "MREntitiesConverter.h"

@protocol RequestManagerDelegate

-(void)requestCompleted;

@end

@interface RequestResponseManager : NSObject<HTTPManagerDelegate> {

	HttpManager *httpManager;
	HTTPRequest requestType;
	
	// Objects required for forming request or parsing response
	NSMutableArray *extraInfoObjectArray;

	// RequestManagerDelegate objects
	NSMutableArray *delegateArray;
}

@property(nonatomic, retain)HttpManager *httpManager;

+(RequestResponseManager*)sharedInstance;

-(void)initialize;
-(void)setRequestPropery:(id<RequestManagerDelegate>)delegate ExtraInfo:(NSObject *)infoObject;
-(void)removeRequestProperty:(id<RequestManagerDelegate>)delegate ExtraInfo:(NSObject *)infoObject;

-(void)sendGetHttpRequest:(NSString *)requestURL RequestType:(HTTPRequest)request;
-(void)sendPostHttpRequest:(NSString *)requestURL RequestType:(HTTPRequest)request PostContent:(NSString *)xmlContent ;
-(void)sendPostHttpMultipartRequest:(NSString *)requestURL RequestType:(HTTPRequest)request PostContent:(NSData *)content Boundry:(NSString *)contentBoundry;
-(void)cancleRequest;

@end
