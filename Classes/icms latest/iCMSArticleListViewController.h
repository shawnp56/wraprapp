//
//  iCMSArticleListViewController.h
//  iJoomer
//
//  Created by Tailored Solutions on 3/20/13.
//
//
/*
    This controller listing All category and articles. 
 
 */
#import <UIKit/UIKit.h>
#import "RequestResponseManager.h"
#import "IconDownloader.h"
#import "PullRefreshTableView.h"
#import "GAITrackedViewController.h"

#import "ApplicationData.h"

@class TableCellOwner,iCMSArticle,iCMSCategory;

@interface iCMSArticleListViewController : UIViewController <RequestManagerDelegate,
UITableViewDataSource,UITableViewDelegate, IconDownloaderDelegate,UIScrollViewDelegate> {

    IBOutlet UIImageView *backImg;
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UITableView *tableView;
    
    TableCellOwner *cellOwner;
    HTTPRequest currentRequestType;
    
    int pageNo;
    int categorySection;
    int articleSection;
    int catid;
    
    iCMSCategory *category;
    iCMSArticle *article;
    
    BOOL isCategory;
    BOOL isSingleCategory;
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
    
    bool isViewWillDisAapear;
    BOOL isTabbarHidden;
}

//property
@property (nonatomic,assign) int catid;
@property BOOL isSingleCategory;
@property (nonatomic,assign) iCMSCategory *category;
@property (nonatomic,assign) iCMSArticle *article;

- (void)startIconDownload1:(iCMSArticle *)appRecord;

- (void)showAlert:(NSString *)title Content:(NSString *)bodyText;


@end
