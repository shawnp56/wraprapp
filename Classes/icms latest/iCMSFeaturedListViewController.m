//
//  iCMSFeaturedListViewController.m
//  iJoomer
//
//  Created by Tailored Solutions on 4/8/13.
//
//

#import "iCMSFeaturedListViewController.h"
#import "PullRefreshTableView.h"
#import "TableCellOwner.h"
#import "iCMSApplicationData.h"
#import "JoomlaRegistration.h"
#import "Core_joomer.h"
#import "iCMSGlobalObject.h"
#import "iCMSArticle.h"
#import "iCMS.h"
#import "iCMSFeaturedArticleListCell.h"
#import "iCMSArticleDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "iJoomerAppDelegate.h"
#import "ApplicationData.h"
#import "ServerSettingsViewController.h"

@interface iCMSFeaturedListViewController ()

@end

@implementation iCMSFeaturedListViewController

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
    
    pageNo = 1;
    spinner.layer.cornerRadius = 4;
    spinner.layer.masksToBounds = YES;
    cellOwner = [[TableCellOwner alloc]init];
    [self.navigationItem setHidesBackButton:YES];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"button_back",@"") style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    self->pullTable = tableView;
    [self addPullToRefreshHeader];
    
    imageDownloadsInProgress = [[NSMutableDictionary alloc] init];
	multipleDownloadRecord = [[NSMutableDictionary alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [self checkNetworkStatus];
    //tablist
    //##########################################################################################################
    iJoomerAppDelegate *appdelegate =(iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    arr = [appdelegate fetchTabList:@"IcmsFeaturedArticles"];
    if ([arr count] == 0) {
        isTabbarHidden = YES;
    }
    else {
        isTabbarHidden = NO;
    }
    arr = [appdelegate fetchsidemenuList:@"IcmsFeaturedArticles"];
    appdelegate.SelfViewcontroller = self;
    appdelegate.viewTop.hidden = YES;
    [appdelegate TabReset];
    //##########################################################################################################
    
//    self.trackedViewName = @"iCMSFeatured";
    isViewWillDisAapear = NO;
    [tableView reloadData];
    [self themechange];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    if ([[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList count] == 0) {
        [spinner startAnimating];
        [self getiCMSFeaturedArticleList];
    }
    else {
        [tableView reloadData];
        [spinner stopAnimating];
    }
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480) {
            if (isTabbarHidden == YES) {
                tableView.frame = CGRectMake(0, 0, 320, 367 + 50);
            }
            else {
                tableView.frame = CGRectMake(0, 0, 320, 367);
            }
        }
        else if(result.height == 568) {
            if (isTabbarHidden == YES) {
                tableView.frame = CGRectMake(0, 0, 320, 455 + 50);
            }
            else {
                tableView.frame = CGRectMake(0, 0, 320, 455);
            } // iPhone 5
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    isViewWillDisAapear = YES;
    if([spinner isAnimating]) {
        [spinner stopAnimating];
        RequestResponseManager *requestManager = [RequestResponseManager sharedInstance];
        [requestManager cancleRequest];
        [requestManager removeRequestProperty:self ExtraInfo:nil];
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

- (void)themechange {

    backImg.image = [UIImage imageNamed:[iCMSApplicationData sharedInstance].bgImage];
    spinner.backgroundColor = [iCMSApplicationData sharedInstance].textcolor;
}

- (void) checkNetworkStatus {
    Reachability* wifiReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
        {
            NSLog(@"Access Not Available");
            break;
        }
            
        case ReachableViaWWAN:
        {
            NSLog(@"Reachable WWAN");
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"Reachable WiFi");
            break;
        }
    }
}

-(void) getiCMSFeaturedArticleList {
    NSMutableDictionary *postVariables = [[NSMutableDictionary alloc] init];
    
    [postVariables setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNO"];
    
    NSDictionary *dict = [iCMS iCMSFeaturedList:@"articles" ExtTask:@"featured" TaskdataDictionary:postVariables Imagedata:nil];
    
    if (!dict) {
        
        [self performSelector:@selector(Alert) withObject:nil afterDelay:0.0];
    }
    else
    {
        currentRequestType = iCMSFeaturedArticleListQuery;
        
        [iCMSApplicationData sharedInstance].errorCode = [[dict objectForKey:TAG_CODE] intValue];
        [iCMSGlobalObject iCMSFeaturedArticleList:dict];
        [self requestCompleted];
    }
    
}
-(void)Alert
{
    [self showAlert:@"Server Error" Content:@"Bad Data In Server Response."];
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
    self.view.userInteractionEnabled = YES;
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
					
				case iCMSFeaturedArticleListQuery:
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
    [tableView reloadData];
}

- (void)refresh {
    if (![iCMSApplicationData sharedInstance].feturedListFlag) {
        
        if (![spinner isAnimating]) {
            [spinner startAnimating];
            self.view.userInteractionEnabled = NO;
            [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList removeAllObjects];
            pageNo = 1;
            timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getiCMSFeaturedArticleList) userInfo:nil repeats:NO];
        }
    }
    else
    {
        isDragging = NO;
        //if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
            // Released above the header
            [self stopLoading];
        //}

    }
}


#pragma mark -
#pragma mark TableFunctions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableViewController {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.row == [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList count]) {
		return 40.0;
	}
	return 155.0;
}

- (NSInteger)tableView:(UITableView *)tableView1 numberOfRowsInSection:(NSInteger)section {

    if ([iCMSApplicationData sharedInstance].totalFeatured > [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList count]) {
        
        return [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList count] + 1;
    }
    return [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList count]) {
        iCMSFeaturedArticleListCell *cell = (iCMSFeaturedArticleListCell *)[tableView dequeueReusableCellWithIdentifier:@"iCMSFeaturedArticleListCell"];
        
        iCMSArticle *articleObj = [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList objectAtIndex:indexPath.row];
        
        if (cell == nil)
        {
            // for calling the custom table view
            [cellOwner loadMyNibFile:@"iCMSFeaturedArticleListCell"];
            cell = (iCMSFeaturedArticleListCell *)cellOwner.cell;
            
        }
        if(!articleObj.thumbImg) {
            [self performSelectorOnMainThread:@selector(startIconDownload:) withObject:articleObj waitUntilDone:NO];
        }
        cell.article = articleObj;
        [cell reloadCell];
        return cell;
    } else {
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.backgroundColor = [iCMSApplicationData sharedInstance].tintColor;
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil]autorelease];
            //cell.backgroundColor = [ApplicationData sharedInstance].themeColor;
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
            cell.textLabel.textColor = [iCMSApplicationData sharedInstance].textcolor;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = NSLocalizedString(@"moreresult_title", @"Get more results...");
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([spinner isAnimating]) {
        return;
    }
    if(indexPath.row  < [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList count]){
        iCMSArticle *record = [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList objectAtIndex:indexPath.row];
        iCMSArticleDetailViewController *controller = [[iCMSArticleDetailViewController alloc] init];
        controller.articleDetail = record;
        controller.currentPageNo = indexPath.row;
        controller.isSingleArticle = NO;
        controller.title = self.title;
        controller.totalPages = [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList count];
        controller.articleList = [iCMSApplicationData sharedInstance].iCMSFeaturedArticleList;
        [[self navigationController] pushViewController:controller animated:YES];
        [controller release];
    } else {
        pageNo = [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList count]/ [iCMSApplicationData sharedInstance].pageLimit;
        pageNo++;
        [self getiCMSFeaturedArticleList];
	}
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
	IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:appRecord.thumbURL];
    if (iconDownloader == nil && [appRecord.thumbURL length] > 0) {
		[spinner startAnimating];
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        iconDownloader.delegate = self;
		iconDownloader.imageKey = appRecord.thumbURL;
		[imageDownloadsInProgress setObject:iconDownloader forKey:appRecord.thumbURL];
        [iconDownloader startDownload];
        [iconDownloader release];
        [multipleDownloadRecord setObject:[[NSMutableArray alloc] initWithObjects:appRecord, nil] forKey:appRecord.thumbURL];
    }
    else {
		NSMutableArray *downloadingRecords = [multipleDownloadRecord objectForKey:appRecord.thumbURL];
		[downloadingRecords addObject:appRecord];
	}
}

- (void)appImageDidLoad:(NSObject *)imageKey {
	[imageDownloadsInProgress removeObjectForKey:imageKey];
    
	NSMutableArray *downloadingRecords = [multipleDownloadRecord objectForKey:imageKey];
   if([downloadingRecords count] > 1) {
    iCMSArticle *record = [downloadingRecords objectAtIndex:0];
       for(id<IconRecord> otherRecord in downloadingRecords) {
        [otherRecord setImage:record.thumbImg ImageKey:imageKey];
            }
        }
	
    [downloadingRecords removeAllObjects];
	[multipleDownloadRecord removeObjectForKey:imageKey];
    if([imageDownloadsInProgress count] == 0) {
		[spinner stopAnimating];
    }
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            self->pullTable.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self->pullTable.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
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
