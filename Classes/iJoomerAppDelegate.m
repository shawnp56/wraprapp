//
//  iJoomerAppDelegate.m
//  iJoomer
//

#import "iJoomerAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "ApplicationData.h"
#import "TableCellOwner.h"
#import "More.h"
#import "MoreViewController.h"
#import "Tab.h"
#import "GlobalObjects.h"
#import "AllMenudetail.h"
#import "ApplicationMenuItem.h"
#import "AppconfigThemedetail.h"
#import "GAI.h"
#import "iCMSApplicationData.h"
#import "iCMSArticleDetailViewController.h"
#import "iCMSArticleListViewController.h"
#import "iCMSCategory.h"
#import "iCMSFeaturedListViewController.h"
#import "JoomlaRegistration.h"

/******* Set your tracking ID here *******/
static NSString *const kTrackingId = @"UA-17515219-2";

@implementation iJoomerAppDelegate

@synthesize navigationController;
@synthesize sidemenuflag;
@synthesize SelfViewcontroller;

///TabMenu.
@synthesize TabView;
@synthesize ImgTabBg;
@synthesize BtnTab;
@synthesize BtnTab1;
@synthesize BtnTab2;
@synthesize BtnTab3;
@synthesize BtnTab4;

@synthesize LblTab;
@synthesize LblTab1;
@synthesize LblTab2;
@synthesize LblTab3;
@synthesize LblTab4;


@synthesize TblMoreview;
@synthesize TblSideMenu;
@synthesize BtnSideMenu;


@synthesize tracker = tracker_;
@synthesize viewTop;
@synthesize userid;
@synthesize moreView;
@synthesize deviceToken;
@synthesize deviceAlias;
@synthesize customTabController;
@synthesize imageDownloadsInProgress;

@synthesize btnFrndReq;
@synthesize btnMessage;
@synthesize btnGroup;

@synthesize btnFriendCount;
@synthesize btnMsgCount;
@synthesize btnGroupCount;

@synthesize btnSlideMenu;
@synthesize backSideMenuView;

@synthesize notifView;

@synthesize window = _window;
@synthesize footerView,btnLogout;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    BOOL tmp = [self fetchConfig];
    DLog(@"tmptmptmp: %d",tmp);
    
    // SelfViewcontroller = [[UIViewController alloc] init];
    //    NSMutableArray *arr = [[NSMutableArray alloc] init];
    //
    //    arr = [self fetchHomeList];
    //    arr = [self fetchTabList:@"Home"];
    //    arr = [self fetchsidemenuList:@"Home"];
    
    self.deviceToken = @"";
//    [GAI sharedInstance].debug = YES;
//    [GAI sharedInstance].dispatchInterval = 10;
//    [GAI sharedInstance].trackUncaughtExceptions = YES;
//    self.tracker = [[GAI sharedInstance] trackerWithTrackingId:kTrackingId];
    
    customTabController = [[UITabBarController alloc] init];
    
    [[ApplicationData sharedInstance] changeTheme];
    [[iCMSApplicationData sharedInstance] changeTheme];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window = _window;
	
	moreviewcontroller = [[MoreViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:moreviewcontroller];
    
    self.SelfViewcontroller = moreviewcontroller;
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:[iCMSApplicationData sharedInstance].navBarImg] forBarMetrics:UIBarMetricsDefault];
    
    //tabbar BG image set.
    [self.ImgTabBg setImage:[UIImage imageNamed:[iCMSApplicationData sharedInstance].tabBarImg]];
    
    self.customTabController.delegate = self;
    
    
    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];
    
    [self performSelectorOnMainThread:@selector(showWindow) withObject:nil waitUntilDone:YES];
	return YES;
}


-(void)showWindow {
    [TblSideMenu setTableFooterView:footerView];
//    [footerView setBackgroundColor:[iCMSApplicationData sharedInstance].moreCellBackColor];
    [btnLogout setBackgroundColor:[iCMSApplicationData sharedInstance].moreCellBackColor];
    [self.window addSubview:self.viewTop];
    [self.window addSubview:self.TblMoreview];
    [self.window addSubview:self.TabView];
    [self.window addSubview:self.backSideMenuView];
    [self.window addSubview:self.BtnSideMenu];
    [self.window addSubview:self.TblSideMenu];
    [self.window addSubview:self.notifView];
    
    // add drag listener
	[self.BtnSideMenu addTarget:self action:@selector(wasDragged:withEvent:)
               forControlEvents:UIControlEventTouchDragInside];
    
    self.backSideMenuView.hidden = YES;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.BtnSideMenu.frame = CGRectMake(0, 90, 20, 20);
        self.TblSideMenu.backgroundColor = [UIColor colorWithRed:78.0/255.0 green:62.0/255.0 blue:57.0/255.0 alpha:1.0];
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            self.TabView.frame = CGRectMake(0, 430, 320, 50);
            self.TblSideMenu.frame = CGRectMake(-270, 20, 270, 460);
            
            // iPhone Classic
        }
        if(result.height == 568)
        {
            self.TabView.frame  = CGRectMake(0, 518, 320, 50);
            self.TblSideMenu.frame = CGRectMake(-270, 20, 270, 548);
            // iPhone 5
        }
    }
    
    [[ApplicationData sharedInstance] changeTheme];
    [[iCMSApplicationData sharedInstance] changeTheme];
}
- (void) setUserData {
    if([ApplicationData sharedInstance].frndCount != 0)
    {
        [btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
    }
    else
    {
        btnFriendCount.hidden = YES;
    }
    
    if([ApplicationData sharedInstance].msgCount != 0)
    {
        [btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
    }
    else
    {
        btnMsgCount.hidden = YES;
    }
    
    if([ApplicationData sharedInstance].groupCount != 0)
    {
        [btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
    }
    else
    {
        btnGroupCount.hidden = YES;
    }
}

- (NSMutableArray *)fetchHomeList
{
    NSMutableArray *tabarr = [[NSMutableArray alloc] init];
    tabarr = [GlobalObjects ApplicationMenulist:@"" menuposition:1];
    
    AllMenudetail *allmenude = [[AllMenudetail alloc] init];
    [[ApplicationData sharedInstance].arr_MenuHomeglobalList removeAllObjects];
    
    for (int i = 0; i < [tabarr count]; i++)
    {
        allmenude = [tabarr objectAtIndex:i];
        if ([[ApplicationData sharedInstance].arr_Themeglobal_List count] == 0)
        {
            [ApplicationData sharedInstance].arr_Themeglobal_List = [GlobalObjects Applicationtheme];
        }
        
        for (int l = 0; l < [allmenude.arrmenuitem count]; l++)
        {
            NSDictionary *dictitem = [allmenude.arrmenuitem objectAtIndex:l];
            
            ApplicationMenuItem *appMenuItem = [[ApplicationMenuItem alloc] init];
           
//            itemcaption = Chat;
//            itemdata =                     {
//                url = "https://www.vattina.com/chat/extensions/mobile/";
//            };
//            itemid = 32;
//            itemview = Web;
            appMenuItem.itemid = [[dictitem objectForKey:@"itemid"] intValue];
            appMenuItem.str_itemcaption = [dictitem objectForKey:@"itemcaption"];
            appMenuItem.str_itemview = [dictitem objectForKey:@"itemview"];
//            if ([appMenuItem.str_itemview isEqualToString:@"Web"]) {
//                [ApplicationData sharedInstance].website = [[dictitem objectForKey:@"itemdata"] objectForKey:@"url"];
//            }
            if ([appMenuItem.viewname isEqualToString:@"Web"]) {
                [ApplicationData sharedInstance].website = [appMenuItem.dict_itemdata objectForKey:@"url"];
            }
            if ([[dictitem objectForKey:@"itemdata"] isKindOfClass:[NSDictionary class]]) {
                
                appMenuItem.dict_itemdata = [dictitem objectForKey:@"itemdata"];
                appMenuItem.itemdata_id = [[[dictitem objectForKey:@"itemdata"] objectForKey:@"id"]intValue];
            }
            for (int k = 0; k < [[ApplicationData sharedInstance].arr_Themeglobal_List count]; k++)
            {
                AppconfigThemedetail *apptheme = [[AppconfigThemedetail alloc] init];
                
                apptheme = [[ApplicationData sharedInstance].arr_Themeglobal_List objectAtIndex:k];
                
                if ([[dictitem objectForKey:@"itemview"] isEqualToString:apptheme.viewname])
                {
                    
                    appMenuItem.icon_URL = apptheme.icon_URL;//[dictheme objectForKey:@"icon"];
                    appMenuItem.tab_active_URL = apptheme.tab_active_URL;//[dictheme objectForKey:@"tab_active"];
                    appMenuItem.tab_URL = apptheme.tab_URL;//[dictheme objectForKey:@"tab"];
                    appMenuItem.viewname = apptheme.viewname;//[dictheme objectForKey:@"viewname"];
                    appMenuItem.thumb_icon = [UIImage imageWithContentsOfFile:apptheme.icon_imgpath];
                }
                else {
                }
            }
            
            //tabbar menu.
            [[ApplicationData sharedInstance].arr_MenuHomeglobalList addObject:appMenuItem];
        }
    }
    return tabarr;
}

- (NSMutableArray *)fetchTabList:(NSString *)screenname {
    NSMutableArray *tabarr = [[NSMutableArray alloc] init];
    tabarr = [GlobalObjects ApplicationMenulist:screenname menuposition:3];
    
    if ([tabarr count] > 0) {
        self.TabView.hidden = NO;
    } else {
        self.TabView.hidden = YES;
    }
    AllMenudetail *allmenude = [[AllMenudetail alloc] init];
    [[ApplicationData sharedInstance].tabList removeAllObjects];
    
    for (int i = 0; i < [tabarr count]; i++) {
        allmenude = [tabarr objectAtIndex:i];
        if ([[ApplicationData sharedInstance].arr_Themeglobal_List count] == 0) {
            [ApplicationData sharedInstance].arr_Themeglobal_List = [GlobalObjects Applicationtheme];
        }
        
        for (int l = 0; l < [allmenude.arrmenuitem count]; l++)
        {
            NSDictionary *dictitem = [allmenude.arrmenuitem objectAtIndex:l];
            
            Tab *record = [[Tab alloc] init];
            
            record.classname = [dictitem objectForKey:@"itemview"];
            record.title = [dictitem objectForKey:@"itemcaption"];
            DLog(@"Tab itemcaption : %@",[dictitem objectForKey:@"itemcaption"]);
            record.itemid = [[dictitem objectForKey:@"itemid"] intValue];
            if ([[dictitem objectForKey:@"itemdata"] isKindOfClass:[NSDictionary class]]) {
                
                record.dict_itemdata = [dictitem objectForKey:@"itemdata"];
                record.itemdata_id = [[[dictitem objectForKey:@"itemdata"] objectForKey:@"id"]intValue];
            }
            
            for (int k = 0; k < [[ApplicationData sharedInstance].arr_Themeglobal_List count]; k++)
            {
                AppconfigThemedetail *apptheme = [[AppconfigThemedetail alloc] init];
                
                apptheme = [[ApplicationData sharedInstance].arr_Themeglobal_List objectAtIndex:k];
                
                if ([[dictitem objectForKey:@"itemview"] isEqualToString:apptheme.viewname])
                {
                    record.thumbURL = apptheme.tab_active_URL;
                    record.tabimgUrl = apptheme.tab_URL;
                    record.tabimg = [UIImage imageWithContentsOfFile:apptheme.tab_imgpath];
                    record.thumbImg = [UIImage imageWithContentsOfFile:apptheme.tab_active_imgpath];
                    
                    record.tabimgpath = apptheme.tab_imgpath;
                    record.tabactiveimgpath = apptheme.tab_active_imgpath;
                }
                else
                {
                    //default icon go in this function.
                }
            }
            [[ApplicationData sharedInstance].tabList addObject:record];
        }
    }
    return tabarr;
}

- (NSMutableArray *)fetchsidemenuList:(NSString *)screenname {
    NSMutableArray *tabarr = [[NSMutableArray alloc] init];
    tabarr = [GlobalObjects ApplicationMenulist:screenname menuposition:2];
    //    if ([tabarr count] > 0) {
    //        self.BtnSideMenu.hidden = NO;
    //    } else {
    //        self.BtnSideMenu.hidden = YES;
    //    }
    
    AllMenudetail *allmenude = [[AllMenudetail alloc] init];
    [[ApplicationData sharedInstance].arr_MenuSidebarList removeAllObjects];
    
    for (int i = 0; i < [tabarr count]; i++)
    {
        allmenude = [tabarr objectAtIndex:i];
        if ([[ApplicationData sharedInstance].arr_Themeglobal_List count] == 0)
        {
            [ApplicationData sharedInstance].arr_Themeglobal_List = [GlobalObjects Applicationtheme];
        }
        
        for (int l = 0; l < [allmenude.arrmenuitem count]; l++)
        {
            NSDictionary *dictitem = [allmenude.arrmenuitem objectAtIndex:l];
            
            ApplicationMenuItem *appMenuItem = [[ApplicationMenuItem alloc] init];
            
            appMenuItem.itemid = [[dictitem objectForKey:@"itemid"] intValue];
            appMenuItem.str_itemcaption = [dictitem objectForKey:@"itemcaption"];
            appMenuItem.str_itemview = [dictitem objectForKey:@"itemview"];
            
            if ([[dictitem objectForKey:@"itemdata"] isKindOfClass:[NSDictionary class]]) {
                
                appMenuItem.dict_itemdata = [dictitem objectForKey:@"itemdata"];
                appMenuItem.itemdata_id = [[[dictitem objectForKey:@"itemdata"] objectForKey:@"id"]intValue];
            }
            //            appMenuItem.itemdata_id = [[[dictitem objectForKey:@"itemdata"] objectForKey:@"id"]intValue];
            for (int k = 0; k < [[ApplicationData sharedInstance].arr_Themeglobal_List count]; k++) {
                AppconfigThemedetail *apptheme = [[AppconfigThemedetail alloc] init];
                
                apptheme = [[ApplicationData sharedInstance].arr_Themeglobal_List objectAtIndex:k];
                
                if ([[dictitem objectForKey:@"itemview"] isEqualToString:apptheme.viewname]) {
                    appMenuItem.icon_URL = apptheme.icon_URL;
                    appMenuItem.tab_active_URL = apptheme.tab_active_URL;
                    appMenuItem.tab_URL = apptheme.tab_URL;
                    appMenuItem.viewname = apptheme.viewname;
                    appMenuItem.thumb_icon = [UIImage imageWithContentsOfFile:apptheme.icon_imgpath];
                    appMenuItem.iconpath = apptheme.icon_imgpath;
                    appMenuItem.tabpath = apptheme.tab_imgpath;
                    appMenuItem.tabActpath = apptheme.tab_active_imgpath;
                }
                else
                {
                    //default icon go in this function.
                }
            }
            
            //side menu.
            [[ApplicationData sharedInstance].arr_MenuSidebarList addObject:appMenuItem];
            
        }
        
        DLog(@"%@",allmenude.arrmenuitem);
    }
    if([[ApplicationData sharedInstance].arr_MenuSidebarList count] > 0) {
        self.BtnSideMenu.hidden = NO;
        //            [self.window bringSubviewToFront:self.BtnSideMenu];
    } else {
        self.BtnSideMenu.hidden = YES;
    }
    DLog(@"%@",tabarr);
    return tabarr;
}

-(BOOL)fetchConfig
{
    
    NSDictionary *dict = [[NSDictionary alloc]init];
    int modelNum;
    CGFloat scale = [[UIScreen mainScreen] scale];
    if (scale > 1.0) {
        if([[ UIScreen mainScreen ] bounds ].size.height == 568)
        {
            modelNum = 5;
        }
        else
        {
            modelNum = 4;
        }
    }
    else
    {
        modelNum = 3;
    }
    NSMutableDictionary *postVariables = [[NSMutableDictionary alloc] init];
    [postVariables setValue:@"iphone" forKey:@"device"];
    [postVariables setValue:[NSString stringWithFormat:@"%d", modelNum] forKey:@"type"];
    
    dict = [JoomlaRegistration CreateDictionary:@"applicationConfig" TaskdataDictionary:postVariables Imagedata:nil];
    
    if (!dict) {
        [self performSelector:@selector(Alert) withObject:nil afterDelay:0.0];
    }
    else {
        if ([[dict objectForKey:@"code"] intValue] == 200) {
            BOOL temp = [GlobalObjects Applicationconfigration:dict];
            DLog(@"%d",temp);
            [ApplicationData sharedInstance].errorCode = [[dict valueForKey:@"code"] intValue];
            DLog(@"code:%d",[ApplicationData sharedInstance].errorCode);
            DLog(@"Dict:%@",dict);
            
            NSDictionary *dict1 = [[dict valueForKey:@"configuration"] valueForKey:@"globalconfig"];
            DLog(@"Dict1:%@",dict1);            
        }
    }
    return YES;
}

-(void)Alert
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server Error" message:@"Bad Data In Server Response." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    if([ApplicationData sharedInstance].userDetail != 0)
    {
        if([ApplicationData sharedInstance].facebook)
        {
            [[ApplicationData sharedInstance].facebook logout];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Although the SDK attempts to refresh its access tokens when it makes API calls,
    // it's a good practice to refresh the access token also when the app becomes active.
    // This gives apps that seldom make api calls a higher chance of having a non expired
    // access token.
    [[ApplicationData sharedInstance].facebook extendAccessTokenIfNeeded];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[ApplicationData sharedInstance].facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[ApplicationData sharedInstance].facebook handleOpenURL:url];
}

/////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////Sidemenu Code.////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
-(void)TabbarHide
{
   self.TabView.hidden = YES;
}

-(void)TabReset
{
    notifView.hidden = YES;
    self.BtnTab.hidden = YES;
    self.BtnTab1.hidden = YES;
    self.BtnTab2.hidden = YES;
    self.BtnTab3.hidden = YES;
    self.BtnTab4.hidden = YES;
    
    self.BtnTab.selected = NO;
    self.BtnTab1.selected = NO;
    self.BtnTab2.selected = NO;
    self.BtnTab3.selected = NO;
    self.BtnTab4.selected = NO;
    
    self.TabView.hidden = YES;
    
    self.LblTab.hidden = YES;
    self.LblTab1.hidden = YES;
    self.LblTab2.hidden = YES;
    self.LblTab3.hidden = YES;
    self.LblTab4.hidden = YES;
    
    TblMoreview.hidden = YES;
    sidemenuflag = FALSE;
    
    if ([[ApplicationData sharedInstance].tabList count]) {
        self.TabView.hidden = NO;
    }
    
    Tab *record = [[Tab alloc] init];
    
    for (int i = 0; i < [[ApplicationData sharedInstance].tabList count]; i++) {
        
        record = [[ApplicationData sharedInstance].tabList objectAtIndex:i];
        if (i == 0) {
            
            if (record.tabimgpath) {
                
                [BtnTab setImage:[UIImage imageWithContentsOfFile:record.tabimgpath] forState:UIControlStateNormal];
            }
            else{
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.tabimgUrl]];
                UIImage *image = [UIImage imageWithData:data];
                [BtnTab setImage:image forState:UIControlStateNormal];
            }
            
            if (record.tabactiveimgpath){
                [BtnTab setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateHighlighted];
                [BtnTab setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateSelected];
            }
            else{
                NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.thumbURL]];
                UIImage *image = [UIImage imageWithData:data1];
                [BtnTab setImage:image forState:UIControlStateHighlighted];
                [BtnTab setImage:image forState:UIControlStateSelected];
            }
            
            //            [BtnTab setImage:[UIImage imageWithContentsOfFile:record.tabimgpath] forState:UIControlStateNormal];
            //            [BtnTab setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateHighlighted];
            //            [BtnTab setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateSelected];
            LblTab.text = record.title;
            LblTab.textColor = [iCMSApplicationData sharedInstance].tabtextcolor;
            LblTab.font = [iCMSApplicationData sharedInstance].header6;
            
            if ([[record.classname lowercaseString] isEqualToString:[[iCMSApplicationData sharedInstance].StrClassName lowercaseString]]) {
                BtnTab.selected = YES;
            }
            
            BtnTab.hidden = NO;
            self.LblTab.hidden = NO;
        }
        else if (i == 1)
        {
            if (record.tabimgpath) {
                
                [BtnTab1 setImage:[UIImage imageWithContentsOfFile:record.tabimgpath] forState:UIControlStateNormal];
            }
            else{
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.tabimgUrl]];
                UIImage *image = [UIImage imageWithData:data];
                [BtnTab1 setImage:image forState:UIControlStateNormal];
            }
            
            if (record.tabactiveimgpath){
                [BtnTab1 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateHighlighted];
                [BtnTab1 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateSelected];
            }
            else{
                NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.thumbURL]];
                UIImage *image = [UIImage imageWithData:data1];
                [BtnTab1 setImage:image forState:UIControlStateHighlighted];
                [BtnTab1 setImage:image forState:UIControlStateSelected];
            }
            //            [BtnTab1 setImage:[UIImage imageWithContentsOfFile:record.tabimgpath] forState:UIControlStateNormal];
            //            [BtnTab1 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateHighlighted];
            //            [BtnTab1 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateSelected];
            LblTab1.text = record.title;
            LblTab1.textColor = [iCMSApplicationData sharedInstance].tabtextcolor;
            LblTab1.font = [iCMSApplicationData sharedInstance].header6;
            BtnTab1.hidden = NO;
            if ([[record.classname lowercaseString] isEqualToString:[[iCMSApplicationData sharedInstance].StrClassName lowercaseString]]) {
                BtnTab1.selected = YES;
            }
            self.LblTab1.hidden = NO;
        }
        else if (i == 2)
        {
            if (record.tabimgpath) {
                
                [BtnTab2 setImage:[UIImage imageWithContentsOfFile:record.tabimgpath] forState:UIControlStateNormal];
            }
            else{
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.tabimgUrl]];
                UIImage *image = [UIImage imageWithData:data];
                [BtnTab2 setImage:image forState:UIControlStateNormal];
            }
            
            if (record.tabactiveimgpath){
                [BtnTab2 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateHighlighted];
                [BtnTab2 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateSelected];
            }
            else{
                NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.thumbURL]];
                UIImage *image = [UIImage imageWithData:data1];
                [BtnTab2 setImage:image forState:UIControlStateHighlighted];
                [BtnTab2 setImage:image forState:UIControlStateSelected];
            }
            //            [BtnTab2 setImage:[UIImage imageWithContentsOfFile:record.tabimgpath] forState:UIControlStateNormal];
            //            [BtnTab2 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateHighlighted];
            //            [BtnTab2 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateSelected];
            LblTab2.text = record.title;
            LblTab2.textColor = [iCMSApplicationData sharedInstance].tabtextcolor;
            LblTab2.font = [iCMSApplicationData sharedInstance].header6;
            BtnTab2.hidden = NO;
            if ([[record.classname lowercaseString] isEqualToString:[[iCMSApplicationData sharedInstance].StrClassName lowercaseString]]) {
                BtnTab2.selected = YES;
            }
            self.LblTab2.hidden = NO;
        }
        else if (i == 3)
        {
            if (record.tabimgpath) {
                
                [BtnTab3 setImage:[UIImage imageWithContentsOfFile:record.tabimgpath] forState:UIControlStateNormal];
            }
            else{
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.tabimgUrl]];
                UIImage *image = [UIImage imageWithData:data];
                [BtnTab3 setImage:image forState:UIControlStateNormal];
            }
            
            if (record.tabactiveimgpath){
                [BtnTab3 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateHighlighted];
                [BtnTab3 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateSelected];
            }
            else{
                NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.thumbURL]];
                UIImage *image = [UIImage imageWithData:data1];
                [BtnTab3 setImage:image forState:UIControlStateHighlighted];
                [BtnTab3 setImage:image forState:UIControlStateSelected];
            }
            //            [BtnTab3 setImage:[UIImage imageWithContentsOfFile:record.tabimgpath] forState:UIControlStateNormal];
            //            [BtnTab3 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateHighlighted];
            //            [BtnTab3 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateSelected];
            LblTab3.text = record.title;
            LblTab3.textColor = [iCMSApplicationData sharedInstance].tabtextcolor;
            LblTab3.font = [iCMSApplicationData sharedInstance].header6;
            BtnTab3.hidden = NO;
            if ([[record.classname lowercaseString] isEqualToString:[[iCMSApplicationData sharedInstance].StrClassName lowercaseString]]) {
                BtnTab3.selected = YES;
            }
            self.LblTab3.hidden = NO;
        }
        else if (i == 4 && [[ApplicationData sharedInstance].tabList count] == 5)
        {
            if (record.tabimgpath) {
                
                [BtnTab4 setImage:[UIImage imageWithContentsOfFile:record.tabimgpath] forState:UIControlStateNormal];
            }
            else{
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.tabimgUrl]];
                UIImage *image = [UIImage imageWithData:data];
                [BtnTab4 setImage:image forState:UIControlStateNormal];
            }
            
            if (record.tabactiveimgpath){
                [BtnTab4 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateHighlighted];
                [BtnTab4 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateSelected];
            }
            else{
                NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.thumbURL]];
                UIImage *image = [UIImage imageWithData:data1];
                [BtnTab4 setImage:image forState:UIControlStateHighlighted];
                [BtnTab4 setImage:image forState:UIControlStateSelected];
            }
            //            [BtnTab4 setImage:[UIImage imageWithContentsOfFile:record.tabimgpath] forState:UIControlStateNormal];
            //            [BtnTab4 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateHighlighted];
            //            [BtnTab4 setImage:[UIImage imageWithContentsOfFile:record.tabactiveimgpath] forState:UIControlStateSelected];
            LblTab4.text = record.title;
            LblTab4.textColor = [iCMSApplicationData sharedInstance].tabtextcolor;
            LblTab4.font = [iCMSApplicationData sharedInstance].header6;
            BtnTab4.hidden = NO;
            if ([[record.classname lowercaseString] isEqualToString:[[iCMSApplicationData sharedInstance].StrClassName lowercaseString]]) {
                BtnTab4.selected = YES;
            }
            self.LblTab4.hidden = NO;
        }
        else if ([[ApplicationData sharedInstance].tabList count] > 5) {
            
            [BtnTab4 setImage:[UIImage imageNamed:@"More_tab.png"] forState:UIControlStateNormal];
            [BtnTab4 setImage:[UIImage imageNamed:@"More_tab_active.png"] forState:UIControlStateHighlighted];
            [BtnTab4 setImage:[UIImage imageNamed:@"More_tab_active.png"] forState:UIControlStateSelected];
            LblTab4.text = @"More";
            LblTab4.textColor = [iCMSApplicationData sharedInstance].tabtextcolor;
            LblTab4.font = [iCMSApplicationData sharedInstance].header6;
            BtnTab4.hidden = NO;
            self.LblTab4.hidden = NO;
            if (BtnTab.selected == NO && BtnTab1.selected == NO && BtnTab2.selected == NO && BtnTab3.selected == NO && BtnTab4.selected == NO && [[record.classname lowercaseString] isEqualToString:[[iCMSApplicationData sharedInstance].StrClassName lowercaseString]]) {
                
                BtnTab4.selected = YES;
            }
        }
    }
}

- (IBAction)TabMenuPressed:(id)sender
{
    UIViewController *controller = nil;
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Data.plist"]];
    [[ApplicationData sharedInstance] changeTheme];
    [[iCMSApplicationData sharedInstance] changeTheme];
    
    NSArray* tabbarViewMenu = [plistDict objectForKey:@"ViewList"];
    
    Tab *record = [[Tab alloc] init];
    Class controllerClass;
    record = [[ApplicationData sharedInstance].tabList objectAtIndex:[sender tag]];
    
    for (int l = 0; l < [tabbarViewMenu count]; l++)
    {
        NSDictionary *dict = [tabbarViewMenu objectAtIndex:l];
        NSString *key = [[dict allKeys] objectAtIndex:0];
        NSArray *arrtmp = [dict objectForKey:key];
        
        if ([[[arrtmp objectAtIndex:1] lowercaseString] isEqualToString:[record.classname lowercaseString]])
        {
            controllerClass = NSClassFromString(key);
            
            controller = [[controllerClass alloc] init];
            
            controller.tabBarItem.title = record.title;
            controller.title = record.title;
            [iCMSApplicationData sharedInstance].StrClassName = record.classname;
            [controller.navigationItem setHidesBackButton:YES];
            if(controller) {
                if (controllerClass == [iCMSArticleListViewController class]) {
                    if (record.itemdata_id > 0) {
                        iCMSCategory *singlecategory = [[iCMSCategory alloc] init];
                        singlecategory.category_id = record.itemdata_id;
                        ((iCMSArticleListViewController *)controller).category = singlecategory;
                        ((iCMSArticleListViewController *)controller).catid = record.itemdata_id;
                        ((iCMSArticleListViewController *)controller).isSingleCategory = YES;
                    }
                    else
                    {
                        ((iCMSArticleListViewController *)controller).catid = record.itemdata_id;
                        ((iCMSArticleListViewController *)controller).isSingleCategory = NO;
                    }
                }
                if (controllerClass == [iCMSArticleDetailViewController class]) {
                    iCMSArticle *singleArticle = [[iCMSArticle alloc] init];
                    singleArticle.article_id = record.itemdata_id;
                    ((iCMSArticleDetailViewController *)controller).articleDetail = singleArticle;
                    ((iCMSArticleDetailViewController *)controller).isSingleArticle = YES;
                }
            }
        }
    }
    NSLog(@"Same controller : %@",self.SelfViewcontroller.class);
    NSLog(@"Same controller : %@",controller.class);
    
    if (self.SelfViewcontroller.class != controller.class) {
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        
        self.SelfViewcontroller = controller;
        if (![[record.classname lowercaseString] isEqualToString:@"home"]) {
            self.navigationController.navigationItem.leftBarButtonItem = nil;
            [self.navigationController.navigationItem setHidesBackButton:YES];
            [self.navigationController initWithRootViewController:controller];
        }
        else {
            if (controllerClass == [MoreViewController class]) {
                self.SelfViewcontroller = moreviewcontroller;
                return;
            }
            else {
                [self.navigationController initWithRootViewController:controller];
            }
        }

    }
    else{
        [(UIButton *)sender setSelected:YES];
    }
}

- (IBAction)TabMenuPressed1:(id)sender
{
    if ([[ApplicationData sharedInstance].tabList count] == 5) {
        
        UIViewController *controller = nil;
        NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Data.plist"]];
        [[ApplicationData sharedInstance] changeTheme];
        [[iCMSApplicationData sharedInstance] changeTheme];
        
        NSArray* tabbarViewMenu = [plistDict objectForKey:@"ViewList"];
        
        Tab *record = [[Tab alloc] init];
        record = [[ApplicationData sharedInstance].tabList objectAtIndex:[sender tag]];
        for (int l = 0; l < [tabbarViewMenu count]; l++)
        {
            NSDictionary *dict = [tabbarViewMenu objectAtIndex:l];
            NSString *key = [[dict allKeys] objectAtIndex:0];
            NSArray *arrtmp = [dict objectForKey:key];
            
            if ([[[arrtmp objectAtIndex:1] lowercaseString] isEqualToString:[record.classname lowercaseString]])
            {
                Class controllerClass = NSClassFromString(key);
                
                controller = [[controllerClass alloc] init];
                
                controller.tabBarItem.title = record.title;
                controller.title = record.title;
                [iCMSApplicationData sharedInstance].StrClassName = record.classname;
                
                if(controller)
                {
                    
                    if (controllerClass == [iCMSArticleListViewController class])
                    {
                        if (record.itemdata_id > 0) {
                            iCMSCategory *singlecategory = [[iCMSCategory alloc] init];
                            singlecategory.category_id = record.itemdata_id;
                            ((iCMSArticleListViewController *)controller).category = singlecategory;
                            ((iCMSArticleListViewController *)controller).catid = record.itemdata_id;
                            ((iCMSArticleListViewController *)controller).isSingleCategory = YES;
                        }
                        else
                        {
                            ((iCMSArticleListViewController *)controller).catid = record.itemdata_id;
                            ((iCMSArticleListViewController *)controller).isSingleCategory = NO;
                        }
                    }
                }
            }
        }
        [self.navigationController popToRootViewControllerAnimated:NO];
        self.SelfViewcontroller = controller;
        if (![[record.classname lowercaseString] isEqualToString:@"home"]) {
            self.navigationController.navigationItem.backBarButtonItem = nil;
            [self.navigationController pushViewController:controller animated:NO];
        }
    }
    else{
        float height = (48.0 * ([[ApplicationData sharedInstance].tabList count] - 4));
        float y;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                y = (430.0 - height);
            }
            else if(result.height == 568)
            {
                y = (518.0 - height);
            }
        }
        
        if (y < 65) {
            
            y = 64;
        }
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if (!sidemenuflag) {
                
                if(result.height == 480)
                {
                    if (height > 366) {
                        height = 366;
                    }
                    self.TblMoreview.frame = CGRectMake(320, y, 160, height);
                    // iPhone Classic
                }
                else if(result.height == 568)
                {
                    if (height > 454) {
                        height = 454;
                    }
                    self.TblMoreview.frame  = CGRectMake(320, y, 160, height);
                    // iPhone 5
                }
            }
        }
        self.TblMoreview.hidden = NO;
        
        [UIView beginAnimations:@"toggleSideMenu" context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3f];
        
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                if (sidemenuflag) {
                    self.TblMoreview.frame = CGRectMake(320, self.TblMoreview.frame.origin.y, self.TblMoreview.frame.size.width, self.TblMoreview.frame.size.height);
                    sidemenuflag = FALSE;
                    DLog(@"flag %d",sidemenuflag);
                    BtnTab4.selected = NO;
                }
                else
                {
                    self.TblMoreview.frame  = CGRectMake(160, self.TblMoreview.frame.origin.y, self.TblMoreview.frame.size.width, self.TblMoreview.frame.size.height);
                    sidemenuflag = TRUE;
                    BtnTab4.selected = YES;
                }
                // iPhone Classic
            }
            if(result.height == 568)
            {
                if (sidemenuflag) {
                    self.TblMoreview.frame = CGRectMake(320, self.TblMoreview.frame.origin.y, self.TblMoreview.frame.size.width, self.TblMoreview.frame.size.height);
                    sidemenuflag = FALSE;
                    BtnTab4.selected = NO;
                    
                }
                else
                {
                    self.TblMoreview.frame  = CGRectMake(160, self.TblMoreview.frame.origin.y, self.TblMoreview.frame.size.width, self.TblMoreview.frame.size.height);
                    sidemenuflag = TRUE;
                    BtnTab4.selected = YES;
                }
                // iPhone 5
            }
        }
        [UIView commitAnimations];
    }
    
    [self.TblMoreview reloadData];
}

- (IBAction)SideMenuPressed:(id)sender {
    if ([ApplicationData sharedInstance].isLoggedIn) {
        TblSideMenu.tableFooterView = footerView;
    }else {
        TblSideMenu.tableFooterView = nil;
    }
    
    notifView.hidden = YES;
    if (sidemenuflag && self.TblMoreview.frame.origin.x < 310) {
        [self TabMenuPressed1:0];
    }
    
    [UIView beginAnimations:@"toggleSideMenu" context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3f];
    
    if (sidemenuflag || self.TblSideMenu.frame.origin.x == 0) {
        self.backSideMenuView.hidden = YES;
        
        self.viewTop.frame = CGRectMake(95, self.viewTop.frame.origin.y, self.viewTop.frame.size.width, self.viewTop.frame.size.height);
        
        self.TabView.frame = CGRectMake(0, self.TabView.frame.origin.y, self.TabView.frame.size.width, self.TabView.frame.size.height);
        self.BtnSideMenu.frame = CGRectMake(0, self.BtnSideMenu.frame.origin.y, self.BtnSideMenu.frame.size.width, self.BtnSideMenu.frame.size.height);
        self.TblSideMenu.frame = CGRectMake(-270, self.TblSideMenu.frame.origin.y, self.TblSideMenu.frame.size.width, self.TblSideMenu.frame.size.height);
        self.sidemenuflag = FALSE;
        self.SelfViewcontroller.view.frame = CGRectMake(0, self.SelfViewcontroller.view.frame.origin.y, self.SelfViewcontroller.view.frame.size.width, self.SelfViewcontroller.view.frame.size.height);
        
        self.SelfViewcontroller.navigationController.navigationBar.frame = CGRectMake(0, self.SelfViewcontroller.navigationController.navigationBar.frame.origin.y, self.SelfViewcontroller.navigationController.navigationBar.frame.size.width, self.SelfViewcontroller.navigationController.navigationBar.frame.size.height);
    }
    else {
        
        self.viewTop.frame = CGRectMake((95+270), self.viewTop.frame.origin.y, self.viewTop.frame.size.width, self.viewTop.frame.size.height);
        
        self.backSideMenuView.hidden = NO;
        self.TabView.frame = CGRectMake(270, self.TabView.frame.origin.y, self.TabView.frame.size.width, self.TabView.frame.size.height);
        self.BtnSideMenu.frame = CGRectMake(270, self.BtnSideMenu.frame.origin.y, self.BtnSideMenu.frame.size.width, self.BtnSideMenu.frame.size.height);
        self.TblSideMenu.frame = CGRectMake(0, self.TblSideMenu.frame.origin.y, self.TblSideMenu.frame.size.width, self.TblSideMenu.frame.size.height);
        self.sidemenuflag = TRUE;
        self.SelfViewcontroller.view.frame = CGRectMake(270, self.SelfViewcontroller.view.frame.origin.y, self.SelfViewcontroller.view.frame.size.width, self.SelfViewcontroller.view.frame.size.height);
        self.SelfViewcontroller.navigationController.navigationBar.frame = CGRectMake(270, self.SelfViewcontroller.navigationController.navigationBar.frame.origin.y, self.SelfViewcontroller.navigationController.navigationBar.frame.size.width, self.SelfViewcontroller.navigationController.navigationBar.frame.size.height);
    }
    [self.TblSideMenu reloadData];
    [UIView commitAnimations];
}

//////#table delegates
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//
//    if (tableView == TblMoreview) {
//        return ([[ApplicationData sharedInstance].tabList count] - 4);
//        DLog(@"%d",([[ApplicationData sharedInstance].tabList count] - 4));
//    }
//    else
//    {
//        return ([[ApplicationData sharedInstance].arr_MenuHomeglobalList count]);
//        DLog(@"%d",([[ApplicationData sharedInstance].arr_MenuHomeglobalList count]));
//    }
//    // return 3;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (tableView == TblMoreview) {
//        return 48.0;
//    }
//    else
//    {
//        return 48.0;
//    }
//
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//    UILabel *lblName = [[UILabel alloc] init];
//    UIImageView *thumbImage = [[UIImageView alloc] init];
//    lblName.textColor = [iCMSApplicationData sharedInstance].textcolor;
//    [lblName setBackgroundColor:[iCMSApplicationData sharedInstance].moreCellBackColor];
//    lblName.frame = CGRectMake(1, 1, (tableView.frame.size.width - 2), 47);
//    lblName.font = [iCMSApplicationData sharedInstance].header4;
//    thumbImage.frame = CGRectMake(8, 10, 30, 30);
//    thumbImage.backgroundColor = [UIColor clearColor];
//    [tableView setSeparatorColor:[UIColor clearColor]];
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//
//    if (tableView == TblMoreview) {
//
//        //Tab *record = [[Tab alloc] init];
//
//        Tab *record = [[ApplicationData sharedInstance].tabList objectAtIndex:(indexPath.row + 4)];
//
//        lblName.text = [NSString stringWithFormat:@"          %@",record.title];
//        thumbImage.image = [UIImage imageWithContentsOfFile:record.tabimgpath];
//        [cell addSubview:lblName];
//        [cell addSubview:thumbImage];
//
//        [thumbImage release];
//        [lblName release];
//    }
//    else
//    {
//        //ApplicationMenuItem *record  = [[ApplicationMenuItem alloc] init];
//        ApplicationMenuItem *record = [[ApplicationData sharedInstance].arr_MenuHomeglobalList objectAtIndex:indexPath.row];
//        lblName.text = [NSString stringWithFormat:@"          %@",record.str_itemcaption];
//        thumbImage.image = record.thumb_icon;//[UIImage imageWithContentsOfFile:record.thumb_icon];
//        [cell addSubview:lblName];
//        [cell addSubview:thumbImage];
//
//        [thumbImage release];
//        [lblName release];
//    }
//
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UIViewController *controller = nil;
//    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Data.plist"]];
//    NSArray* tabbarViewMenu = [plistDict objectForKey:@"ViewList"];
//
//    if (tableView == TblMoreview) {
//       // Tab *record = [[Tab alloc] init];
//
//        Tab *record = [[ApplicationData sharedInstance].tabList objectAtIndex:(indexPath.row + 4)];
//        for (int l = 0; l < [tabbarViewMenu count]; l++)
//        {
//            NSDictionary *dict = [tabbarViewMenu objectAtIndex:l];
//            NSString *key = [[dict allKeys] objectAtIndex:0];
//            NSArray *arrtmp = [dict objectForKey:key];
//            if ([[[arrtmp objectAtIndex:1] lowercaseString] isEqualToString:[record.classname lowercaseString]])
//            {
//                Class controllerClass = NSClassFromString(key);
//
//                controller = [[controllerClass alloc] init];
//                controller.title = record.title;
//                [iCMSApplicationData sharedInstance].StrClassName = record.classname;
//
//                if(controller)
//                {
//                    if (controllerClass == [iCMSArticleDetailViewController class])
//                    {
//                        iCMSArticle *singleArticle = [[iCMSArticle alloc] init];
//                        singleArticle.article_id = record.itemdata_id;
//                        ((iCMSArticleDetailViewController *)controller).articleDetail = singleArticle;
//                        ((iCMSArticleDetailViewController *)controller).isSingleArticle = YES;
//                    }
//                    if (controllerClass == [iCMSArticleListViewController class])
//                    {
//                        iCMSCategory *singleCategory = [[iCMSCategory alloc] init];
//                        singleCategory.category_id = record.itemdata_id;
//                        singleCategory.category_name = record.title;
//                        ((iCMSArticleListViewController *)controller).category = singleCategory;
//                        ((iCMSArticleListViewController *)controller).isSingleCategory = YES;
//                        ((iCMSArticleListViewController *)controller).catid = record.itemdata_id;
//                    }
//                }
//                [self.navigationController popToRootViewControllerAnimated:NO];
//                self.SelfViewcontroller = controller;
//                if (![[record.classname lowercaseString] isEqualToString:@"home"]) {
//                    self.navigationController.navigationItem.backBarButtonItem = nil;
//                    [self.navigationController initWithRootViewController:controller];
//                }
//            }
//        }
//    }
//    else{
//
//       // ApplicationMenuItem *record  = [[ApplicationMenuItem alloc] init];
//        ApplicationMenuItem *record = [[ApplicationData sharedInstance].arr_MenuHomeglobalList objectAtIndex:indexPath.row];
//        for (int l = 0; l < [tabbarViewMenu count]; l++)
//        {
//            NSDictionary *dict = [tabbarViewMenu objectAtIndex:l];
//            NSString *key = [[dict allKeys] objectAtIndex:0];
//            NSArray *arrtmp = [dict objectForKey:key];
//            if ([[[arrtmp objectAtIndex:1] lowercaseString] isEqualToString:[record.viewname lowercaseString]])
//            {
//                Class controllerClass = NSClassFromString(key);
//
//                controller = [[controllerClass alloc] init];
//                controller.title = record.str_itemcaption;
//                [iCMSApplicationData sharedInstance].StrClassName = record.viewname;
//
//                if(controller)
//                {
//                    if (controllerClass == [iCMSArticleDetailViewController class])
//                    {
//                        iCMSArticle *singleArticle = [[iCMSArticle alloc] init];
//                        singleArticle.article_id = record.itemdata_id;
//                        ((iCMSArticleDetailViewController *)controller).articleDetail = singleArticle;
//                        ((iCMSArticleDetailViewController *)controller).isSingleArticle = YES;
//                    }
//                    if (controllerClass == [iCMSArticleListViewController class])
//                    {
//                        iCMSCategory *singleCategory = [[iCMSCategory alloc] init];
//                        singleCategory.category_id = record.itemdata_id;
//                        singleCategory.category_name = record.str_itemcaption;
//                        ((iCMSArticleListViewController *)controller).category = singleCategory;
//                        ((iCMSArticleListViewController *)controller).isSingleCategory = YES;
//                        ((iCMSArticleListViewController *)controller).catid = record.itemdata_id;
//                    }
//                }
//                [self.navigationController popToRootViewControllerAnimated:NO];
//                self.SelfViewcontroller = controller;
//                if (![[record.viewname lowercaseString] isEqualToString:@"home"]) {
//                    self.navigationController.navigationItem.backBarButtonItem = nil;
//                    [self.navigationController initWithRootViewController:controller];
//                }
//            }
//        }
//        [self SideMenuPressed:0];
//    }
//}

////#table delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == TblMoreview) {
        return ([[ApplicationData sharedInstance].tabList count] - 4);
        DLog(@"%d",([[ApplicationData sharedInstance].tabList count] - 4));
    }
    else
    {
        return ([[ApplicationData sharedInstance].arr_MenuSidebarList count]);
        DLog(@"%d",([[ApplicationData sharedInstance].arr_MenuSidebarList count]));
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (tableView == TblMoreview) {
        
    }
    else
    {
        
    }
    return 48.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UILabel *lblName = [[UILabel alloc] init];
    UIImageView *thumbImage = [[UIImageView alloc] init];
    lblName.textColor = [UIColor whiteColor];
    [lblName setBackgroundColor:[iCMSApplicationData sharedInstance].moreCellBackColor];
    if (tableView == TblMoreview) {
        
        lblName.frame = CGRectMake(1, 1, (self.TblMoreview.frame.size.width - 2), 47);
    }
    else {
        lblName.frame = CGRectMake(1, 1, (self.TblSideMenu.frame.size.width - 2), 47);
    }
    
    lblName.font = [iCMSApplicationData sharedInstance].header4;
    thumbImage.frame = CGRectMake(8, 10, 30, 30);
    thumbImage.backgroundColor = [UIColor clearColor];
    [tableView setSeparatorColor:[UIColor clearColor]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (tableView == TblMoreview) {
        Tab *record = [[ApplicationData sharedInstance].tabList objectAtIndex:(indexPath.row + 4)];
        lblName.text = [NSString stringWithFormat:@"          %@",record.title];
        //thumbImage.image = [UIImage imageWithContentsOfFile:record.tabimgpath];
        if (record.tabimgpath) {
            thumbImage.image = [UIImage imageWithContentsOfFile:record.tabimgpath];
        }
        else{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.tabimgUrl]];
            UIImage *image = [UIImage imageWithData:data];
            thumbImage.image = image;
        }
        
        [cell addSubview:lblName];
        [cell addSubview:thumbImage];
        
        [thumbImage release];
        [lblName release];
    }
    else {
        ApplicationMenuItem *record = [[ApplicationData sharedInstance].arr_MenuSidebarList objectAtIndex:indexPath.row];
        lblName.text = [NSString stringWithFormat:@"          %@",record.str_itemcaption];
        //thumbImage.image = record.thumb_icon;//[UIImage imageWithContentsOfFile:record.thumb_icon];
        if (record.thumb_icon) {
            thumbImage.image = record.thumb_icon;
        }
        else{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.icon_URL]];
            UIImage *image = [UIImage imageWithData:data];
            thumbImage.image = image;
        }
        
        [cell addSubview:lblName];
        [cell addSubview:thumbImage];
        
        [thumbImage release];
        [lblName release];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *controller = nil;
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Data.plist"]];
    NSArray* tabbarViewMenu = [plistDict objectForKey:@"ViewList"];
    
    if (tableView == TblMoreview) {
        // Tab *record = [[Tab alloc] init];
        
        Tab *record = [[ApplicationData sharedInstance].tabList objectAtIndex:(indexPath.row + 4)];
        for (int l = 0; l < [tabbarViewMenu count]; l++) {
            NSDictionary *dict = [tabbarViewMenu objectAtIndex:l];
            NSString *key = [[dict allKeys] objectAtIndex:0];
            NSArray *arrtmp = [dict objectForKey:key];
            if ([[[arrtmp objectAtIndex:1] lowercaseString] isEqualToString:[record.classname lowercaseString]]) {
                Class controllerClass = NSClassFromString(key);
                
                controller = [[controllerClass alloc] init];
                controller.title = record.title;
                [iCMSApplicationData sharedInstance].StrClassName = record.classname;
                if ([record.classname isEqualToString:@"Web"]) {
                    [ApplicationData sharedInstance].website = [record.dict_itemdata objectForKey:@"url"];
                    DLog(@"dict : %@",dict);
                    DLog(@"link : %@",[ApplicationData sharedInstance].website);
                }
                DLog(@"link : %@",[ApplicationData sharedInstance].website);
                if(controller) {
                    if (controllerClass == [iCMSArticleDetailViewController class]) {
                        iCMSArticle *singleArticle = [[iCMSArticle alloc] init];
                        singleArticle.article_id = record.itemdata_id;
                        ((iCMSArticleDetailViewController *)controller).articleDetail = singleArticle;
                        ((iCMSArticleDetailViewController *)controller).isSingleArticle = YES;
//                         [self SideMenuPressed:0];
                    }
                    else if (controllerClass == [iCMSArticleListViewController class]) {
                        iCMSCategory *singleCategory = [[iCMSCategory alloc] init];
                        singleCategory.category_id = record.itemdata_id;
                        singleCategory.category_name = record.title;
                        ((iCMSArticleListViewController *)controller).category = singleCategory;
                        ((iCMSArticleListViewController *)controller).isSingleCategory = YES;
                        ((iCMSArticleListViewController *)controller).catid = record.itemdata_id;
//                         [self SideMenuPressed:0];
                    }
                }
                [self.navigationController popToRootViewControllerAnimated:NO];
                self.SelfViewcontroller = controller;
                if (![[record.classname lowercaseString] isEqualToString:@"home"]) {
                    self.navigationController.navigationItem.backBarButtonItem = nil;
                    [self.navigationController initWithRootViewController:controller];
                }
            }
        }
    }
    else {
        
        ApplicationMenuItem *record = [[ApplicationData sharedInstance].arr_MenuSidebarList objectAtIndex:indexPath.row];
        for (int l = 0; l < [tabbarViewMenu count]; l++) {
            NSDictionary *dict = [tabbarViewMenu objectAtIndex:l];
            NSString *key = [[dict allKeys] objectAtIndex:0];
            NSArray *arrtmp = [dict objectForKey:key];
            if ([[[arrtmp objectAtIndex:1] lowercaseString] isEqualToString:[record.viewname lowercaseString]]) {
                Class controllerClass = NSClassFromString(key);
                
                controller = [[controllerClass alloc] init];
                controller.title = record.str_itemcaption;
                [iCMSApplicationData sharedInstance].StrClassName = record.viewname;
                if ([record.viewname isEqualToString:@"Web"]) {
                    [ApplicationData sharedInstance].website = [record.dict_itemdata objectForKey:@"url"];
                    DLog(@"dict : %@",dict);
                    DLog(@"link : %@",[ApplicationData sharedInstance].website);
                }
                if(controller) {
                    if (controllerClass == [iCMSArticleDetailViewController class]) {
                        iCMSArticle *singleArticle = [[iCMSArticle alloc] init];
                        singleArticle.article_id = record.itemdata_id;
                        ((iCMSArticleDetailViewController *)controller).articleDetail = singleArticle;
                        ((iCMSArticleDetailViewController *)controller).isSingleArticle = YES;
//                         [self SideMenuPressed:0];
                    }
                    else if (controllerClass == [iCMSArticleListViewController class]) {
                        iCMSCategory *singleCategory = [[iCMSCategory alloc] init];
                        singleCategory.category_id = record.itemdata_id;
                        singleCategory.category_name = record.str_itemcaption;
                        ((iCMSArticleListViewController *)controller).category = singleCategory;
                        ((iCMSArticleListViewController *)controller).isSingleCategory = YES;
                        ((iCMSArticleListViewController *)controller).catid = record.itemdata_id;
//                         [self SideMenuPressed:0];
                    }
                }
                
                if (self.SelfViewcontroller.class != controller.class) {
                    
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    
                    
                    self.SelfViewcontroller = controller;
                    if (![[record.viewname lowercaseString] isEqualToString:@"home"]) {
                        self.navigationController.navigationItem.backBarButtonItem = nil;
                        [self.navigationController.navigationItem setHidesBackButton:YES];
                        [self.navigationController initWithRootViewController:controller];
                    }
                    else {
                        if (controllerClass == [MoreViewController class]) {
                            self.SelfViewcontroller = moreviewcontroller;
                            [self SideMenuPressed:0];
                            return;
                        }
                        else {
                            [self.navigationController initWithRootViewController:controller];
                        }
                    }
                    
                }
                
                
//                [self.navigationController popToRootViewControllerAnimated:NO];
//                
//                if (self.SelfViewcontroller.class != controller.class)
//                {
//                    self.SelfViewcontroller = controller;
//                    if (![[record.viewname lowercaseString] isEqualToString:@"home"]) {
//                        self.navigationController.navigationItem.backBarButtonItem = nil;
//                        [self.navigationController initWithRootViewController:controller];
//                    }
//                }
////                else {
////                    if (controllerClass == [MoreViewController class]) {
////                        self.SelfViewcontroller = moreviewcontroller;
////                        return;
////                    }
////                    else {
////                        [self.navigationController initWithRootViewController:controller];
////                    }
////                }
                NSLog(@"Same controller : %@",self.SelfViewcontroller.class);
                NSLog(@"Same controller : %@",controller.class);            
            }
        }
        [self SideMenuPressed:0];
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////Sidemenu Code.////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
- (void)wasDragged:(UIButton *)button withEvent:(UIEvent *)event
{
    if (sidemenuflag && self.TblMoreview.frame.origin.x < 310) {
        [self TabMenuPressed1:0];
    }
	// get the touch
	UITouch *touch = [[event touchesForView:button] anyObject];
    
	// get delta
	CGPoint previousLocation = [touch previousLocationInView:button];
	CGPoint location = [touch locationInView:button];
	CGFloat delta_x = location.x - previousLocation.x;
    
	// move button
    if (button.frame.origin.x <= 270 && button.frame.origin.x > - 1) {
        
        button.center = CGPointMake(button.center.x + delta_x,
                                    button.center.y);
        
        self.viewTop.frame = CGRectMake((button.frame.origin.x + 95), self.viewTop.frame.origin.y, self.viewTop.frame.size.width, self.viewTop.frame.size.height);
        
        self.TabView.frame = CGRectMake(button.frame.origin.x, self.TabView.frame.origin.y, self.TabView.frame.size.width, self.TabView.frame.size.height);
        
        self.TblSideMenu.frame = CGRectMake(-(270 - button.frame.origin.x), self.TblSideMenu.frame.origin.y, self.TblSideMenu.frame.size.width, self.TblSideMenu.frame.size.height);
        
        self.SelfViewcontroller.view.frame = CGRectMake(button.frame.origin.x, self.SelfViewcontroller.view.frame.origin.y, self.SelfViewcontroller.view.frame.size.width, self.SelfViewcontroller.view.frame.size.height);
        
        self.SelfViewcontroller.navigationController.navigationBar.frame = CGRectMake(button.frame.origin.x, self.SelfViewcontroller.navigationController.navigationBar.frame.origin.y, self.SelfViewcontroller.navigationController.navigationBar.frame.size.width, self.SelfViewcontroller.navigationController.navigationBar.frame.size.height);
    }
}


/////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////Sidemenu Code.////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

- (void)dealloc
{
    [customTabController release];
    [customTabController release];
    [moreView release];
    [window release];
    [super dealloc];
}


@end