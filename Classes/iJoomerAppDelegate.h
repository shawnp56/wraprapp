//
//  iJoomerAppDelegate.h
//  iJoomer
//

#import "RequestResponseManager.h"
#import "IconDownloader.h"
#import "GAI.h"

@class MoreViewController,TableCellOwner,Tab;
@class RevealController;


@interface iJoomerAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate> {
    UIWindow *window;
	NSInteger userid;
	MoreViewController *moreviewcontroller;

	// More View
	UIView *moreView;
	IBOutlet UIImageView *backImg;	
	IBOutlet UIButton *btn_Poll;
	IBOutlet UIButton *btn_setting;
	
	NSString *deviceToken;
	NSString *deviceAlias;
    
	UITabBarController *customTabController;
    
    NSMutableDictionary *imageDownloadsInProgress;
    IBOutlet UIImageView *imgView;
    IBOutlet UIView *viewTop;
    NSTimeInterval timerStartTime;
    NSTimer *timer;
    IBOutlet UIView *splaceView;
    IBOutlet UIImageView *imgdefault;
    IBOutlet UIImageView *splaceImgView;
    IBOutlet UIButton *btnClose;
    
    IBOutlet UIButton *btnFrndReq;
    IBOutlet UIButton *btnMessage;
    IBOutlet UIButton *btnGroup;
    
    IBOutlet UIButton *btnFriendCount;
    IBOutlet UIButton *btnMsgCount;
    IBOutlet UIButton *btnGroupCount;
    
    IBOutlet UIButton *btnSlideMenu;
        IBOutlet UIView *backSideMenuView;
    
    IBOutlet UIView *notifView;
	HTTPRequest currentRequestType;
    
    TableCellOwner *cellOwner;
    UIViewController *SelfViewcontroller;
}
@property(nonatomic, strong)UIViewController *SelfViewcontroller;

@property(nonatomic, strong)UINavigationController *navigationController;

//////Tabmenu.

@property(nonatomic, strong)IBOutlet UIView *TabView;
@property(nonatomic, strong)IBOutlet UIImageView *ImgTabBg;
@property(nonatomic, strong)IBOutlet UIButton* BtnTab;
@property(nonatomic, strong)IBOutlet UIButton* BtnTab1;
@property(nonatomic, strong)IBOutlet UIButton* BtnTab2;
@property(nonatomic, strong)IBOutlet UIButton* BtnTab3;
@property(nonatomic, strong)IBOutlet UIButton* BtnTab4;

@property(nonatomic, strong)IBOutlet UILabel* LblTab;
@property(nonatomic, strong)IBOutlet UILabel* LblTab1;
@property(nonatomic, strong)IBOutlet UILabel* LblTab2;
@property(nonatomic, strong)IBOutlet UILabel* LblTab3;
@property(nonatomic, strong)IBOutlet UILabel* LblTab4;

@property(nonatomic, strong)IBOutlet UITableView *TblMoreview;
@property(nonatomic, strong)IBOutlet UITableView *TblSideMenu;
@property (nonatomic, retain) IBOutlet UIButton *BtnSideMenu;
//////////////

@property (assign)BOOL sidemenuflag;

@property(nonatomic, retain) id<GAITracker> tracker;

@property (nonatomic, retain) UITabBarController *customTabController;
@property (nonatomic, readwrite) NSInteger userid;

@property (nonatomic, retain) IBOutlet UIView *viewTop;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIView *moreView;
@property (nonatomic, retain) NSString *deviceToken;
@property (nonatomic, retain) NSString *deviceAlias;

@property (nonatomic, retain) IBOutlet UIButton *btnFrndReq;
@property (nonatomic, retain) IBOutlet UIButton *btnMessage;
@property (nonatomic, retain) IBOutlet UIButton *btnGroup;
@property (nonatomic, retain) IBOutlet UIButton *btnFriendCount;
@property (nonatomic, retain) IBOutlet UIButton *btnMsgCount;
@property (nonatomic, retain) IBOutlet UIButton *btnGroupCount;

@property (nonatomic, retain) IBOutlet UIButton *btnSlideMenu;
@property (nonatomic, retain) IBOutlet UIView *backSideMenuView;
@property (nonatomic, retain) IBOutlet UIView *notifView;
@property(nonatomic, retain)NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, retain)IBOutlet UIView *footerView;
@property (nonatomic, retain)IBOutlet UIButton *btnLogout;

- (NSMutableArray *)fetchTabList :(NSString *)screenname;
- (NSMutableArray *)fetchHomeList;
- (NSMutableArray *)fetchsidemenuList:(NSString *)screenname;
- (void)showWindow;
- (BOOL)fetchConfig;
- (void) setUserData;

////TabButton IBAction.
- (IBAction)TabMenuPressed:(id)sender;
- (IBAction)TabMenuPressed1:(id)sender;
-(void)TabReset;
////TabButton IBAction.

-(void)Alert;

- (IBAction)SideMenuPressed:(id)sender;
- (void)wasDragged:(UIButton *)button withEvent:(UIEvent *)event;
-(void)TabbarHide;

@end
