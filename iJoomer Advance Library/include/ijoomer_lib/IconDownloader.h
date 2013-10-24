/*
     File: IconDownloader.h 
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIColor.h>
#import <UIKit/UIGeometry.h>


@class AppRecord;
@class TTURLCache;

@protocol IconDownloaderDelegate;
@protocol IconRecord;

@interface IconDownloader : NSObject
{
    id<IconRecord> appRecord;
    id <IconDownloaderDelegate> delegate;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
	NSObject *imageKey;
	
}

@property (nonatomic, retain) id <IconRecord> appRecord;
@property (nonatomic, assign) id <IconDownloaderDelegate> delegate;

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;
@property (nonatomic, retain) NSObject *imageKey;


- (void)startDownload;
- (void)cancelDownload;
- (NSString *)encodeStringForURL:(NSString *)originalURL;

@end

@protocol IconDownloaderDelegate 

- (void)appImageDidLoad:(NSObject *)imageKey;

@end

@protocol IconRecord 

- (NSString *)getImageURL;
- (void)imageDownloadingError:(NSObject *)imageKey;
- (void)setImage:(UIImage *)image ImageKey:(NSObject *)imageKey;
@end