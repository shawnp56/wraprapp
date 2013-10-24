//
//  iCMSArchivedListViewController.h
//  iJoomer
//
//  Created by Tailored Solutions on 4/9/13.
//
//
/*
 This controller list Archived articles.
 */

#import "PullRefreshTableView.h"
#import "RequestResponseManager.h"
#import "IconDownloader.h"
#import "GAITrackedViewController.h"
#import "ApplicationData.h"

@class TableCellOwner;

@interface iCMSArchivedListViewController : UIViewController <RequestManagerDelegate,
UITableViewDataSource,UITableViewDelegate, IconDownloaderDelegate, UIScrollViewDelegate> {
    
    IBOutlet UIImageView *backImg;
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UITableView *tableView;
    
    TableCellOwner *cellOwner;
    HTTPRequest currentRequestType;
    
    int pageNo;
    NSMutableDictionary *imageDownloadsInProgress;
	NSMutableDictionary *multipleDownloadRecord;
    
    NSTimer *timer;
    
    // pull down to refresh//
    UIView *refreshHeaderView;
    UILabel *refreshLabel;
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
    UITableView *pullTable;
    BOOL isDragging;
    BOOL isLoading;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;

    BOOL isTabbarHidden;
}

- (void)showAlert:(NSString *)title Content:(NSString *)bodyText;

@end
