//
//  ImageUploader.m
//  JeddahFood
//
//  Created by Tailored Solutions on 16/02/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "ImageUploader.h"
#import "ParseManager.h"
#import "ApplicationData.h"

@implementation ImageUploader

@synthesize delegate;
@synthesize activeDownload;
@synthesize imageConnection;
@synthesize progressView;
@synthesize httpManager;

#pragma mark

- (void)dealloc
{
	[progressView release];
    [activeDownload release];
    [imageConnection cancel];
    [imageConnection release];
	
    [super dealloc];
}

- (void)startUpload:(NSString *)urlAddress PostData:(NSData *)postContent Boundry:(NSString *)contentBoundry
{
	
    self.activeDownload = [NSMutableData data];
	
    // alloc+init and start an NSURLConnection; release on completion/failure

	NSURL *theURL = [NSURL URLWithString:urlAddress];
	theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest addValue:contentBoundry forHTTPHeaderField: @"Content-Type"];
	
	if(postContent)
	{
		[theRequest setHTTPBody:postContent];
	}
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    self.imageConnection = conn;
    [conn release];
}

- (void)cancelUpload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
	self.delegate = nil;
	
}


#pragma mark -
#pragma mark upload support (NSURLConnectionDelegate)

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	// Clear the activeDownload property to allow later attempts
    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
	
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
	float progress = [[NSNumber numberWithInteger:totalBytesWritten] floatValue];
	float total = [[NSNumber numberWithInteger: totalBytesExpectedToWrite] floatValue];
	
	progressView.progress = progress/total;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
	
//	NSString *xmlContent = [[NSString alloc] initWithData:self.activeDownload encoding:NSASCIIStringEncoding];

	if(self.delegate) {
		// call our delegate and tell it that our icon is ready for display
		[delegate appImageDidUpload];
	}
}

@end
