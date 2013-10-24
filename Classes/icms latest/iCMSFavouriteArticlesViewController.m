//
//  iCMSFavouriteArticlesViewController.m
//  iJoomer
//
//  Created by tailored on 4/11/13.
//
//

/*
 This controller list Saved articles (local cached).
*/

#import "iCMSFavouriteArticlesViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "iCMSApplicationData.h"
#import "TableCellOwner.h"
#import "iCMSArticleCell.h"
#import "iCMSArticleDetailViewController.h"
#import "iJoomerAppDelegate.h"

@interface iCMSFavouriteArticlesViewController ()

@end

@implementation iCMSFavouriteArticlesViewController

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
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"button_back",@"") style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];

    cellOwner = [[TableCellOwner alloc] init];
    imageDownloadsInProgress = [[NSMutableDictionary alloc] init];
	multipleDownloadRecord = [[NSMutableDictionary alloc] init];
//    self.trackedViewName = @"iCMSFavorite";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    
    //tablist
    //##########################################################################################################
    iJoomerAppDelegate *appdelegate = (iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    arr = [appdelegate fetchTabList:@"IcmsFavouriteArticles"];
    if ([arr count] == 0) {
        isTabbarHidden = YES;
    }
    else {
        isTabbarHidden = NO;
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
    arr = [appdelegate fetchsidemenuList:@"IcmsFavouriteArticles"];
    appdelegate.SelfViewcontroller = self;
    appdelegate.viewTop.hidden = YES;
    [appdelegate TabReset];
//    ##########################################################################################################
    [spinner stopAnimating];
    isViewWillDisAapear = NO;
    [self themeChange];
    [tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    if([[iCMSApplicationData sharedInstance].favoriteArticleList count] < 1)
    {
       [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"No Content Found.", @"")]; 
    }
}

- (void)themeChange {
    backImg.image = [UIImage imageNamed:[iCMSApplicationData sharedInstance].bgImage];
    spinner.backgroundColor = [iCMSApplicationData sharedInstance].textcolor;
}

#pragma mark --
#pragma mark alert & textField

- (void)showAlert:(NSString *)title Content:(NSString *)bodyText {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:bodyText
												   delegate:self cancelButtonTitle:NSLocalizedString(@"alert_cancel_btn_title",@"") otherButtonTitles: nil];
	[alert setContentMode:UIViewContentModeScaleAspectFit];
	[alert show];
	[alert release];
}

-(void)Alert
{
    [self showAlert:@"Server Error" Content:@"Bad Data In Server Response."];
}

#pragma mark -
#pragma mark TableFunctions

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableViewController {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableViewController numberOfRowsInSection:(NSInteger)section {
    if([[iCMSApplicationData sharedInstance].favoriteArticleList count] > 0) {
        tableView.hidden = NO;
        
    } else {
        
        tableView.hidden = YES;
        
    }
    return [[iCMSApplicationData sharedInstance].favoriteArticleList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    iCMSArticleCell *cell = (iCMSArticleCell *)[tableView dequeueReusableCellWithIdentifier:@""];
    
    iCMSArticle *articleObj = [[iCMSApplicationData sharedInstance].favoriteArticleList objectAtIndex:indexPath.row];
    if (cell == nil) {
        [cellOwner loadMyNibFile:@"iCMSArticleCell"];
        cell = (iCMSArticleCell *)cellOwner.cell;
        cell.btnRemove.tag = indexPath.row;
        cell.isFavoriteArticle = YES;
        [cell.btnRemove addTarget:self action:@selector(RemoveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor = [UIColor clearColor];
    }
    if(!articleObj.thumbImg) {
        [self performSelectorOnMainThread:@selector(startIconDownload:) withObject:articleObj waitUntilDone:NO];
    }
    cell.article = articleObj;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell reloadCell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    iCMSArticle *record = [[iCMSApplicationData sharedInstance].favoriteArticleList objectAtIndex:indexPath.row];
    iCMSArticleDetailViewController *controller = [[iCMSArticleDetailViewController alloc] init];
    controller.articleDetail = record;
    controller.currentPageNo = indexPath.row;
    controller.isSingleArticle = NO;
    controller.totalPages = [[iCMSApplicationData sharedInstance].favoriteArticleList count];
    controller.articleList = [iCMSApplicationData sharedInstance].favoriteArticleList;
    [[self navigationController] pushViewController:controller animated:YES];
    [controller release];

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)RemoveButtonPressed:(id)sender {
    iCMSArticle *article = [[iCMSApplicationData sharedInstance].favoriteArticleList objectAtIndex:[sender tag]];
    [iCMSApplicationData sharedInstance].article = article;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Are you sure want to remove %@ from Favorite list?",article.article_title]
                                                   delegate:self cancelButtonTitle:nil
                                          otherButtonTitles:@"Okay",@"Cancel", nil];
    alert.tag = 2;
    [alert show];
    
//    [iCMSApplicationData sharedInstance].article =
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            [[iCMSApplicationData sharedInstance]deleteFromFavoriteList];
        }
        else {
            [iCMSApplicationData sharedInstance].article = nil;
        }
    }
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)viewWillDisappear:(BOOL)animated {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    isViewWillDisAapear = YES;
    if([imageDownloadsInProgress count] > 0) {
        IconDownloader *downloader;
        for(downloader in [imageDownloadsInProgress objectEnumerator]) {
            [downloader cancelDownload];
        }
        [imageDownloadsInProgress removeAllObjects];
    }
    [super viewDidDisappear:animated];
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

- (void)refresh {
    
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
