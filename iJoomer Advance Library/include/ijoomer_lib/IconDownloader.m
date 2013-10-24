/*
     File: IconDownloader.m 
 */

#import "IconDownloader.h"


#define kAppIconHeight 48
#define CACHE_ICON @"cache_icons"

@implementation IconDownloader

@synthesize appRecord;
@synthesize delegate;
@synthesize activeDownload;
@synthesize imageConnection;
@synthesize imageKey;

#pragma mark

- (void)dealloc
{
    if (activeDownload) {
        [activeDownload release];
    }
    if (imageConnection) {
        [imageConnection cancel];  
    }
    if (imageConnection) {
        [imageConnection release];
    }
    if (imageKey) {
        [imageKey release];  
    }
    [super dealloc];
}

- (void)startDownload
{	
    self.activeDownload = [NSMutableData data];
    NSString *encodeURL = [self encodeStringForURL:(NSString *)imageKey];
	NSURLConnection *conn;
	if([imageKey isKindOfClass:[NSString class]]) {
		// alloc+init and start an NSURLConnection; release on completion/failure
		conn = [[NSURLConnection alloc] initWithRequest:
                             [NSURLRequest requestWithURL:
                              [NSURL URLWithString:(NSString *)encodeURL]] delegate:self];
	} else {
		// alloc+init and start an NSURLConnection; release on completion/failure
		conn = [[NSURLConnection alloc] initWithRequest:
				[NSURLRequest requestWithURL:
				 [NSURL URLWithString:[self encodeStringForURL:[appRecord getImageURL]]]] delegate:self];
	}
    self.imageConnection = conn;
	[self.imageConnection start];
	[conn release];
}

- (void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
	self.delegate = nil;
	self.appRecord = nil;
}


#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)

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
	[appRecord imageDownloadingError:imageKey];
	[delegate appImageDidLoad:imageKey];
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Set appIcon and clear temporary data/image
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
    
    //if (image && image.size.width > 0 && image.size.height > 0) {
		// Image downloaded successfully
		if(self.appRecord) {
			[appRecord setImage:image ImageKey:imageKey];
		}
   // } else {
		//[appRecord imageDownloadingError:imageKey];
	//}

    
    self.activeDownload = nil;
    [image release];
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
	
	if(self.delegate) {
		// call our delegate and tell it that our icon is ready for display
		[delegate appImageDidLoad:imageKey];
        
	}
}


- (NSString *)encodeStringForURL:(NSString *)originalURL {
	NSMutableString *escaped = [[NSMutableString alloc] init];
	[escaped appendString:[originalURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	return escaped;
}

@end

