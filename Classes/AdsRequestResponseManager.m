//
//  AdsRequestResponseManager.m
//  iJoomer
//
//  Created by Pratik Mehta on 16/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdsRequestResponseManager.h"
#import "Adsparser.h"
#import "Banner.h"
#import "HttpManager.h"

static AdsRequestResponseManager *adsrequestResponseManager = nil;

@implementation AdsRequestResponseManager

@synthesize httpManager;

+ (AdsRequestResponseManager *)sharedInstance {
    if (adsrequestResponseManager == nil) {
        adsrequestResponseManager = [[super allocWithZone:NULL] init];
		[adsrequestResponseManager initialize];
    }
    return adsrequestResponseManager;
}

- (void)initialize {
	HttpManager *manager = [[HttpManager alloc] init];
	httpManager = manager;
	delegateArray = [[NSMutableArray alloc] init];
	extraInfoObjectArray = [[NSMutableArray alloc] init];
}

- (void)setRequestPropery:(id<adsRequestManagerDelegate>)delegate ExtraInfo:(NSObject *)infoObject {
	if(delegate) {
		[delegateArray addObject:delegate];
	}
	if(infoObject) {
		[extraInfoObjectArray addObject:infoObject];
	}
}

- (void)removeRequestProperty:(id<adsRequestManagerDelegate>)delegate ExtraInfo:(NSObject *)infoObject {
	if(delegate) {
		[delegateArray removeObject:delegate];
	}
	if(infoObject) {
		[extraInfoObjectArray removeObject:infoObject];
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////// Sending Request methods /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)sendGetHttpRequest:(NSString *)requestURL RequestType:(adsHTTPRequest)request {
	httpManager.delegate = self;
	requestType = request;
	[httpManager asynchronousRequestServerWithXMLPost:requestURL PostData:NULL_STRING];
}

- (void)sendPostHttpRequest:(NSString *)requestURL RequestType:(adsHTTPRequest)request PostContent:(NSString *)xmlContent {
	
	httpManager.delegate = self;
	requestType = request;
	[httpManager asynchronousRequestServerWithXMLPost:requestURL PostData:xmlContent];
}

- (void)sendPostHttpMultipartRequest:(NSString *)requestURL RequestType:(adsHTTPRequest)request PostContent:(NSData *)content Boundry:(NSString *)contentBoundry {
	httpManager.delegate = self;
	requestType = request;
	[httpManager asynchronousRequestServerWithMultipartPost:requestURL PostData:content Boundry:contentBoundry];
}

- (void)cancleRequest {
	httpManager.delegate = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////  response parsing methods /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


- (void)handleAdsResponse {
	NSString *xmlContent = [[NSString alloc] initWithData:httpManager.theResponseData encoding:NSUTF8StringEncoding];
	[Adsparser parseAdvertisementContent:xmlContent];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


- (void)connectionDidFail:(HttpManager *)theConnection {	
	[Banner sharedInstance].errorCode = adsNetworkError;
	if([delegateArray count] > 0) {
		id<adsRequestManagerDelegate> delegate = [delegateArray objectAtIndex:0];
		[delegate requestCompleted];
		[delegateArray removeObjectAtIndex:0];
		if([extraInfoObjectArray count] > 0) {
			[extraInfoObjectArray removeObjectAtIndex:0];
		}
	}
}

- (void)connectionDidFinish:(HttpManager *)theConnection {
	switch (requestType) {
		case AdsQuery:
			[self handleAdsResponse];
			break;
		default:
			break;
	}
	if([delegateArray count] > 0) {
		id<adsRequestManagerDelegate> delegate = [delegateArray objectAtIndex:0];
		[delegate requestCompleted];
		[delegateArray removeObjectAtIndex:0];
	}
}

@end
