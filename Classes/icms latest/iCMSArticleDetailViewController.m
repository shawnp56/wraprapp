//
//  iCMSArticleDetailViewController.m
//  iJoomer
//
//  Created by Tailored Solutions on 4/10/13.
//
//

#import "iCMSArticleDetailViewController.h"
#import "iCMSApplicationData.h"
#import "RequestResponseManager.h"
#import "JoomlaRegistration.h"
#import "Core_joomer.h"
#import "iCMSGlobalObject.h"
#import "iCMS.h"
#import "PullRefreshTableView.h"
#import "iCMSArticle.h"
#import "PullRefreshTableView.h"
#import "iCMSArticleSharViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "iJoomerAppDelegate.h"

@interface iCMSArticleDetailViewController ()

@end

@implementation iCMSArticleDetailViewController

@synthesize articleDetail;
@synthesize currentPageNo;
@synthesize totalPages;
@synthesize articleList;
@synthesize isSingleArticle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    spinner.layer.cornerRadius = 4;
    spinner.layer.masksToBounds = YES;
//    iJoomerAppDelegate *appdelegate =(iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
//    NSMutableArray *arr = [[NSMutableArray alloc] init];
//    arr = [appdelegate fetchTabList:@"IcmsSingleArticle"];
//    arr = [appdelegate fetchsidemenuList:@"IcmsSingleArticle"];
//    appdelegate.SelfViewcontroller = self;
    btnFavorite.hidden = NO;
    
    self->pullTable = tableView;
    [self addPullToRefreshHeader];
    
    descWeb.backgroundColor = nil;
    [descWeb setBackgroundColor:[UIColor clearColor]];
    descWeb.delegate = self;
    externalWebView.delegate = self;
    externalView.hidden = YES;
    tableView.tableHeaderView = headerView;
    thumbImg.image = [UIImage imageNamed:@"icms_featured_default_image.png"];
    imageDownloadsInProgress = [[NSMutableDictionary alloc] init];
	multipleDownloadRecord = [[NSMutableDictionary alloc] init];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    
    //tablist
    //##########################################################################################################
    iJoomerAppDelegate *appdelegate = (iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    arr = [appdelegate fetchTabList:@"IcmsSingleArticle"];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480) {
            if ([arr count] > 0) {
                appdelegate.TabView.hidden = NO;
                isTabbarHidden = NO;
                tableView.frame = CGRectMake(0, 0, 320,354);
                externalView.frame = CGRectMake(0, 0, 320,354);
                headerView.frame = CGRectMake(0, 0, 320,354);
            }
            else {
                appdelegate.TabView.hidden = YES;
                isTabbarHidden = YES;
                tableView.frame = CGRectMake(0, 0, 320,354 + 50);
                externalView.frame = CGRectMake(0, 0, 320,354 + 50);
                headerView.frame = CGRectMake(0, 0, 320,354 + 50);
            }
        }
        else if(result.height == 568) {
            if ([arr count] > 0) {
                appdelegate.TabView.hidden = NO;
                isTabbarHidden = NO;
                tableView.frame = CGRectMake(0, 0, 320,454);
                externalView.frame = CGRectMake(0, 0, 320,454);
                headerView.frame = CGRectMake(0, 0, 320,454);
            }
            else {
                appdelegate.TabView.hidden = YES;
                isTabbarHidden = YES;
                tableView.frame = CGRectMake(0, 0, 320,454 + 50);
                externalView.frame = CGRectMake(0, 0, 320,454 + 50);
                headerView.frame = CGRectMake(0, 0, 320,454 + 50);
            }
        }
    }
    arr = [appdelegate fetchsidemenuList:@"IcmsSingleArticle"];
    appdelegate.viewTop.hidden = YES;
    appdelegate.SelfViewcontroller = self;
    [appdelegate TabReset];
    //##########################################################################################################
    
    [self themechange];
    isViewWillDisAapear = NO;
//    self.trackedViewName = @"iArticleDetail";
    [spinner startAnimating];
    if (isSingleArticle == YES) {
        lblPageNo.text = @"1 Of 1";
        [self.navigationItem setHidesBackButton:YES];
    }
    else {
        [self.navigationItem setHidesBackButton:NO];
        // -----------------------------
        // One finger, swipe right
        // -----------------------------
        UISwipeGestureRecognizer *oneFingerSwipeRight =
        [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(movePrev:)] autorelease];
        [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [tableView addGestureRecognizer:oneFingerSwipeRight];
        
        // -----------------------------
        // One finger, swipe left
        // -----------------------------
        UISwipeGestureRecognizer *oneFingerSwipeLeft =
        [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveNext:)] autorelease];
        [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [tableView addGestureRecognizer:oneFingerSwipeLeft];
        
        lblPageNo.text = [NSString stringWithFormat:@"%d Of %d",self.currentPageNo + 1,self.totalPages];
        lblArticleTitle.text = articleDetail.article_title;
        lblAuthorName.text = articleDetail.author;
        lblCategoryName.text = articleDetail.category_title;
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
    if (articleDetail.isDownloaded == NO) {
        self.view.userInteractionEnabled = NO;
        [self getiCMSArticleDetail];    
    }
    else {
        self.view.userInteractionEnabled = YES;
        [self reloadTable];
    }
    [super viewDidAppear:YES];
}

- (void)themechange {
    backImg.image = [UIImage imageNamed:[iCMSApplicationData sharedInstance].bgImage];
    spinner.backgroundColor = [iCMSApplicationData sharedInstance].textcolor;
}

-(void) getiCMSArticleDetail {
    
    NSMutableDictionary *postVariables = [[NSMutableDictionary alloc] init];
    
    [postVariables setObject:[NSString stringWithFormat:@"%d",self.articleDetail.article_id] forKey:@"id"];    
    NSDictionary *dict = [iCMS iCMSArticalDetailviewList:@"articles" ExtTask:@"articleDetail" TaskdataDictionary:postVariables Imagedata:nil articalid:[NSString stringWithFormat:@"%d",self.articleDetail.article_id]];
    DLog(@"post dict : %@",dict);
    if (!dict) {
        [spinner stopAnimating];
        [self performSelector:@selector(Alert) withObject:nil afterDelay:0.0];
    }
    else
    {
        currentRequestType = iCMSArticleDetailQuery;
        
        [iCMSApplicationData sharedInstance].errorCode = [[dict objectForKey:TAG_CODE] intValue];
        [iCMSGlobalObject iCMSArticleDetail:dict Article:articleDetail];
        [self requestCompleted];
    }
}

-(void)Alert {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server Error" message:@"Bad Data In Server Response." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)jBadRequest{
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"Wrong Data.", @"")];
}

-(void)jErroronServer{
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"Server Error.", @"")];
}

-(void)jErrorMessage{
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:@"No Such Request Found."];
}
-(void)jNoContent{
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"No Content Found.", @"")];
}

-(void)jUnsupportedFile {
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"Unsupported File Type.", @"")];
}

-(void)jInvalidData {
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"Upload Limit Exceeded.", @"")];
}

-(void)jUserNameError {
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"Username Already Exists.", @"")];
}

-(void)jEmailError {
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"Email Already Exists.", @"")];
}

-(void)jFBOption {
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"Facebook User Not Found.", @"")];
}

-(void)jReportedContent {
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"Permission Denied.", @"")];
}

-(void)JPermissionError {
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"Restricted Access.", @"")];
}

-(void)jDuplicateData {
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"Request already exists.", @"")];
}

-(void)jWaitingForPermission {
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"Awaiting approval.", @"")];
}

- (void)requestCompleted {
    [spinner stopAnimating];
	switch ([iCMSApplicationData sharedInstance].errorCode) {
            
        case jBadRequest:
            [self performSelectorOnMainThread:@selector(jBadRequest) withObject:nil waitUntilDone:NO];
			break;
            
		case jLoginRequired:
			break;
            
		case jErroronServer:
            [self performSelectorOnMainThread:@selector(jErrorMessage) withObject:nil waitUntilDone:NO];
			break;
            
        case jNoContent:
            [self performSelectorOnMainThread:@selector(jNoContent) withObject:nil waitUntilDone:NO];
			break;
            
        case jErrorMessage:
            [self performSelectorOnMainThread:@selector(jErrorMessage) withObject:nil waitUntilDone:NO];
			break;
            
        case jUnsupportedFile:
            [self performSelectorOnMainThread:@selector(jUnsupportedFile) withObject:nil waitUntilDone:NO];
			break;
            
        case jInvalidData:
            [self performSelectorOnMainThread:@selector(jInvalidData) withObject:nil waitUntilDone:NO];
			break;
            
        case jUserNameError:
            [self performSelectorOnMainThread:@selector(jUserNameError) withObject:nil waitUntilDone:NO];
			break;
            
        case jEmailError:
            [self performSelectorOnMainThread:@selector(jEmailError) withObject:nil waitUntilDone:NO];
			break;
            
        case jFBOption:
            [self performSelectorOnMainThread:@selector(jFBOption) withObject:nil waitUntilDone:NO];
			break;
            
        case jSessionExpire:
			break;
            
        case jReportedContent:
            [self performSelectorOnMainThread:@selector(jReportedContent) withObject:nil waitUntilDone:NO];
			break;
            
        case JPermissionError:
            [self performSelectorOnMainThread:@selector(JPermissionError) withObject:nil waitUntilDone:NO];
			break;
            
        case jDuplicateData:
            [self performSelectorOnMainThread:@selector(jDuplicateData) withObject:nil waitUntilDone:NO];
			break;
            
        case jWaitingForPermission:
            [self performSelectorOnMainThread:@selector(jWaitingForPermission) withObject:nil waitUntilDone:NO];
			break;
            
		case jSuccess:
			switch (currentRequestType) {
					
				case iCMSArticleDetailQuery:
                    [self stopLoading];
                    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:NO];
					break;
				default:
					break;
			}
        default:
            break;
    }
}

- (void) reloadTable {
    if (articleDetail.full_img) {
        thumbImg.image = articleDetail.full_img;
    }
    else {
        [self performSelectorOnMainThread:@selector(startIconDownload:) withObject:articleDetail waitUntilDone:NO];
    }
    articleDetail.isDownloaded = YES;
    lblArticleTitle.text = articleDetail.article_title;
    lblAuthorName.text = articleDetail.author;
    lblCategoryName.text = articleDetail.category_title;
    
    NSArray *fullDate = [articleDetail.created_date componentsSeparatedByString:@" "];
    
    NSString *date = [fullDate objectAtIndex:0];
    
    NSArray *displayDate = [date componentsSeparatedByString:@"-"];
    lblDate.text = [NSString stringWithFormat:@"%@/%@/%@",[displayDate objectAtIndex:1],[displayDate objectAtIndex:2],[displayDate objectAtIndex:0]];
    
    

    NSArray *myArray = [articleDetail.article_desc componentsSeparatedByString:@"<iframe"];
    
    NSString *strtemp;
    if ([myArray count] > 1) {
        
        NSArray *myarray1 = [[myArray lastObject] componentsSeparatedByString:@"</iframe></p>"];
        
        NSArray *myarray2 = [[myarray1 objectAtIndex:0] componentsSeparatedByString:@"width=\""];
        
        NSArray *myarray3 = [[myarray2 lastObject] componentsSeparatedByString:@"\" height=\""];
        
        NSString *subString = [[myarray3 lastObject] substringWithRange: NSMakeRange(0, [[myarray3 lastObject] rangeOfString: @"\""].location)];
        
        NSArray *myarray4 = [[myarray3 lastObject] componentsSeparatedByString:subString];
        
        strtemp = [NSString stringWithFormat:@"%@ <iframe width=\"100%%\" height=\"auto%@",[myArray objectAtIndex:0],[myarray4 lastObject]];
        }
    else {
        strtemp = articleDetail.article_desc;
    }
    
    [descWeb removeFromSuperview];
    descWeb = [[UIWebView alloc]init];
    descWeb.delegate = self;
    descWeb.tag = 1;
    [descWeb setOpaque:NO];
    [descWeb setBackgroundColor:[UIColor clearColor]];
    descWeb.frame = CGRectMake(3, 297, 314, 68);
    [descWeb loadHTMLString:[NSString stringWithFormat:@"%@",strtemp] baseURL:nil];
    [scrollView addSubview:descWeb];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    
    if (aWebView.tag == 1) {
        CGFloat height = [[aWebView stringByEvaluatingJavaScriptFromString:@"document.height"] floatValue];
        
        CGFloat width = 320;
        CGRect frame = aWebView.frame;
        frame.size.height = height;
        frame.size.width = width;
        aWebView.frame = frame;
        [scrollView setContentSize:CGSizeMake(width, height + 350)];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480) {
                if (isTabbarHidden == YES) {
                    scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, 320, 425 + 50);
                }
                else {
                    scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, 320, 425);
                }
            }
            if(result.height == 568) {
                if (isTabbarHidden ==YES) {
                    scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, 320, 475 + 50);
                }
                else {
                    scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, 320, 475);
                }
            }
        }
//        tableView.tableHeaderView = nil;
//        tableView.tableHeaderView = headerView;
        [tableView reloadData];
        DLog(@"size: %f, %f", width, height + 350);
    }
    [spinner stopAnimating];
    self.view.userInteractionEnabled = YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    DLog(@"tag:%d",webView.tag);
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {

        [spinner startAnimating];
        NSString *internalLink = request.URL.absoluteString;
        NSString *option = @"com_content";
        
        if ([internalLink rangeOfString:option].location == NSNotFound) {
            externalView.hidden = NO;
            [externalWebView loadRequest:request];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonPressed)];
            [self.navigationItem setHidesBackButton:YES];
            
        }
        else {
            externalView.hidden = YES;
            [self.navigationItem setHidesBackButton:NO];
            NSString *articleUrl = [internalLink lastPathComponent];
            NSString *articleID = [articleUrl substringFromIndex:[articleUrl length] - 3];
            iCMSArticle *internalArticle = [[iCMSArticle alloc] init];
            internalArticle.article_id =[[NSString stringWithFormat:@"%@",articleID] intValue];
            DLog(@"internal id : %d",internalArticle.article_id);
            self.navigationItem.leftBarButtonItem =  nil;
            iCMSArticleDetailViewController *controller = [[iCMSArticleDetailViewController alloc] init];
            controller.articleDetail = internalArticle;
            controller.isSingleArticle = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [spinner stopAnimating];
    self.view.userInteractionEnabled = YES;
}

- (void) closeButtonPressed {
    if ([spinner isAnimating]) {
        return;
    }
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:NO];
    externalView.hidden = YES;
    NSArray *myArray = [articleDetail.article_desc componentsSeparatedByString:@"<iframe"];
    NSString *strtemp;
    if ([myArray count] > 1) {
        NSArray *myarray1 = [[myArray lastObject] componentsSeparatedByString:@"</iframe></p>"];
        NSArray *myarray2 = [[myarray1 objectAtIndex:0] componentsSeparatedByString:@"width=\""];
        NSArray *myarray3 = [[myarray2 lastObject] componentsSeparatedByString:@"\" height=\""];
        NSString *subString = [[myarray3 lastObject] substringWithRange: NSMakeRange(0, [[myarray3 lastObject] rangeOfString: @"\""].location)];
        NSArray *myarray4 = [[myarray3 lastObject] componentsSeparatedByString:subString];
        strtemp = [NSString stringWithFormat:@"%@ <iframe width=\"100%%\" height=\"auto%@",[myArray objectAtIndex:0],[myarray4 lastObject]];
    }
    else {
        strtemp = articleDetail.article_desc;
    }
    [descWeb removeFromSuperview];
    descWeb = [[UIWebView alloc]init];
    descWeb.delegate = self;
    descWeb.tag = 1;
    [descWeb setOpaque:NO];
    [descWeb setBackgroundColor:[UIColor clearColor]];
    descWeb.frame = CGRectMake(3, 297, 314, 68);
    [descWeb loadHTMLString:[NSString stringWithFormat:@"%@",strtemp] baseURL:nil];
    [scrollView addSubview:descWeb];
}

- (IBAction) movePrev:(id)sender {
//    DLog(@"currr page : %d",self.currentPageNo);
    if (self.currentPageNo >= 1) {
        btnFavorite.hidden = NO;
        thumbImg.image = [UIImage imageNamed:@"icms_featured_default_image.png"];
        
        [UIView beginAnimations:nil context:NULL]; {
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.0];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromLeft];
            [animation setFillMode:kCAFillModeBoth];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
            [[self.view layer] addAnimation:animation forKey:@""];
            [UIView setAnimationDuration:1.0];
            self.view.alpha = 1.0;
            } [UIView commitAnimations];
        self.currentPageNo -= 1;
        self.articleDetail = [articleList objectAtIndex:currentPageNo];
        lblArticleTitle.text = self.articleDetail.article_title;
        lblAuthorName.text = self.articleDetail.author;
        lblPageNo.text = [NSString stringWithFormat:@"%d Of %d",self.currentPageNo + 1,self.totalPages];
        if (articleDetail.isDownloaded == NO) {
            [spinner startAnimating];
            self.view.userInteractionEnabled = NO;
            timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getiCMSArticleDetail) userInfo:nil repeats:NO];
        }
        else {
            [self reloadTable];
        }
    }
}

- (IBAction) moveNext:(id)sender {
    if (self.currentPageNo < [articleList count] - 1) {
        btnFavorite.hidden = NO;
        thumbImg.image = [UIImage imageNamed:@"icms_featured_default_image.png"];
        
        self.currentPageNo += 1;
        [spinner startAnimating];
        [UIView beginAnimations:nil context:NULL]; {
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.0];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromRight];
            [animation setFillMode:kCAFillModeBoth];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
            [[self.view layer] addAnimation:animation forKey:@""];
            [UIView setAnimationDuration:1.0];
            self.view.alpha = 1.0;
        } [UIView commitAnimations];
        self.articleDetail = [articleList objectAtIndex:currentPageNo];
        lblArticleTitle.text = self.articleDetail.article_title;
        lblAuthorName.text = self.articleDetail.author;
        lblPageNo.text = [NSString stringWithFormat:@"%d Of %d",self.currentPageNo + 1,self.totalPages];
        if (articleDetail.isDownloaded == NO) {
            [spinner startAnimating];
             self.view.userInteractionEnabled = NO;
             timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getiCMSArticleDetail) userInfo:nil repeats:NO];
        }
        else {
            [self reloadTable];
        }
    }
}

- (void)refresh {
    if (![spinner isAnimating]) {
        [spinner startAnimating];
        btnFavorite.hidden = NO;
        self.view.userInteractionEnabled = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getiCMSArticleDetail) userInfo:nil repeats:NO];
    }
}

#pragma mark -
#pragma mark TableFunctions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableViewController {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 30.0;
}

- (NSInteger)tableView:(UITableView *)tableView1 numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

#pragma mark -
#pragma mark alert

- (void)showAlert:(NSString *)title Content:(NSString *)bodyText {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:bodyText
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert setContentMode:UIViewContentModeScaleAspectFit];
	[alert show];
    
	[alert release];
}

- (void)startIconDownload:(iCMSArticle *)appRecord {
    if (isViewWillDisAapear) {return;}
	IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:appRecord.image_fulltext];
    if (iconDownloader == nil && [appRecord.image_fulltext length] > 0) {
        [spinner startAnimating];
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        iconDownloader.delegate = self;
		iconDownloader.imageKey = appRecord.image_fulltext;
        [imageDownloadsInProgress setObject:iconDownloader forKey:appRecord.image_fulltext];
        [iconDownloader startDownload];
        [iconDownloader release];
    }
}

- (void)appImageDidLoad:(NSObject *)imageKey {
	[imageDownloadsInProgress removeObjectForKey:imageKey];
    [tableView reloadData];
	if([imageDownloadsInProgress count] == 0) {
		[spinner stopAnimating];
        if(articleDetail.full_img){
            [thumbImg setImage:articleDetail.full_img];
        }
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [headerView release];
    [scrollView release];
    [lblDate release];
    [lblCategoryName release];
    [lblPageNo release];
    [lblArticleTitle release];
    [articleBackimg release];
    [thumbImg release];
    [lblAuthorName release];
    [btnFavorite release];
    [btnShare release];
    [shareView release];
    descWeb.delegate = nil;
    externalWebView.delegate = nil;
//    [externalView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [headerView release];
    headerView = nil;
    [scrollView release];
    scrollView = nil;
    [lblDate release];
    lblDate = nil;
    [lblCategoryName release];
    lblCategoryName = nil;
    [lblPageNo release];
    lblPageNo = nil;
    [lblArticleTitle release];
    lblArticleTitle = nil;
    [articleBackimg release];
    articleBackimg = nil;
    [thumbImg release];
    thumbImg = nil;
    [lblAuthorName release];
    lblAuthorName = nil;
    [btnFavorite release];
    btnFavorite = nil;
    [btnShare release];
    btnShare = nil;
    [shareView release];
    shareView = nil;
    [descWeb release];
    descWeb.delegate = nil;
    descWeb = nil;
    [externalWebView release];
    externalWebView.delegate = nil;
    externalWebView = nil;
    [externalView release];
    externalView = nil;
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    isViewWillDisAapear = YES;
    if([spinner isAnimating]) {
        RequestResponseManager *requestManager = [RequestResponseManager sharedInstance];
        [requestManager cancleRequest];
        //[requestManager removeRequestProperty:self ExtraInfo:nil];
    }
    
    if([imageDownloadsInProgress count] > 0) {
        IconDownloader *downloader;
        for(downloader in [imageDownloadsInProgress objectEnumerator]) {
            [downloader cancelDownload];
        }
        [imageDownloadsInProgress removeAllObjects];
    }
    [super viewDidDisappear:animated];
}

- (IBAction)FavoriteButtonPressed:(id)sender {
    iCMSArticle *newArticle = [[iCMSArticle alloc] init];
    newArticle.article_id = articleDetail.article_id;
    newArticle.article_title = articleDetail.article_title;
    newArticle.introtext = articleDetail.introtext;
    newArticle.thumbURL = articleDetail.thumbURL;
    
    [iCMSApplicationData sharedInstance].article = newArticle;
    
    BOOL isUpdated = NO;
    
    for (iCMSArticle *favArticle in [iCMSApplicationData sharedInstance].favoriteArticleList) {
        if (favArticle.article_id == newArticle.article_id) {
            
            isUpdated = YES;
        }
    }
    if (isUpdated == NO) {
        [[iCMSApplicationData sharedInstance] addToFavoritList];
    }
    
    [self showAlert:NSLocalizedString(@"",@"") Content:NSLocalizedString(@"Article added as favourite", @"success message")];
    
    btnFavorite.hidden = YES;
}

- (IBAction)ShareButtonPressed:(id)sender {
    iCMSArticleSharViewController *controller = [[iCMSArticleSharViewController alloc] init];
    controller.share_title = articleDetail.article_title;
    controller.share_link = articleDetail.shareLink;
    [self.navigationController presentModalViewController:controller animated:YES];
    [controller release];
}

///------------------------------- Pull down to Refresh start ---------------------------------///


- (void)addPullToRefreshHeader {
    textPull = [[NSString alloc] initWithString:@"Pull down to refresh..."];
    textRelease = [[NSString alloc] initWithString:@"Release to refresh..."];
    textLoading = [[NSString alloc] initWithString:@"Loading..."];
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pullTable.frame.size.width, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textColor = [iCMSApplicationData sharedInstance].textcolor;//[UIColor whiteColor];
    refreshLabel.textAlignment = UITextAlignmentCenter;
    
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowpull.png"]];
    [refreshArrow setContentMode:UIViewContentModeCenter];
    refreshArrow.frame = CGRectMake((REFRESH_HEADER_HEIGHT - 27) / 2,
                                    (REFRESH_HEADER_HEIGHT - 44) / 2,
                                    27, 44);
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [self->pullTable addSubview:refreshHeaderView];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView1 {
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView1.contentOffset.y > 0)
            self->pullTable.contentInset = UIEdgeInsetsZero;
        else if (scrollView1.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self->pullTable.contentInset = UIEdgeInsetsMake(-scrollView1.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView1.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        if (scrollView1.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
            // User is scrolling above the header
            refreshLabel.text = self->textRelease;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        } else { // User is scrolling somewhere within the header
            refreshLabel.text = self->textPull;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
        }
        [UIView commitAnimations];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView1 willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView1.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading {
    isLoading = YES;
    
    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self->pullTable.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
    refreshLabel.text = self->textLoading;
    refreshArrow.hidden = YES;
    [refreshSpinner startAnimating];
    [UIView commitAnimations];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading {
    isLoading = NO;
    
    // Hide the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    self->pullTable.contentInset = UIEdgeInsetsZero;
    [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    [UIView commitAnimations];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    // Reset the header
    refreshLabel.text = self->textPull;
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
}

///------------------------------- Pull down to Refresh end ---------------------------------///

@end
