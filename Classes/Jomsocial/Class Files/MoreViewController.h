//
//  MoreViewController.h
//  iJoomer
//
//  Created by Tailored Solutions on 24/11/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"
#import "RequestResponseManager.h"

@class Tab;
@class TableCellOwner;
@class ApplicationMenuItem;

@interface MoreViewController : UIViewController <UIActionSheetDelegate,UIAlertViewDelegate,IconDownloaderDelegate> //,RequestManagerDelegate
{
	IBOutlet UIImageView *backImg;	
	NSMutableArray *tabbarMenu;
    IBOutlet UIScrollView *scrollView;
    NSMutableArray *buttonArray;
	NSMutableDictionary *imageDownloadsInProgress;
    // int width;
    //int xMargin;
    NSMutableArray *lblArray;
    Tab *tabobj;
    int pageNo;
    int totalPages;
    IBOutlet UIPageControl *pageControl;
    HTTPRequest currentRequestType;
    
    IBOutlet UITableView *tableView;
    TableCellOwner *cellOwner;
    MoreViewController *moreviewcontroller;
    IBOutlet UINavigationBar *titleBar;
    UIImageView *tabBarLayerView;
    
    NSTimeInterval timerStartTime;
    NSTimer *timer;
    IBOutlet UIImageView *imgdefault;
    IBOutlet UIButton *btnClose;
    
    IBOutlet UIView *welComeView;
    IBOutlet UIButton *btnYes;
    IBOutlet UIButton *btnNo;
    
    BOOL deleteTable;
    BOOL temp;
    
    int icon_count;
}

@property(nonatomic, retain)NSMutableDictionary *imageDownloadsInProgress;

@property (nonatomic, retain) IBOutlet UIButton *btniCMS;
@property (nonatomic, retain) IBOutlet UIButton *btniCMS1;//temp
@property (nonatomic, retain) IBOutlet UIButton *btniCMS2;//temp

- (IBAction)iCMSPressed:(id)sender;
- (IBAction)iCMS1Pressed1:(id)sender;//temp
- (IBAction)iCMS2Pressed2:(id)sender;//temp


- (void)themechange;
- (void)setImages;
//- (void)loadImagesForRows;
- (IBAction)selecttab:(id)sender;
- (void)setPhotoList;
- (IBAction)pageChanged:(id)sender;
- (void)showNextPage;
- (void)showPreviousPage;
- (void)getConfig;
- (IBAction)logoutButtonPressed : (id) sender;
- (void)logoutProcess;
- (void)showAlert:(NSString *)title Content:(NSString *)bodyText;
//- (void)openLoginView;
-(void)alertview;

- (IBAction)YesBtnPressed:(id)sender;
- (IBAction)NoBtnPressed:(id)sender;

@end
