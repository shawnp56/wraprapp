//
//  iCMSFeaturedListViewController.h
//  iJoomer
//
//  Created by Tailored Solutions on 4/8/13.
//
//

/*
 This controller list Featured articles.
 */

#import <UIKit/UIKit.h>
#import "RequestResponseManager.h"
#import "IconDownloader.h"
#import "PullRefreshTableView.h"
#import "GAITrackedViewController.h"
#import "ApplicationData.h"
#import "Reachability.h"

@class TableCellOwner;
@interface iCMSFeaturedListViewController : UIViewController  <RequestManagerDelegate,
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
    
    bool isViewWillDisAapear;
    
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
