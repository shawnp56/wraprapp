//
//  MoreViewController.m
//  iJoomer home.....
//
//  Created by Tailored Solutions on 24/11/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "MoreViewController.h"
#import "iJoomerAppDelegate.h"
#import "ApplicationData.h"
#import "iCMSApplicationData.h"
#import "TableCellOwner.h"
#import "More.h"
#import "Tab.h"
#import <QuartzCore/QuartzCore.h>
#import "ApplicationMenuItem.h"
#import "GlobalObjects.h"
#import "iCMSArticleListViewController.h"
#import "ServerSettingsViewController.h"
#import "iCMSCategory.h"
#import "iCMSArticleDetailViewController.h"
#import "iCMS.h"

#define TABLE_CELL_HEIGHTS			55

//static NSString *kCellIdentifier = @"MoreCell";

@implementation MoreViewController

@synthesize imageDownloadsInProgress;

#pragma mark -
#pragma mark viewDidLoad & appear

- (id)init {
	self = [super init];
	if(self) {
		self.tabBarItem.image = [UIImage imageNamed:@"home.png"];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    welComeView.hidden = YES;
    iJoomerAppDelegate *appdelegate = (iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    appdelegate.viewTop.hidden = YES;
    appdelegate.btnSlideMenu.hidden = NO;
    
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"setting_small_icon.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ServerSetting) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 32, 32)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    imageDownloadsInProgress = [[NSMutableDictionary alloc]init];
    UIImageView *img = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:[ApplicationData sharedInstance].logoImg]] autorelease];
    self.navigationItem.titleView = img;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"button_back",@"") style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    self.navigationController.navigationBar.tintColor = [ApplicationData sharedInstance].tintColor;
    backImg.image = [UIImage imageNamed:[ApplicationData sharedInstance].bgImage];
    
    cellOwner = [[TableCellOwner alloc] init];
    
    tabbarMenu = [[NSMutableArray alloc] init];
    
    scrollView.hidden = NO;
    pageControl.hidden = NO;
    tableView.hidden = YES;
}

/*
 - (void)viewWillAppear:(BOOL)animated {
 pageNo = 0;
 for (UIView *view in scrollView.subviews) {
 [view removeFromSuperview];
 }
 
 iJoomerAppDelegate *appdelegate = (iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
 
 buttonArray = [[NSMutableArray alloc] init];
 lblArray = [[NSMutableArray alloc] init];
 appdelegate.SelfViewcontroller = self;
 
 [iCMSApplicationData sharedInstance].StrClassName = @"Home";
 if (![ApplicationData sharedInstance].DefaultLandingscreenFlag) {
 
 NSDictionary *lendingScreen = [[ApplicationData sharedInstance].dictGlobalConfig valueForKey:@"default_landing_screen"];
 
 if ([lendingScreen count] > 0) {
 
 
 NSString *screenName = [lendingScreen valueForKey:@"itemview"];
 self.navigationController.navigationItem.title = [lendingScreen valueForKey:@"itemcaption"];
 
 
 UIViewController *controller = nil;
 NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Data.plist"]];
 [[ApplicationData sharedInstance] changeTheme];
 
 NSArray* tabbarViewMenu = [plistDict objectForKey:@"ViewList"];
 
 for (int l = 0; l < [tabbarViewMenu count]; l++)
 {
 NSDictionary *dict = [tabbarViewMenu objectAtIndex:l];
 NSString *key = [[dict allKeys] objectAtIndex:0];
 NSArray *arrtmp = [dict objectForKey:key];
 
 if ([[[arrtmp objectAtIndex:1] lowercaseString] isEqualToString:[screenName lowercaseString]])
 {
 Class controllerClass = NSClassFromString(key);
 
 controller = [[controllerClass alloc] init];
 
 controller.tabBarItem.title = [lendingScreen valueForKey:@"itemcaption"];
 controller.title = [lendingScreen valueForKey:@"itemcaption"];
 [iCMSApplicationData sharedInstance].StrClassName = [lendingScreen valueForKey:@"itemview"];
 
 if(controller)
 {
 if (controllerClass == [iCMSArticleListViewController class])
 {
 
 iCMSCategory *singlecategory = [[iCMSCategory alloc] init];
 
 if ([[lendingScreen objectForKey:@"itemdata"] isKindOfClass:[NSDictionary class]]) {
 
 singlecategory.category_id = [[[lendingScreen objectForKey:@"itemdata"] objectForKey:@"id"]intValue];
 }
 
 ((iCMSArticleListViewController *)controller).category = singlecategory;
 
 if ([[lendingScreen objectForKey:@"itemdata"] isKindOfClass:[NSDictionary class]]) {
 
 ((iCMSArticleListViewController *)controller).catid = [[[lendingScreen objectForKey:@"itemdata"] objectForKey:@"id"]intValue];
 }
 ((iCMSArticleListViewController *)controller).isSingleCategory = YES;
 }
 }
 }
 }
 appdelegate.SelfViewcontroller = controller;
 [self.navigationController pushViewController:controller animated:YES];
 }
 [ApplicationData sharedInstance].DefaultLandingscreenFlag = YES;
 }
 
 NSMutableArray *arr = [[NSMutableArray alloc] init];
 arr = [appdelegate fetchHomeList];
 arr = [appdelegate fetchsidemenuList:@"Home"];
 arr = [appdelegate fetchTabList:@"Home"];
 appdelegate.SelfViewcontroller = self;
 
 if ([ApplicationData sharedInstance].loggedUser > 0) {
 
 UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
 [button setImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
 [button addTarget:self action:@selector(logoutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
 [button setFrame:CGRectMake(0, 0, 32, 32)];
 self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
 }
 else
 {
 self.navigationItem.leftBarButtonItem = nil;
 }
 
 [self.navigationController setNavigationBarHidden:NO animated:YES];
 [self.navigationItem setHidesBackButton:YES];
 
 
 //tablist
 //##########################################################################################################
 
 [appdelegate TabReset];
 //##########################################################################################################
 
 [self setImages];
 
 [self themechange];
 }
 */

- (void)viewWillAppear:(BOOL)animated {
    iJoomerAppDelegate *appdelegate = (iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    appdelegate.viewTop.hidden = YES;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    arr = [appdelegate fetchHomeList];
    arr = [appdelegate fetchsidemenuList:@"Home"];
    arr = [appdelegate fetchTabList:@"Home"];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480) {
            icon_count = TAB_COUNT;
            if ([arr count] == 0) {
                pageControl.frame = CGRectMake(17, 389, 286, 36);
            } else {
                pageControl.frame = CGRectMake(17, 339, 286, 36);
            }
        }
        else if(result.height == 568) {
            icon_count = 12;
            // iPhone 5
            if ([arr count] == 0) {
                pageControl.frame = CGRectMake(17, 477, 286, 36);
            } else {
                pageControl.frame = CGRectMake(17, 429, 286, 36);
            }
        }
    }
    
    pageNo = 0;
    for (UIView *view in scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    buttonArray = [[NSMutableArray alloc] init];
    lblArray = [[NSMutableArray alloc] init];
    appdelegate.SelfViewcontroller = self;
    
    [iCMSApplicationData sharedInstance].StrClassName = @"Home";
    if (![ApplicationData sharedInstance].DefaultLandingscreenFlag) {
        
        NSDictionary *lendingScreen = [[ApplicationData sharedInstance].dictGlobalConfig valueForKey:@"default_landing_screen"];
        
        if ([lendingScreen count] > 0) {
            
            
            NSString *screenName = [lendingScreen valueForKey:@"itemview"];
            self.navigationController.navigationItem.title = [lendingScreen valueForKey:@"itemcaption"];
            
            
            UIViewController *controller = nil;
            NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Data.plist"]];
            [[ApplicationData sharedInstance] changeTheme];
            
            NSArray* tabbarViewMenu = [plistDict objectForKey:@"ViewList"];
            
            for (int l = 0; l < [tabbarViewMenu count]; l++)
            {
                NSDictionary *dict = [tabbarViewMenu objectAtIndex:l];
                NSString *key = [[dict allKeys] objectAtIndex:0];
                NSArray *arrtmp = [dict objectForKey:key];
                
                if ([[[arrtmp objectAtIndex:1] lowercaseString] isEqualToString:[screenName lowercaseString]])
                {
                    Class controllerClass = NSClassFromString(key);
                    
                    controller = [[controllerClass alloc] init];
                    
                    controller.tabBarItem.title = [lendingScreen valueForKey:@"itemcaption"];
                    controller.title = [lendingScreen valueForKey:@"itemcaption"];
                    [iCMSApplicationData sharedInstance].StrClassName = [lendingScreen valueForKey:@"itemview"];
                    
                    if(controller)
                    {
                        if (controllerClass == [iCMSArticleListViewController class])
                        {
                            
                            iCMSCategory *singlecategory = [[iCMSCategory alloc] init];
                            
                            if ([[lendingScreen objectForKey:@"itemdata"] isKindOfClass:[NSDictionary class]]) {
                                
                                singlecategory.category_id = [[[lendingScreen objectForKey:@"itemdata"] objectForKey:@"id"]intValue];
                            }
                            
                            ((iCMSArticleListViewController *)controller).category = singlecategory;
                            
                            if ([[lendingScreen objectForKey:@"itemdata"] isKindOfClass:[NSDictionary class]]) {
                                
                                ((iCMSArticleListViewController *)controller).catid = [[[lendingScreen objectForKey:@"itemdata"] objectForKey:@"id"]intValue];
                            }
                            ((iCMSArticleListViewController *)controller).isSingleCategory = YES;
                        }
                    }
                }
            }
            appdelegate.SelfViewcontroller = controller;
            [controller.navigationItem setHidesBackButton:YES];
            [self.navigationController pushViewController:controller animated:YES];
            
            //            [self.navigationController initWithRootViewController:controller];
        }
        [ApplicationData sharedInstance].DefaultLandingscreenFlag = YES;
    }
    
    if ([ApplicationData sharedInstance].loggedUser > 0) {
        
        UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(logoutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(0, 0, 32, 32)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
	[self.navigationItem setHidesBackButton:YES];
    
    [appdelegate TabReset];
    
    [self setImages];
    [self loadImagesForRows];
    
    [self themechange];
    NSLog(@"viewWillAppear call moreview");
}

- (void) ServerSetting {
    welComeView.hidden = NO;
}

- (void)getConfig
{
    
}

- (void)loadImagesForRows {
	//NSMutableArray *photoList = [photoObj.photoList objectForKey:[NSString stringWithFormat:@"%d", pageNo]];
	for(int i=icon_count*pageNo; i<icon_count*(pageNo+1) && i<[[ApplicationData sharedInstance].arr_MenuHomeglobalList count]; ++i) {
        
        for (ApplicationMenuItem *appRecord in [ApplicationData sharedInstance].arr_MenuHomeglobalList) {
            if (!appRecord.thumb_icon) // avoid the app icon download if the app already has an icon
            {
				if([appRecord.icon_URL length] > 0 ) {
					[self performSelectorOnMainThread:@selector(startIconDownload:) withObject:appRecord waitUntilDone:YES];
				}
            }
        }
    }
}

- (IBAction)logoutButtonPressed:(id)sender
{
	//if(![spinner isAnimating]) {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"r_u_sure",@"") delegate:self cancelButtonTitle:nil
                                               destructiveButtonTitle:NSLocalizedString(@"yes",@"") otherButtonTitles:NSLocalizedString(@"no_way",@""),nil];
    actionSheet.alpha = 0.8;
    actionSheet.tag = 2;
    [actionSheet showInView:self.view];
    [actionSheet release];
	//}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
    if (actionSheet.tag == 2)
    {
		if (buttonIndex == 0)
		{
			[self logoutProcess];
		}
		else if(buttonIndex == 1)
        {
            
		}
	}
}

#pragma mark -
#pragma mark user defined functions

- (void)logoutProcess
{
	tableView.userInteractionEnabled = NO;
	self.navigationItem.rightBarButtonItem.enabled = FALSE;
	
	if(!tabBarLayerView)
    {
		CGRect frame = CGRectMake(0,0,420,49);
		tabBarLayerView = [[UIImageView alloc] initWithFrame:frame];
		[[self.tabBarController tabBar] addSubview:tabBarLayerView];
        //		[self.tabBarController tabBar].userInteractionEnabled = NO;
		[tabBarLayerView setUserInteractionEnabled:YES];
	}
    //	RequestResponseManager *requestManager = [RequestResponseManager sharedInstance];
    //	NSString *requesturl = [NSString stringWithFormat:LOGOUT_URL, [ApplicationData sharedInstance].loggedUser,
    //							[ApplicationData sharedInstance].sessionId];
    //	requesturl = [NSString stringWithFormat:[ApplicationData sharedInstance].mainServerURL, requesturl];
    //	currentRequestType = jLogoutQuery;
    //	[requestManager setRequestPropery:self ExtraInfo:nil];
    //	[requestManager sendGetHttpRequest:requesturl RequestType:jGeneralQuery];
    
    //    if (![spinner isAnimating]) {
    //        [[ApplicationData sharedInstance] animateImage:self.view];
    //    }
    //	[spinner startAnimating];
    //[[ApplicationData sharedInstance] animateImage:self.view];
    
}

- (IBAction)pageChanged:(id)sender
{
	if(pageNo < pageControl.currentPage)
    {
		[self showNextPage];
	}
    else
    {
		[self showPreviousPage];
	}
}

- (void)themechange {
	backImg.image = [UIImage imageNamed:[ApplicationData sharedInstance].bgImage];
	self.navigationController.navigationBar.tintColor = [ApplicationData sharedInstance].tintColor;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 6.0) {
        [pageControl setCurrentPageIndicatorTintColor:[iCMSApplicationData sharedInstance].textcolor];
    }
}

- (void)setImages {
    int x = 37;
	int y = 25;
	float width = 57;
	float height = 57;
	float margin = 37;
    
    int numberOfPages = [[ApplicationData sharedInstance].arr_MenuHomeglobalList count]/icon_count;
	if(([[ApplicationData sharedInstance].arr_MenuHomeglobalList count] % icon_count) > 0)
    {
		++numberOfPages;
	}
	[pageControl setNumberOfPages:numberOfPages];
	
	int count = 0;
	int tempPage = 0;
	int i =0;
    
	//for	(Tab *record in [ApplicationData sharedInstance].tabList)
    for	(ApplicationMenuItem *record in [ApplicationData sharedInstance].arr_MenuHomeglobalList)
    {
		UIButton *btn;
		UILabel *lbl;
		if([buttonArray count] > i )
        {
			btn = [buttonArray objectAtIndex:i];
            lbl = [lblArray objectAtIndex:i];
            
            x+=(width + margin);
			++count;
			
			if(tempPage != count/icon_count)
            {
				tempPage = count/icon_count;
				x = margin + tempPage * scrollView.frame.size.width;
				y = margin;
			}
            else if (count % 3 == 0)
            {
				x = margin + tempPage * scrollView.frame.size.width;
				y += (height + margin);
			}
		}
        else
        {
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
            CALayer *reportMsg = [btn layer];
            [reportMsg setMasksToBounds:YES];
            [reportMsg setCornerRadius:5.0];
            [reportMsg setBorderWidth:0.0];
            [reportMsg setBorderColor:[[ApplicationData sharedInstance].color CGColor]];
			[scrollView addSubview:btn];
			[buttonArray addObject:btn];
            lbl = [[UILabel alloc] init];
            [scrollView addSubview:lbl];
			[lblArray addObject:lbl];
			
			[btn setContentMode:UIViewContentModeScaleAspectFill];
			btn.frame = CGRectMake(x, y, width, height);
			[btn addTarget:self action:@selector(selecttab:) forControlEvents:UIControlEventTouchUpInside];
            
            if(record.thumb_icon)
            {
                [btn setBackgroundImage:record.thumb_icon forState:UIControlStateNormal];
            }
            else
            {
                //                NSData *imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.icon_URL]];
                //                record.thumb_icon = [UIImage imageWithData:imgdata];
                [btn setBackgroundImage:record.thumb_icon forState:UIControlStateNormal];
            }
            
            lbl.text = NSLocalizedString(record.str_itemcaption, @"title");
            lbl.backgroundColor = [UIColor clearColor];
            
            lbl.font = [ApplicationData sharedInstance].header5;//[UIFont fontWithName:@"Helvetica" size:12];
            lbl.textAlignment = UITextAlignmentCenter;
            lbl.frame =  CGRectMake(x-5, y+height, width+10, 18);
			btn.tag = (NSInteger)count;
			lbl.tag =  (NSInteger)count;
            
            
			x+=(width + margin);
			++count;
			
			if(tempPage != count/icon_count)
            {
				tempPage = count/icon_count;
				x = margin + tempPage * scrollView.frame.size.width;
				y = 25;
			}
            else if (count % 3 == 0)
            {
				x = margin + tempPage * scrollView.frame.size.width;
				y += (height + margin) + 20;
			}
			[btn release];
		}
        lbl.textColor = [ApplicationData sharedInstance].textcolor;
        //lbl.textColor = [UIColor colorWithRed:0.15 green:0.57 blue:0.87 alpha:1.0];
        i++;
	}
	[self setPhotoList];
	
	
	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * numberOfPages, scrollView.frame.size.width);
    
}
- (void)setPhotoList
{
    int i = 0;
    //ApplicationMenuItem *appMenuItem = [[ApplicationMenuItem alloc] init];
	for (ApplicationMenuItem *record in [ApplicationData sharedInstance].arr_MenuHomeglobalList) {
		
		if(record.thumb_icon)//if(record.tabimg)
		{
            UIButton *button = [buttonArray objectAtIndex:i];
            //[button setBackgroundImage:record.tabimg forState:UIControlStateNormal];
            [button setBackgroundImage:record.thumb_icon forState:UIControlStateNormal];
        }
        else
        {
            UIButton *button = [buttonArray objectAtIndex:i];
            
            //            NSData *imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:record.icon_URL]];
            //            record.thumb_icon = [UIImage imageWithData:imgdata];
            [button setBackgroundImage:record.thumb_icon forState:UIControlStateNormal];
		}
        
		i++;
	}
}

- (IBAction)selecttab:(id)sender {
    [ApplicationData sharedInstance].flag_cov_photo = 0;
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Data.plist"]];
    
    iJoomerAppDelegate *appdelegate =(iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSArray* tabbarViewMenu = [plistDict objectForKey:@"ViewList"];
    int i = 0;
    UIViewController *controller;
    for(NSDictionary *className in tabbarViewMenu)
    {
        Class controllerClass = NSClassFromString([[className allKeys] objectAtIndex:0]);
        
        NSString *key = [[className allKeys] objectAtIndex:0];
        NSArray *arr = [NSArray arrayWithArray:[[tabbarViewMenu objectAtIndex:i] objectForKey:key]];
        
        ApplicationMenuItem *record = [[ApplicationData sharedInstance].arr_MenuHomeglobalList objectAtIndex:[sender tag]];
        
        
        if ([[arr objectAtIndex:1] isEqualToString:record.viewname]) {
            controller = [[controllerClass alloc] init];
            DLog(@"view name : %@",record.viewname);
            controller.title = record.str_itemcaption;
            //controller.title = record.str_itemview;
            if (controllerClass == [iCMSArticleListViewController class]) {
                if (record.itemdata_id > 0) {
                    iCMSCategory *singlecategory = [[iCMSCategory alloc] init];
                    singlecategory.category_id = record.itemdata_id;
                    singlecategory.category_name = record.str_itemcaption;
                    ((iCMSArticleListViewController *)controller).category = singlecategory;
                    ((iCMSArticleListViewController *)controller).catid = record.itemdata_id;
                    ((iCMSArticleListViewController *)controller).isSingleCategory = YES;
                }
                else {
                    ((iCMSArticleListViewController *)controller).catid = record.itemdata_id;
                    ((iCMSArticleListViewController *)controller).isSingleCategory = NO;
                }
            }
            else if (controllerClass == [iCMSArticleDetailViewController class]) {
                iCMSArticle *singleArticle = [[iCMSArticle alloc] init];
                singleArticle.article_id = record.itemdata_id;
                ((iCMSArticleDetailViewController *)controller).articleDetail = singleArticle;
                ((iCMSArticleDetailViewController *)controller).isSingleArticle = YES;
            }
            else if (controllerClass == [MoreViewController class]) {
                appdelegate.SelfViewcontroller = self;
                return;
            }
        }
        i++;
    }
    
    appdelegate.SelfViewcontroller = controller;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

/*- (void)requestCompleted
 {
 
 //[spinner stopAnimating];
 [tabBarLayerView removeFromSuperview];
 
 switch ([ApplicationData sharedInstance].errorCode) {
 case jBadRequest:
 [[ApplicationData sharedInstance]alertjBadRequest];
 //[self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"alert_no_network", @"Network error message")];
 break;
 
 case jLoginRequired:
 
 //[self performSelectorOnMainThread:@selector(sessionExpired) withObject:nil waitUntilDone:YES];
 break;
 
 case jErroronServer:
 [[ApplicationData sharedInstance]alertjErroronServer];
 
 //[self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"alert_body_server", @"Network error message")];
 break;
 
 case jSuccess:
 switch (currentRequestType) {
 case jvmConfigQuery:
 //[self performSelectorOnMainThread:@selector(showWindow) withObject:nil waitUntilDone:TRUE];
 break;
 case jLogoutQuery:
 //[self showAlert:NSLocalizedString(@"logged_out",@"") Content:NSLocalizedString(@"logout_msg", @"")];
 [self performSelectorOnMainThread:@selector(alertview) withObject:nil waitUntilDone:YES];
 [[ApplicationData sharedInstance] logout:self];
 [[ApplicationData sharedInstance]stoptimer];
 [ApplicationData sharedInstance].totalSec = 0;
 [self performSelectorOnMainThread:@selector(openLoginView) withObject:nil waitUntilDone:YES];
 break;
 default:
 break;
 }
 break;
 
 default:
 break;
 }
 }*/

-(void)alertview
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"logged_out",@"") message:NSLocalizedString(@"logout_msg", @"")
												   delegate:self cancelButtonTitle:NSLocalizedString(@"alert_cancel_btn_title",@"") otherButtonTitles: nil];
	[alert setContentMode:UIViewContentModeScaleAspectFit];
	[alert show];
	[alert release];
}

- (void)showAlert:(NSString *)title Content:(NSString *)bodyText
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:bodyText
												   delegate:self cancelButtonTitle:NSLocalizedString(@"alert_cancel_btn_title",@"") otherButtonTitles: nil];
	[alert setContentMode:UIViewContentModeScaleAspectFit];
	[alert show];
	[alert release];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrView {
	int tempPage = scrollView.contentOffset.x/scrollView.frame.size.width;
	if(tempPage > pageNo) {
		[self showNextPage];
	} else if(tempPage < pageNo){
		[self showPreviousPage];
	}
}

//- (void)showNextPage {
//	if(([[ApplicationData sharedInstance].tabList count]/TAB_COUNT) > pageNo) {
//		++pageNo;
//
//		[scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*pageNo, 0) animated:YES];
//
//		if([[ApplicationData sharedInstance].tabList count] == pageNo*TAB_COUNT) {
//
//		}
//	}
//	[pageControl setCurrentPage:pageNo];
//}

- (void)showNextPage {
	if(([[ApplicationData sharedInstance].arr_MenuHomeglobalList count]/icon_count) > pageNo) {
		++pageNo;
        
		[scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*pageNo, 0) animated:YES];
        
		if([[ApplicationData sharedInstance].arr_MenuHomeglobalList count] == pageNo * icon_count) {
            
		}
	}
	[pageControl setCurrentPage:pageNo];
}

- (void)showPreviousPage {
	if(pageNo > 0) {
		--pageNo;
		[scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*pageNo, 0) animated:YES];
	}
	[pageControl setCurrentPage:pageNo];
}

#pragma mark -
#pragma mark dealloc

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    
    iJoomerAppDelegate *appdelegate =(iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    appdelegate.viewTop.hidden = NO;
    appdelegate.btnSlideMenu.hidden = NO;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)iCMSPressed:(id)sender//temp
{
    iCMSArticleListViewController *controller = [[iCMSArticleListViewController alloc] init];
    
    iJoomerAppDelegate *appdelegate =(iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    appdelegate.SelfViewcontroller = controller;
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}
- (IBAction)iCMS1Pressed1:(id)sender//temp
{
    
}
- (IBAction)iCMS2Pressed2:(id)sender//temp
{
    
}

- (IBAction)YesBtnPressed:(id)sender {
    welComeView.hidden = YES;
    ServerSettingsViewController *controller = [[ServerSettingsViewController alloc] init];
    [self.navigationController presentModalViewController:controller animated:NO];
    [controller release];
}

- (IBAction)NoBtnPressed:(id)sender {
    
    
    NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
	NSString *serverURL = [userSettings objectForKey:@"serverurl"];
    if ([serverURL length] > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kServerURL];
        [[NSUserDefaults standardUserDefaults] synchronize];
        iJoomerAppDelegate *appdelegate = (iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
        deleteTable = [iCMS DropAllTabl];
        temp = [appdelegate fetchConfig];
        //        for (UIView *view in scrollView.subviews) {
        //            [view removeFromSuperview];
        //        }
        //
        //        buttonArray = [[NSMutableArray alloc] init];
        //        lblArray = [[NSMutableArray alloc] init];
        //        NSMutableArray *arr = [[NSMutableArray alloc] init];
        //        arr = [appdelegate fetchHomeList];
        //        arr = [appdelegate fetchTabList:@"Home"];
        //        [self setImages];
        [self viewWillAppear:YES];
    }
    
    welComeView.hidden = YES;
}

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
	[backImg release];
	[tabbarMenu release];
    [super dealloc];
}

- (void)startIconDownload:(ApplicationMenuItem *)appRecord {
	IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:[appRecord icon_URL]];
	if (iconDownloader == nil && [[appRecord icon_URL] length] > 0)
	{
		//[spinner startAnimating];
		iconDownloader = [[IconDownloader alloc] init];
		iconDownloader.appRecord = appRecord;
		iconDownloader.delegate = self;
		iconDownloader.imageKey = [appRecord icon_URL];
		[imageDownloadsInProgress setObject:iconDownloader forKey:[appRecord icon_URL]];
		[iconDownloader startDownload];
		[iconDownloader release];
	}
}

- (void)appImageDidLoad:(NSObject *)imageKey {
	[imageDownloadsInProgress removeObjectForKey:imageKey];
	[self setPhotoList];
	if([imageDownloadsInProgress count] == 0) {
		//[spinner stopAnimating];
	}
}

@end
