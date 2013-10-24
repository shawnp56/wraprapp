//
//  ArticleViewController.m
//  iJoomer
//
//  Created by Tailored Solutions on 11/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "iCMSArticleListViewController.h"
#import "iCMSApplicationData.h"
#import "RequestResponseManager.h"
#import "TableCellOwner.h"
#import "JoomlaRegistration.h"
#import "Core_joomer.h"
#import "iCMSGlobalObject.h"
#import "iCMSArticle.h"
#import "iCMSCategory.h"
#import "iCMSArticleCell.h"
#import "iCMSCategoryCell.h"
#import "iCMS.h"
#import "PullRefreshTableView.h"
#import "iCMSArticleDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "iCMSDatabaseObject.h"
#import "iJoomerAppDelegate.h"

//static NSString *kCellIdentifier = @"iCMSArticleCell";
static NSString *kCellIdentifier1 = @"iCMSCategoryCell";

@interface iCMSArticleListViewController ()

@end

@implementation iCMSArticleListViewController

@synthesize category,article,catid,isSingleCategory;

#pragma mark --
#pragma mark viewDidLoad & viewWillAppear

- (id)init {
	self = [super init];
	if(self) {
        
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    spinner.layer.cornerRadius = 4;
    spinner.layer.masksToBounds = YES;
    categorySection = -1;
    articleSection = -1;
	cellOwner = [[TableCellOwner alloc]init];
    self->pullTable = tableView;
    [self addPullToRefreshHeader];
 
	imageDownloadsInProgress = [[NSMutableDictionary alloc] init];
	multipleDownloadRecord = [[NSMutableDictionary alloc] init];
    
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"button_back",@"") style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
	[spinner stopAnimating];
    self.view.userInteractionEnabled = YES;
	pageNo = 1;
//    if(category) {
//        self.title = category.category_name;
//        if (isSingleCategory == YES) {
//            [self getiCMSCagegory];
//        }
//        else {
//            
//            if (category &&[category.subCategories count] == 0 && [category.articles count] == 0) {
//                [self getiCMSCagegory];
//            }
//            
//            else if (category && [category.articles count] == 0) {
//                [category.subCategories removeAllObjects];
//                [self getiCMSCagegory];
//            }
//            else {
//                [tableView reloadData];
//                [spinner stopAnimating];
//                self.view.userInteractionEnabled = YES;
//            }
//        }
//    }
//    else if ([[iCMSApplicationData sharedInstance].iCMSCategoryList count] == 0) {
//        [self getiCMSCagegory];
//    }
//    else if (category &&[category.subCategories count] == 0 && [category.articles count] == 0) {
//        [self getiCMSCagegory];
//    }
//    
//    else if (category && [category.articles count] == 0) {
//        [category.subCategories removeAllObjects];
//        [self getiCMSCagegory];
//    }
//    else {
//        [tableView reloadData];
//        [spinner stopAnimating];
//        self.view.userInteractionEnabled = YES;
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [spinner startAnimating];
    isViewWillDisAapear = NO;
    //tablist
    //##########################################################################################################
    iJoomerAppDelegate *appdelegate = (iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    arr = [appdelegate fetchTabList:@"IcmsAllCategory"];
    if ([arr count] == 0) {
        isTabbarHidden = YES;
    }
    else {
        isTabbarHidden = NO;
    }
    arr = [appdelegate fetchsidemenuList:@"IcmsAllCategory"];
    appdelegate.SelfViewcontroller = self;
    appdelegate.viewTop.hidden = YES;
    [appdelegate TabReset];
    //    ##########################################################################################################
//    self.trackedViewName = @"iCMSCategory";
    [tableView reloadData];
    [self themechange];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
    if(category) {
        self.title = category.category_name;
        if (isSingleCategory == YES) {
            [self getiCMSCagegory];
        }
        else {
            
            if (category &&[category.subCategories count] == 0 && [category.articles count] == 0) {
                [self getiCMSCagegory];
            }
            
            else if (category && [category.articles count] == 0) {
                [category.subCategories removeAllObjects];
                [self getiCMSCagegory];
            }
            else {
                [tableView reloadData];
                [spinner stopAnimating];
                self.view.userInteractionEnabled = YES;
            }
        }
    }
    else if ([[iCMSApplicationData sharedInstance].iCMSCategoryList count] == 0) {
        [self getiCMSCagegory];
    }
    else if (category &&[category.subCategories count] == 0 && [category.articles count] == 0) {
        [self getiCMSCagegory];
    }
    
    else if (category && [category.articles count] == 0) {
        [category.subCategories removeAllObjects];
        [self getiCMSCagegory];
    }
    else {
        [tableView reloadData];
        [spinner stopAnimating];
        self.view.userInteractionEnabled = YES;
    }
}

- (void)themechange {
    backImg.image = [UIImage imageNamed:[iCMSApplicationData sharedInstance].bgImage];
    spinner.backgroundColor = [iCMSApplicationData sharedInstance].textcolor;
}

-(void) getiCMSCagegory {
    
//    if (![spinner isAnimating]) {
        NSMutableDictionary *postVariables = [[NSMutableDictionary alloc] init];
        
        [postVariables setObject:[NSString stringWithFormat:@"%d",catid] forKey:@"id"];
        [postVariables setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNO"];
        
        NSDictionary *dict;
        if (catid != 0) {
            
            dict = [iCMS iCMSArticalListWith_Category:@"categories" ExtTask:@"category" TaskdataDictionary:postVariables Imagedata:nil];
        }
        else {
            dict = [iCMS iCMSCategoryList:@"categories" ExtTask:@"category" TaskdataDictionary:postVariables Imagedata:nil];
        }
        if (!dict) {
            
            [self performSelector:@selector(Alert) withObject:nil afterDelay:0.0];
        }
        else
        {
            currentRequestType = iCMSCategoryListQuery;
            
            [iCMSApplicationData sharedInstance].errorCode = [[dict objectForKey:TAG_CODE] intValue];
            [spinner startAnimating];
            self.view.userInteractionEnabled = NO;
            [iCMSGlobalObject iCMSCategoryList:dict cmsCategory:category];
            [self requestCompleted];
        }
//    }
}

-(void)Alert
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server Error" message:@"Bad Data In Server Response." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)viewWillDisappear:(BOOL)animated {
    isViewWillDisAapear = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if([spinner isAnimating]) {
        [spinner stopAnimating];
        self.view.userInteractionEnabled = YES;
        RequestResponseManager *requestManager = [RequestResponseManager sharedInstance];
        [requestManager cancleRequest];
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

-(void)jBadRequest{
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"alert_no_network", @"Network error message")];
}

-(void)jErroronServer{
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"alert_body_server", @"Network error message")];
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
                    
                case iCMSCategoryListQuery:
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
    if (![iCMSApplicationData sharedInstance].categoryListFlag && ![iCMSApplicationData sharedInstance].articalListFlag)
    {
        self.view.userInteractionEnabled = YES;
        if (!self.category) {
            [[iCMSApplicationData sharedInstance].iCMSCategoryList removeAllObjects];
            [[iCMSApplicationData sharedInstance].iCMSArticleList removeAllObjects];
            catid = 0;
            pageNo = 1;
            [self getiCMSCagegory];
        }
        else {
            [category.subCategories removeAllObjects];
            [category.articles removeAllObjects];
            pageNo = 1;
            [self getiCMSCagegory];
        }
    }
    else
    {
        if (isLoading) return;
        isDragging = YES;
        //isDragging = NO;
        //if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self stopLoading];
        //}

    }
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

#pragma mark -
#pragma mark TableFunctions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableViewController {
    
    
    if (!category) {
        categorySection = 0;
        articleSection = -1;
        if ([[iCMSApplicationData sharedInstance].iCMSCategoryList count] > 0 && [[iCMSApplicationData sharedInstance].iCMSArticleList count] > 0) {
            categorySection = 0;
            articleSection = 1;
            return 2;
        }
        
        else if ([[iCMSApplicationData sharedInstance].iCMSCategoryList count] > 0 && [[iCMSApplicationData sharedInstance].iCMSArticleList count] == 0) {
            categorySection = 0;
            articleSection = -1;
            return 1;
        }
        else if ([[iCMSApplicationData sharedInstance].iCMSCategoryList count] == 0 && [[iCMSApplicationData sharedInstance].iCMSArticleList count] > 0) {
            articleSection = 0;
            categorySection = -1;
            return 1;
        }
        return 1;
    }
    
    if([category.subCategories count] > 0 && [category.articles count] > 0) {
        categorySection = 0;
        articleSection = 1;
        return 2;
    } else if([category.subCategories count] > 0) {
        categorySection = 0;
        articleSection = -1;
    } else if ([category.articles count] > 0){
        articleSection = 0;
        categorySection = -1;
    } else {
        articleSection = -1;
        categorySection = -1;
        return 0;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    float height;
    if (indexPath.section == categorySection)
    {
        return 53;
    }
    
    height = 90;
	if (indexPath.row == [category.articles count]) {
		height = 40.0;
	}
	return height;
}

- (NSInteger)tableView:(UITableView *)tableView1 numberOfRowsInSection:(NSInteger)section {
    
    if (!category) {
        if (section == articleSection) {
            return [[iCMSApplicationData sharedInstance].iCMSArticleList count];
        }
        return [[iCMSApplicationData sharedInstance].iCMSCategoryList count];
    }
    
    if(categorySection == section) {
        return [category.subCategories count];
    }
    int rows = [category.articles count];

    if (category.totalArticles > [category.articles count]) {
		rows = [category.articles count] + 1;
	}    
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.section == categorySection) {
            isCategory = YES;
            iCMSCategoryCell *cell = (iCMSCategoryCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier1];
            iCMSCategory *categoryObj;
            if (!category) {
                categoryObj = [[iCMSApplicationData sharedInstance].iCMSCategoryList objectAtIndex:indexPath.row];
            }
            else {
                categoryObj = [category.subCategories objectAtIndex:indexPath.row];
            }
            if (cell == nil) {
                [cellOwner loadMyNibFile:kCellIdentifier1];
                cell = (iCMSCategoryCell *)cellOwner.cell;
            }
            
            if(!categoryObj.thumbImg) {
                [self performSelectorOnMainThread:@selector(startIconDownload1:) withObject:categoryObj waitUntilDone:NO];
            }
		
        cell.category = categoryObj;
		[cell reloadCell];
            DLog(@"index1 : %d",indexPath.row);
        return cell;
    }
    else if (indexPath.section == articleSection) {
        isCategory = NO;
        iCMSArticleCell *cell = (iCMSArticleCell *)[tableView dequeueReusableCellWithIdentifier:@"iCMSArticleCell"];
         iCMSArticle *articleObj;
        if (category) {
            if(indexPath.row < [category.articles count]) {
                articleObj = [category.articles objectAtIndex:indexPath.row];
            }
            else {
                static NSString *CellIdentifier = @"Cell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                cell.backgroundColor = [iCMSApplicationData sharedInstance].tintColor;
                if (cell == nil) {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil]autorelease];
                    //cell.backgroundColor = [iCMSApplicationData sharedInstance].themeColor;
                    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                    cell.textLabel.textColor = [iCMSApplicationData sharedInstance].textcolor;
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = NSLocalizedString(@"moreresult_title", @"Get more results...");
                
                return cell;
            }
        }
            
        else {
            if (indexPath.row < [[iCMSApplicationData sharedInstance].iCMSArticleList count]) {
                articleObj = [[iCMSApplicationData sharedInstance].iCMSArticleList objectAtIndex:indexPath.row];
            }
            else {
                static NSString *CellIdentifier = @"Cell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                cell.backgroundColor = [iCMSApplicationData sharedInstance].tintColor;
                if (cell == nil) {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil]autorelease];
                    //cell.backgroundColor = [iCMSApplicationData sharedInstance].themeColor;
                    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                    cell.textLabel.textColor = [iCMSApplicationData sharedInstance].textcolor;
                }
                cell.textLabel.text = NSLocalizedString(@"moreresult_title", @"Get more results...");
                return cell;
            }
        }
        
        if (cell == nil) {
                // for calling the custom table view
            [cellOwner loadMyNibFile:@"iCMSArticleCell"];
            cell = (iCMSArticleCell *)cellOwner.cell;
        }
            
        if(!articleObj.thumbImg) {
            [self performSelectorOnMainThread:@selector(startIconDownload:) withObject:articleObj waitUntilDone:NO];
        }
        cell.article = articleObj;
        [cell reloadCell];
        DLog(@"index : %d",indexPath.row);
        return cell;
        
        }
    else {
            
            static NSString *CellIdentifier = @"Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell.backgroundColor = [iCMSApplicationData sharedInstance].tintColor;
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil]autorelease];
                //cell.backgroundColor = [iCMSApplicationData sharedInstance].themeColor;
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                cell.textLabel.textColor = [iCMSApplicationData sharedInstance].textcolor;
            }
            cell.textLabel.text = NSLocalizedString(@"moreresult_title", @"Get more results...");
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
}

- (void)tableView:(UITableView *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([spinner isAnimating]) {
        return;
    }
	if (indexPath.section == categorySection) {
        iCMSCategory *record;
        if (!category) {
            record = [[iCMSApplicationData sharedInstance].iCMSCategoryList objectAtIndex:indexPath.row];
        }
        else {
            record = [category.subCategories objectAtIndex:indexPath.row];
        }
        iCMSArticleListViewController *controller = [[iCMSArticleListViewController alloc] init];
        controller.category = record;
        DLog(@"%d",record.category_id);
        controller.isSingleCategory = NO;
        controller.catid = record.category_id;
        [[self navigationController] pushViewController:controller animated:YES];
        [controller release];
        
    } else
        if (!category){
            if (indexPath.row < [[iCMSApplicationData sharedInstance].iCMSArticleList count]) {
            iCMSArticle *record = [[iCMSApplicationData sharedInstance].iCMSArticleList objectAtIndex:indexPath.row];
                iCMSArticleDetailViewController *controller = [[iCMSArticleDetailViewController alloc] init];
                controller.articleDetail = record;
                controller.currentPageNo = indexPath.row;
                controller.title = self.title;
                controller.totalPages = [[iCMSApplicationData sharedInstance].iCMSArticleList count];
                controller.articleList = [iCMSApplicationData sharedInstance].iCMSArchivedArticleList;
                controller.isSingleArticle = NO;
                [[self navigationController] pushViewController:controller animated:YES];
                [controller release];
            } else {
                pageNo = [[iCMSApplicationData sharedInstance].iCMSArticleList count] / [iCMSApplicationData sharedInstance].pageLimit;
                pageNo++;
                [self getiCMSCagegory];
            }
        } else {
            if (indexPath.row < [category.articles count]) {
                iCMSArticle *record = [category.articles objectAtIndex:indexPath.row];
                iCMSArticleDetailViewController *controller = [[iCMSArticleDetailViewController alloc] init];
                controller.articleDetail = record;
                controller.currentPageNo = indexPath.row;
                controller.totalPages = [category.articles count];
                controller.articleList = category.articles;
                controller.isSingleArticle = NO;
                controller.title = self.title;
                [[self navigationController] pushViewController:controller animated:YES];
                [controller release];
            } else {
                pageNo = [category.articles count] / [iCMSApplicationData sharedInstance].pageLimit;
                pageNo++;
                [self getiCMSCagegory];
            }
        }
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)startIconDownload:(iCMSArticle *)appRecord {
    if (isViewWillDisAapear) {return;}
	IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:appRecord.thumbURL];
    if (iconDownloader == nil && [appRecord.thumbURL length] > 0) {
		[spinner startAnimating];
        
        self.view.userInteractionEnabled = NO;
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

- (void)startIconDownload1:(iCMSCategory *)appRecord {
    if (isViewWillDisAapear) {return;}
	IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:appRecord.thumbURL];
    if (iconDownloader == nil && [appRecord.thumbURL length] > 0) {
		[spinner startAnimating];
        self.view.userInteractionEnabled = NO;
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

#pragma mark --
#pragma mark dealloc


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [super viewDidUnload];
}

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
	[super dealloc];
}

- (void)appImageDidLoad:(NSObject *)imageKey {
	[imageDownloadsInProgress removeObjectForKey:imageKey];

	NSMutableArray *downloadingRecords = [multipleDownloadRecord objectForKey:imageKey];
    if (isCategory == YES) {
        if([downloadingRecords count] > 1) {
            iCMSCategory *record = [downloadingRecords objectAtIndex:0];
            for(id<IconRecord> otherRecord in downloadingRecords) {
                [otherRecord setImage:record.thumbImg ImageKey:imageKey];
            }
        }
        else {
            if([downloadingRecords count] > 1) {
                iCMSArticle *record = [downloadingRecords objectAtIndex:0];
                for(id<IconRecord> otherRecord in downloadingRecords) {
                    [otherRecord setImage:record.thumbImg ImageKey:imageKey];
                }
            }
        }
    }
	
    [downloadingRecords removeAllObjects];
	[multipleDownloadRecord removeObjectForKey:imageKey];
    if([imageDownloadsInProgress count] == 0) {
		[spinner stopAnimating];
        self.view.userInteractionEnabled = YES;
    }
    [tableView reloadData];
    [spinner stopAnimating];
    self.view.userInteractionEnabled = YES;
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
