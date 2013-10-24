//
//  iCMSArticleDetailViewController.h
//  iJoomer
//
//  Created by Tailored Solutions on 4/10/13.
//
//

/*
 This controller will disply details of selected article.
 
 - (IBAction)FavoriteButtonPressed:(id)sender;
    
    By clicking Favorite button its fire above function and save the article details into loacl database.
 
 - (IBAction)ShareButtonPressed:(id)sender;
 
    By clicking Share button user will share the article link on Facebook,Twitter and user can also mail from contact list.
 */


#import "PullRefreshTableView.h"
#import "RequestResponseManager.h"
#import "IconDownloader.h"
#import "GAITrackedViewController.h"
#import "ApplicationData.h"

@class iCMSArticle;

@interface iCMSArticleDetailViewController : UIViewController <RequestManagerDelegate,
UITableViewDataSource,UITableViewDelegate, IconDownloaderDelegate,UIWebViewDelegate, UIScrollViewDelegate> {
    
    IBOutlet UIImageView *backImg;
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UITableView *tableView;
    IBOutlet UIView *headerView;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *lblDate;
    IBOutlet UILabel *lblCategoryName;
    IBOutlet UILabel *lblPageNo;
    IBOutlet UILabel *lblArticleTitle;
    IBOutlet UIImageView *articleBackimg;
    IBOutlet UIImageView *thumbImg;
    IBOutlet UIView *shareView;
    IBOutlet UILabel *lblAuthorName;
    IBOutlet UIButton *btnFavorite;
    IBOutlet UIButton *btnShare;
    IBOutlet UIWebView *descWeb;
    
    HTTPRequest currentRequestType;
    int pageNo;
    NSMutableDictionary *imageDownloadsInProgress;
	NSMutableDictionary *multipleDownloadRecord;
    NSTimer *timer;
    
    int currentPageNo;
    int totalPages;
    BOOL isSingleArticle;
    
    NSMutableArray *articleList;
    
    iCMSArticle *articleDetail;
    
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
    
    
    IBOutlet UIView *externalView;
    IBOutlet UIWebView *externalWebView;
    
    bool isViewWillDisAapear;
    BOOL isTabbarHidden;

}

@property BOOL isSingleArticle;
@property (nonatomic,retain) iCMSArticle *articleDetail;
@property (nonatomic,assign) int currentPageNo;
@property (nonatomic,assign) int totalPages;
@property (nonatomic,retain) NSMutableArray *articleList;


- (IBAction)FavoriteButtonPressed:(id)sender;
- (IBAction)ShareButtonPressed:(id)sender;


- (void)showAlert:(NSString *)title Content:(NSString *)bodyText;

@end
