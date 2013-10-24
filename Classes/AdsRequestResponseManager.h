//
//  AdsRequestResponseManager.h
//  iJoomer
//
//  Created by Pratik Mehta on 16/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"
#import "AdsAppConstant.h"

@protocol adsRequestManagerDelegate
	-(void)requestCompleted;
@end

@interface AdsRequestResponseManager : NSObject<HTTPManagerDelegate> {

	HttpManager *httpManager;
	adsHTTPRequest requestType;
	// Objects required for forming request or parsing response
	NSMutableArray *extraInfoObjectArray;
	// RequestManagerDelegate objects
	NSMutableArray *delegateArray;
}

@property(nonatomic, retain)HttpManager *httpManager;

+(AdsRequestResponseManager *)sharedInstance;

- (void) initialize;
- (void) setRequestPropery:(id<adsRequestManagerDelegate>)delegate ExtraInfo:(NSObject *)infoObject;
- (void) removeRequestProperty:(id<adsRequestManagerDelegate>)delegate ExtraInfo:(NSObject *)infoObject;
- (void) sendGetHttpRequest:(NSString *)requestURL RequestType:(adsHTTPRequest)request;
- (void) sendPostHttpRequest:(NSString *)requestURL RequestType:(adsHTTPRequest)request PostContent:(NSString *)xmlContent ;
- (void) sendPostHttpMultipartRequest:(NSString *)requestURL RequestType:(adsHTTPRequest)request PostContent:(NSData *)content Boundry:(NSString *)contentBoundry;
- (void) cancleRequest; 
- (void) handleAdsResponse;

@end