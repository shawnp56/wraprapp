//
//  iCMSFavouriteArticlesViewController.h
//  iJoomer
//
//  Created by tailored on 4/11/13.
//
//

#import "PullRefreshTableView.h"
#import "GAITrackedViewController.h"
#import "IconDownloader.h"
#import "ApplicationData.h"

@class TableCellOwner;

@interface iCMSFavouriteArticlesViewController : UIViewController <UIScrollViewDelegate,IconDownloaderDelegate>{

    
    IBOutlet UIImageView *backImg;
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UITableView *tableView;
    TableCellOwner *cellOwner;
    
    bool isViewWillDisAapear;
    
    NSMutableDictionary *imageDownloadsInProgress;
    NSMutableDictionary *multipleDownloadRecord;
    
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

@end
