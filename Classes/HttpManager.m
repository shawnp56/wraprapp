//
//  HttpManager.m
//  mm4mp
//
//  Created by Tailored Solutions on 13/04/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "HttpManager.h"


@implementation HttpManager

@synthesize delegate;
@synthesize theResponseData;

- (void)asynchronousRequestServerWithXMLPost:(NSString *)urlAddress PostData:(NSString *)postContent {
	urlAddress = [self encodeStringForURL:urlAddress];
	NSURL *theURL = [NSURL URLWithString:urlAddress];
	theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:120.0f];
	if([postContent length] > 0) {
		[theRequest setHTTPMethod:@"POST"];
	} else {
		[theRequest setHTTPMethod:@"GET"];
	}
	
	[theRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
	DLog(@"URL : %@", urlAddress);
	DLog(@"Content : %@", postContent);
	
	NSData *theBodyData = [postContent dataUsingEncoding:NSUTF8StringEncoding];
	[theRequest setHTTPBody:theBodyData];
	
	[theRequest retain];
	[NSThread detachNewThreadSelector:@selector(sendSyncRequest) toTarget:self withObject:nil];

}

- (void)asynchronousRequestServerWithDataPost:(NSString *)urlAddress PostData:(NSData *)postContent {

	urlAddress = [self encodeStringForURL:urlAddress];
	NSURL *theURL = [NSURL URLWithString:urlAddress];
	theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:120.0f];
    [theRequest setHTTPMethod:@"POST"];
	
	DLog(@"URL : %@", urlAddress);
	
	if(postContent)
	{
		[theRequest setHTTPBody:postContent];
	}
	
	[theRequest retain];
	
	[NSThread detachNewThreadSelector:@selector(sendSyncRequest) toTarget:self withObject:nil];
	
}

- (void)asynchronousRequestServerWithMultipartPost:(NSString *)urlAddress PostData:(NSData *)postContent Boundry:(NSString *)contentBoundry {
	urlAddress = [self encodeStringForURL:urlAddress];
	NSURL *theURL = [NSURL URLWithString:urlAddress];
	theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:180.0f];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest addValue:contentBoundry forHTTPHeaderField: @"Content-Type"];
	
	if(postContent)
	{
		[theRequest setHTTPBody:postContent];
	}
	
	[theRequest retain];
	
	[NSThread detachNewThreadSelector:@selector(sendSyncRequest) toTarget:self withObject:nil];	
}

- (void)sendSyncRequest {
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSURLResponse *theResponse = NULL;
	NSError *theError = NULL;
	    
	theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
	[NSURLConnection cancelPreviousPerformRequestsWithTarget:nil];
	
	NSString *theResponseString = [[[NSString alloc] initWithData:theResponseData encoding:NSUTF8StringEncoding] autorelease];
	DLog(@"Response : %@", theResponseString);
	if(theError) {
		[delegate connectionDidFail:self];
	} else {
		[delegate connectionDidFinish:self];
	}
	[pool release];
}

- (NSString *)encodeStringForURL:(NSString *)originalURL {
	NSMutableString *escaped = [[NSMutableString alloc] init];
	[escaped appendString:[originalURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];       
	return escaped;	
}

- (void)dealloc {
	[theRequest release];
	[super dealloc];
}

@end
