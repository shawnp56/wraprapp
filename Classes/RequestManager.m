//
//  RequestManager.m
//  iJoomer
//
//  Created by Tailored Solutions on 30/03/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "RequestManager.h"
#import "ApplicationData.h"
#import "ParseManager.h"

static RequestManager *requestResponseManager = nil;

@implementation RequestManager

@synthesize httpManager;

+ (RequestManager*)sharedInstance {
	
    if (requestResponseManager == nil) {
        requestResponseManager = [[super allocWithZone:NULL] init];
		[requestResponseManager initialize];
    }
	
    return requestResponseManager;
}

- (void)initialize {
	HttpManager *manager = [[HttpManager alloc] init];
	httpManager = manager;
	
	delegateArray = [[NSMutableArray alloc] init];
	extraInfoObjectArray = [[NSMutableArray alloc] init];
	
}

+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedInstance] retain];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}

//- (void)release {
//    //do nothing
//}

- (id)autorelease {
    return self;
}

- (void)dealloc {
	[super dealloc];
}

- (void)setRequestPropery:(id<RequestDelegate>)delegate ExtraInfo:(NSObject *)infoObject {
	if(delegate) {
		[delegateArray addObject:delegate];
	}
	if(infoObject) {
		[extraInfoObjectArray addObject:infoObject];
	}
}

- (void)removeRequestProperty:(id<RequestDelegate>)delegate ExtraInfo:(NSObject *)infoObject {
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

- (void)sendGetHttpRequest:(NSString *)requestURL RequestType:(HTTPRequest)request {
	httpManager.delegate = self;
	requestType = request;
//	[httpManager asynchronousRequestServerWithXMLPost:requestURL PostData:NULL_STRING];
}

- (void)sendPostHttpRequest:(NSString *)requestURL RequestType:(HTTPRequest)request PostContent:(NSString *)xmlContent {
	httpManager.delegate = self;
	requestType = request;
	[httpManager asynchronousRequestServerWithXMLPost:requestURL PostData:xmlContent];
}

- (void)sendPostHttpMultipartRequest:(NSString *)requestURL RequestType:(HTTPRequest)request PostContent:(NSData *)content Boundry:(NSString *)contentBoundry {
	httpManager.delegate = self;
	requestType = request;
	[httpManager asynchronousRequestServerWithMultipartPost:requestURL PostData:content Boundry:contentBoundry];
}

- (void)cancleRequest {
	httpManager.delegate = nil;
}




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// HTTPManagerDelegate protocol methods ////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)connectionDidFail:(HttpManager *)theConnection {	
	
	[ApplicationData sharedInstance].errorCode = jBadRequest;
	
	if([delegateArray count] > 0) {
		id<RequestDelegate> delegate = [delegateArray objectAtIndex:0];
		[delegate requestCompleted];
		[delegateArray removeObjectAtIndex:0];
		
		if([extraInfoObjectArray count] > 0) {
			[extraInfoObjectArray removeObjectAtIndex:0];
		}
	}
}

- (void)connectionDidFinish:(HttpManager *)theConnection {
	
	switch (requestType) {
		
		default:
			break;
	}
	
	if([delegateArray count] > 0) {
		id<RequestDelegate> delegate = [delegateArray objectAtIndex:0];
		[delegate requestCompleted];
		[delegateArray removeObjectAtIndex:0];
	}
}

@end