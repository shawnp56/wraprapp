//
//  iCMSArticleSharViewController.m
//  iJoomer
//
//  Created by Tailored Solutions on 4/11/13.
//
//

#import "iCMSArticleSharViewController.h"
#import "iCMSApplicationData.h"
#import "RequestResponseManager.h"
#import "JoomlaRegistration.h"
#import "Core_joomer.h"
#import "iCMSGlobalObject.h"
#import "iCMS.h"
#import "Option.h"
#import "TableCellOwner.h"
#import "iCMSEmailListCell.h"
#import <QuartzCore/QuartzCore.h>
#import "FindFirstResponder.h"
//#import "ParseManager.h"
#import "User.h"
#import "iJoomerAppDelegate.h"

@interface iCMSArticleSharViewController ()

@end

@implementation iCMSArticleSharViewController

BOOL status = NO;

//@synthesize article;
@synthesize share_title;
@synthesize share_link;
@synthesize share_photo_url;

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
//     [self getPhoneBook];
    spinner.layer.cornerRadius = 4;
    spinner.layer.masksToBounds = YES;

    shareView.hidden = YES;
    int y = shareView.frame.origin.y;
    int x = shareView.frame.origin.x;
    
    EmailView.frame = CGRectMake(x, y,EmailView.frame.size.width,369);

    txtEmailBody.delegate = self;
    textEmail.delegate = self;
//    self.trackedViewName = @"iShareArticle";
    cellOwner = [[TableCellOwner alloc] init];
    cellArray = [[NSMutableDictionary alloc] init];
    ContactView.hidden = YES;
    CALayer *shareText = [txtShare layer];
	[shareText setMasksToBounds:YES];
	[shareText setCornerRadius:5.0];
	[shareText setBorderWidth:0.5];
	[shareText setBorderColor:[[UIColor clearColor] CGColor]];
    
    CALayer *email = [textEmail layer];
	[email setMasksToBounds:YES];
	[email setCornerRadius:5.0];
	[email setBorderWidth:0.5];
	[email setBorderColor:[[ApplicationData sharedInstance].textcolor CGColor]];
    
    CALayer *emailBody = [txtEmailBody layer];
	[emailBody setMasksToBounds:YES];
	[emailBody setCornerRadius:5.0];
	[emailBody setBorderWidth:0.5];
	[emailBody setBorderColor:[[ApplicationData sharedInstance].textcolor CGColor]];
    
    CALayer *shareBack = [shaveViewBackImg layer];
	[shareBack setMasksToBounds:YES];
	[shareBack setCornerRadius:5.0];
	[shareBack setBorderWidth:0.5];
	[shareBack setBorderColor:[[ApplicationData sharedInstance].textcolor CGColor]];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [spinner stopAnimating];
    [btnTwitter setSelected:NO];
    [btnFacebook setSelected:NO];
    //tablist
    //##########################################################################################################
    iJoomerAppDelegate *appdelegate = (iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    [self themechange];
    
//    NSMutableArray *arr = [[NSMutableArray alloc] init];
//    arr = [appdelegate fetchTabList:@"xyz"];
//    arr = [appdelegate fetchsidemenuList:@"xyz"];
    appdelegate.TabView.hidden = YES;
//    [appdelegate TabReset];
    appdelegate.viewTop.hidden = YES;
    //##########################################################################################################
}

- (void)themechange {
    backImg.image = [UIImage imageNamed:[ApplicationData sharedInstance].bgImage];
    spinner.backgroundColor = [ApplicationData sharedInstance].textcolor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [backImg release];
    [btnFacebook release];
    [btnTwitter release];
    [btnLoadEmailAddress release];
    [btnDismiss release];
    [btnFTCancle release];
    [txtShare release];
    [btnEmailCancel release];
    [btnEmailSend release];
    [EmailView release];
    [txtEmailBody release];
    [textEmail release];
    [ContactView release];
    [btnHideContent release];
    [btnSelectEmilAdd release];
    [btnFTShare release];
    [btnSelectAllContact release];
    [btnDeSelectAllContact release];
    [super dealloc];
}
- (void)viewDidUnload {
    [backImg release];
    backImg = nil;
    [btnFacebook release];
    btnFacebook = nil;
    [btnTwitter release];
    btnTwitter = nil;
    [btnLoadEmailAddress release];
    btnLoadEmailAddress = nil;
    [btnDismiss release];
    btnDismiss = nil;
    [btnFTCancle release];
    btnFTCancle = nil;
    [txtShare release];
    txtShare = nil;
    [btnEmailCancel release];
    btnEmailCancel = nil;
    [btnEmailSend release];
    btnEmailSend = nil;
    [EmailView release];
    EmailView = nil;
    [txtEmailBody release];
    txtEmailBody = nil;
    [textEmail release];
    textEmail = nil;
    [ContactView release];
    ContactView = nil;
    [btnHideContent release];
    btnHideContent = nil;
    [btnSelectEmilAdd release];
    btnSelectEmilAdd = nil;
    [btnFTShare release];
    btnFTShare = nil;
    [btnSelectAllContact release];
    btnSelectAllContact = nil;
    [btnDeSelectAllContact release];
    btnDeSelectAllContact = nil;
    [super viewDidUnload];
}
- (IBAction)FacebookButtonPressed:(id)sender {
    if (!btnFacebook.isSelected) {
        [btnFacebook setSelected:YES];
        [btnTwitter setSelected:NO];
    }
    shareView.hidden = NO;
    isFacebook = YES;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480) {
            EmailView.frame = CGRectMake(5,198,EmailView.frame.size.width,262);
            txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x, 60.0, txtEmailBody.frame.size.width, 150.0);
            // iPhone Classic
        }
        if(result.height == 568) {
            EmailView.frame = CGRectMake(5,198,EmailView.frame.size.width,350);
            txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x, 60.0, txtEmailBody.frame.size.width, 230.0);
            // iPhone 5
        }
    }
}

- (IBAction)TwitterButtonPressed:(id)sender {
    if (!btnTwitter.isSelected) {
        [btnTwitter setSelected:YES];
        [btnFacebook setSelected:NO];
    }
    shareView.hidden = NO;
    isFacebook = NO;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480) {
            EmailView.frame = CGRectMake(5,198,EmailView.frame.size.width,262);
            txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x, 60.0, txtEmailBody.frame.size.width, 150.0);
            // iPhone Classic
        }
        else if(result.height == 568) {
            EmailView.frame = CGRectMake(5,198,EmailView.frame.size.width,350);
            txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x, 60.0, txtEmailBody.frame.size.width, 230.0);
            // iPhone 5
        }
    }
}

- (IBAction)LoadEmailButtonPressed:(id)sender {
    [btnSelectAllContact setImage:[UIImage imageNamed:@"radio_off.png"] forState:UIControlStateNormal];
    [btnDeSelectAllContact setImage:[UIImage imageNamed:@"radio_off.png"] forState:UIControlStateNormal];
    [[ApplicationData sharedInstance].contactsArray removeAllObjects];
    [[textEmail findFirstResponder]resignFirstResponder];
   [self getPhoneBook];
	[tableView reloadData];
    ContactView.hidden = NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 2) {
        [btnTwitter setSelected:NO];
        [btnFacebook setSelected:NO];
        [UIView beginAnimations:nil context:NULL]; {
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDuration:0.3];
            shareView.hidden = YES;
            int y = shareView.frame.origin.y;
            int x = shareView.frame.origin.x;
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                CGSize result = [[UIScreen mainScreen] bounds].size;
                if(result.height == 480) {
                    EmailView.frame = CGRectMake(x, y,EmailView.frame.size.width,369);
                    //                txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x, 0.0, txtEmailBody.frame.size.width, 150.0);
                    // iPhone Classic
                }
                if(result.height == 568) {
                    EmailView.frame = CGRectMake(x, y,EmailView.frame.size.width,369);
                    //                txtEmailBody.frame = CGRectMake(0.0, 0.0, txtEmailBody.frame.size.width, 230.0);
                    // iPhone 5
                }
            }
            
        } [UIView commitAnimations];
    }
}

#pragma mark -
#pragma mark dismissing keyboard

- (BOOL)textFieldShouldReturn: (UITextField *)textField {
    if (textField.tag == 2) {
        
        shareView.hidden = YES;
        int y = shareView.frame.origin.y;
        int x = shareView.frame.origin.x;
        
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480) {
            EmailView.frame = CGRectMake(x, y,EmailView.frame.size.width,369);
            txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x,60.0, txtEmailBody.frame.size.width, 250);
            // iPhone Classic
        }
        if(result.height == 568) {
            EmailView.frame = CGRectMake(x, y,EmailView.frame.size.width,460);
            txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x,60.0, txtEmailBody.frame.size.width, 340);
            // iPhone 5
        }
    }
    [textField resignFirstResponder];
	return YES;
}

-(void) textViewDidBeginEditing:(UITextView *)textView{
    shareView.hidden = YES;
    [btnTwitter setSelected:NO];
    [btnFacebook setSelected:NO];
    int y = shareView.frame.origin.y;
    int x = shareView.frame.origin.x;
    
    [UIView beginAnimations:nil context:NULL]; {
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:0.5];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480) {
                
                EmailView.frame = CGRectMake(x, y,EmailView.frame.size.width,369);
                txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x, 0.0, txtEmailBody.frame.size.width, 150.0);
                // iPhone Classic
            }
            if(result.height == 568) {
                EmailView.frame = CGRectMake(x, y,EmailView.frame.size.width,369);
                txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x, 0.0, txtEmailBody.frame.size.width, 230.0);
                // iPhone 5
            }
        }
        txtEmailBody.backgroundColor = [UIColor whiteColor];
    } [UIView commitAnimations];
}

#pragma mark --
#pragma mark buttonPressed


- (IBAction)DismissButtonPressed:(id)sender {
    if (![spinner isAnimating]) {
        shareView.hidden = YES;
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)CancelFTShareButtonPressed:(id)sender {
    shareView.hidden = YES;
    [btnFacebook setSelected:NO];
    [btnTwitter setSelected:NO];

    int y = shareView.frame.origin.y;
    int x = shareView.frame.origin.x;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480) {
            EmailView.frame = CGRectMake(x, y,EmailView.frame.size.width,369);
            txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x,60.0, txtEmailBody.frame.size.width, 250);
            // iPhone Classic
        }
        if(result.height == 568) {
            EmailView.frame = CGRectMake(x, y,EmailView.frame.size.width,460);
            txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x,60.0, txtEmailBody.frame.size.width, 340);
            // iPhone 5
        }
    }

}

- (IBAction)CancelEmailButtonPressed:(id)sender {
    textEmail.text = @"";
    txtEmailBody.text = @"";
    txtShare.text = @"";
    shareView.hidden = YES;
    ContactView.hidden = YES;
    [ApplicationData sharedInstance].isViewDidload = NO;

    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)EmailSendButtonPressed:(id)sender {
    if ([textEmail.text length] == 0) {
        return;
    }
    
	NSArray *temp = [textEmail.text componentsSeparatedByString:@","];
	MFMailComposeViewController *mailView =	[[[MFMailComposeViewController alloc] init] autorelease];
	mailView.mailComposeDelegate = self;
//	[mailView setSubject:[NSString stringWithFormat:@"IjoomerAdvance Email : %@",article.article_title]];
    [mailView setSubject:[NSString stringWithFormat:@"IjoomerAdvance Email : %@",self.share_title]];
	mailView.navigationController.navigationBar.tintColor = [ApplicationData sharedInstance].tintColor;
	if ([temp count] == 1) {
        [mailView setToRecipients:temp];
    }
    else if ([temp count] > 1) {
        
        NSArray *first = [NSArray arrayWithObject:[temp objectAtIndex:0]];
        
        [mailView setToRecipients:first];
        NSMutableArray *bccList = [NSMutableArray arrayWithArray:temp];
        
        [bccList removeObjectAtIndex:0];
        [mailView setBccRecipients:bccList];
    }
    
//    [mailView setMessageBody:[NSString stringWithFormat:@"%@ \n\n saw this is story on the Ijoomer Advance and thought you should see it. \n\n Best article \n\n This is test \n\n %@ \n ** Try iJoomer Advence Now :: Its Free ** More information can be found at www.ijoomer.com",txtEmailBody.text,article.shareLink] isHTML:YES];
    [mailView setMessageBody:[NSString stringWithFormat:@"%@ \n\n saw this is story on the Ijoomer Advance and thought you should see it. \n\n Best article \n\n This is test \n\n %@ \n ** Try iJoomer Advence Now :: Its Free ** More information can be found at www.ijoomer.com",txtEmailBody.text,share_link] isHTML:YES];

    [self performSelectorOnMainThread:@selector(mailSentSuccessAlert) withObject:nil waitUntilDone:NO];
	[self presentModalViewController:mailView animated:YES];
}

- (void) mailSentSuccessAlert {
    [self showAlert:NSLocalizedString(@"alert_success", @"title") Content:NSLocalizedString(@"Email_sent", @"alert body")];
}

#pragma mark -
#pragma mark mail delegate methods

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	if (error) {
		NSString *errorTitle = NSLocalizedString(@"mail_error", @"");
		NSString *errorDescription = [error localizedDescription];
 		UIAlertView *errorView = [[UIAlertView alloc]initWithTitle:errorTitle message:errorDescription delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_title", @""), nil];
		[errorView show];
		[errorView release];
	}
	[controller dismissModalViewControllerAnimated:YES];
    txtEmailBody.text = @"";
    textEmail.text = @"";
    [[self.view findFirstResponder]resignFirstResponder];
}

- (IBAction)HideContentViewPressed:(id)sender {
    ContactView.hidden = YES;
    [[ApplicationData sharedInstance].contactsArray removeAllObjects];
    textEmail.text = @"";
}

- (IBAction)AppendEmailAddress:(id)sender {

    NSString *email = @"";
    for (Option *op in [ApplicationData sharedInstance].contactsArray) {
        if (op.isSelected == YES) {
            if ([email length] == 0) {
                email = op.email;
            }
            else {
                email = [NSString stringWithFormat:@"%@,%@",email,op.email];
            }
        }
    }
    textEmail.text = email;
    allEmails = email;
    ContactView.hidden = YES;
}

- (IBAction)FTShareButtonPressed:(id)sender {
    [spinner startAnimating];
    [[txtShare findFirstResponder]resignFirstResponder];
    [[self.view findFirstResponder] resignFirstResponder];
    if (isFacebook == YES) {
        [self faceBook];
    }
    else if (isFacebook == NO) {
        [self twitter];
    }
}

- (IBAction)SelectAllContactButtonPressed:(id)sender {
    [btnSelectAllContact setImage:[UIImage imageNamed:@"radio_on.png"] forState:UIControlStateNormal];
    [btnDeSelectAllContact setImage:[UIImage imageNamed:@"radio_off.png"] forState:UIControlStateNormal];
    
    for (option in [ApplicationData sharedInstance].contactsArray) {
        option.isSelected = YES;
    }
    [tableView reloadData];
}

- (IBAction)DeSelectAllContactsButtonPressed:(id)sender {
    [btnSelectAllContact setImage:[UIImage imageNamed:@"radio_off.png"] forState:UIControlStateNormal];
    [btnDeSelectAllContact setImage:[UIImage imageNamed:@"radio_on.png"] forState:UIControlStateNormal];

    for (option in [ApplicationData sharedInstance].contactsArray) {
        option.isSelected = NO;
    }
    [tableView reloadData];
}

- (void )getPhoneBook {
    [[ApplicationData sharedInstance].contactsArray removeAllObjects];
    Option *optionObj;
    //performaselecter remove
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    ///////////////////////////////////////////////////////////////////
    ABAddressBookRef addressBook = ABAddressBookCreate();
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL)
    { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        // dispatch_release(sema);
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    if (accessGranted)
    {
        // Do whatever you want here.
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
        NSMutableDictionary *dicContact;
        NSMutableArray *contactArray = [[NSMutableArray alloc] init];
        NSString *multival;
        for( int i = 0 ; i < nPeople ; i++ )
        {
            dicContact = [[NSMutableDictionary alloc] init];
            
            ABRecordRef ref = CFArrayGetValueAtIndex(allPeople, i );
            
            if(ABRecordCopyValue(ref, kABPersonFirstNameProperty) != nil || [[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonFirstNameProperty)] length] == 0)
                [dicContact setValue:[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonFirstNameProperty)] forKey:@"firstname"];
            else
                [dicContact setValue:@"" forKey:@"firstname"];
            
            if(ABRecordCopyValue(ref, kABPersonLastNameProperty) != nil || [[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonLastNameProperty)] length] == 0)
                [dicContact setValue:[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonLastNameProperty)] forKey:@"lastname"];
            else
                [dicContact setValue:@"" forKey:@"lastname"];
            
            if(ABRecordCopyValue(ref, kABPersonOrganizationProperty) != nil || [[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonOrganizationProperty)] length] == 0)
                [dicContact setValue:[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonOrganizationProperty)] forKey:@"name"];
            else
                [dicContact setValue:[NSString stringWithFormat:@"%@ %@",[dicContact valueForKey:@"firstname"],[dicContact valueForKey:@"lastname"]] forKey:@"name"];
            
            NSData *data1 = (NSData *) ABPersonCopyImageData(ref);
            
            if(data1 == nil)
                [dicContact setObject:[UIImage imageNamed:@"the face.png"] forKey:@"image"];
            else
                [dicContact setObject:[UIImage imageWithData:data1] forKey:@"image"];
            // [dicContact setObject:data1 forKey:@"image"];
            
            multival = ABRecordCopyValue(ref, kABPersonAddressProperty);
            NSArray *arrayAddress = (NSArray *)ABMultiValueCopyArrayOfAllValues(multival);
            if([arrayAddress count] > 0)
            {
                if([[arrayAddress objectAtIndex:0] valueForKey:@"City"] != nil)
                    [dicContact setValue:[[arrayAddress objectAtIndex:0] valueForKey:@"City"] forKey:@"city"];
                else
                    [dicContact setValue:@"" forKey:@"city"];
                
                if([[arrayAddress objectAtIndex:0] valueForKey:@"State"] != nil)
                    [dicContact setValue:[[arrayAddress objectAtIndex:0] valueForKey:@"State"] forKey:@"state"];
                else
                    [dicContact setValue:@"" forKey:@"state"];
                
                if([[arrayAddress objectAtIndex:0] valueForKey:@"Street"] != nil)
                    [dicContact setValue:[[arrayAddress objectAtIndex:0] valueForKey:@"Street"] forKey:@"address1"];
                else
                    [dicContact setValue:@"" forKey:@"address1"];
                
                if([[arrayAddress objectAtIndex:0] valueForKey:@"ZIP"] != nil)
                    [dicContact setValue:[[arrayAddress objectAtIndex:0] valueForKey:@"ZIP"] forKey:@"postcode"];
                else
                    [dicContact setValue:@"" forKey:@"postcode"];
            }
            else
            {
                [dicContact setValue:@"" forKey:@"city"];
                [dicContact setValue:@"" forKey:@"address1"];
                [dicContact setValue:@"" forKey:@"state"];
                [dicContact setValue:@"" forKey:@"postcode"];
            }
            
            multival = ABRecordCopyValue(ref, kABPersonPhoneProperty);
            NSArray *arrayPhone = (NSArray *)ABMultiValueCopyArrayOfAllValues(multival);
            if([arrayPhone count] > 0)
                [dicContact setValue:[arrayPhone objectAtIndex:0] forKey:@"telephone"];
            else
                [dicContact setValue:@"" forKey:@"telephone"];
            
            multival = ABRecordCopyValue(ref, kABPersonEmailProperty);
            NSArray *arrayEmail = (NSArray *)ABMultiValueCopyArrayOfAllValues(multival);
            if([arrayEmail count])
                [dicContact setValue:[arrayEmail objectAtIndex:0] forKey:@"email"];
            else
                [dicContact setValue:@"" forKey:@"email"];
            
            multival = ABRecordCopyValue(ref, kABPersonURLProperty);
            NSArray *arrayURL = (NSArray *)ABMultiValueCopyArrayOfAllValues(multival);
            if([arrayURL count])
                [dicContact setValue:[arrayURL objectAtIndex:0] forKey:@"website"];
            else
                [dicContact setValue:@"" forKey:@"website"];
            
            [dicContact setValue:@"" forKey:@"address2"];
            [dicContact setValue:@"" forKey:@"mobile"];
            [dicContact setValue:@"" forKey:@"fax"];
            [dicContact setValue:@"1.000000,1.000000,0.000000,0.000000" forKey:@"color"];
            NSLog(@"%@",dicContact);
            
            [contactArray addObject:dicContact];
            optionObj = [[Option alloc]init];
            optionObj.contactId = i;
            optionObj.thumbImg=[dicContact objectForKey:@"image"];
            
            if ([[dicContact objectForKey:@"lastname"] length] > 0 && [[dicContact objectForKey:@"firstname"] length] > 0) {
                optionObj.name = [NSString stringWithFormat:@"%@ %@",[dicContact objectForKey:@"firstname"],[dicContact objectForKey:@"lastname"]];
            }
            else if([[dicContact objectForKey:@"firstname"] length] > 0){
                optionObj.name = [dicContact objectForKey:@"firstname"];
            }
            else if([[dicContact objectForKey:@"lastname"] length] > 0){
                optionObj.name = [dicContact objectForKey:@"lastname"];
            }
            
            if ([[dicContact objectForKey:@"email"] length] > 0) {
                optionObj.email = [dicContact objectForKey:@"email"];
            }
            
            if ([optionObj.email length] > 0) {
                [[ApplicationData sharedInstance].contactsArray addObject:optionObj];    
            }
            [optionObj release];
            [dicContact release];
        }
        [spinner stopAnimating];
        NSLog(@"%@",contactArray);
    }
}

#pragma mark -
#pragma mark TableFunctions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableViewController {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 53.0;
}

- (NSInteger)tableView:(UITableView *)tableView1 numberOfRowsInSection:(NSInteger)section {
    return [[ApplicationData sharedInstance].contactsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    option = [[ApplicationData sharedInstance].contactsArray objectAtIndex:indexPath.row];

    iCMSEmailListCell *cell = [cellArray objectForKey:[NSString stringWithFormat:@"%d", option.contactId]];
    
    if (cell == nil) {
        // for calling the custom table view
        [cellOwner loadMyNibFile:@"iCMSEmailListCell"];
        cell = (iCMSEmailListCell *)cellOwner.cell;
        [cellArray setObject:cell forKey:[NSString stringWithFormat:@"%d", option.contactId]];
    }
    
    if (option.isSelected) {
        
        cell.checkImg.image = [UIImage imageNamed:[iCMSApplicationData sharedInstance].checkImg];
    }
    else {
        cell.checkImg.image = [UIImage imageNamed:[iCMSApplicationData sharedInstance].uncheckImg];
    }
    cell.option = option;
    
    [cell reloadCell];
    return cell;
}

- (void)tableView:(UITableView *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([spinner isAnimating]) {
        return;
    }
    iCMSEmailListCell *cell = (iCMSEmailListCell *)[tableView cellForRowAtIndexPath:indexPath];
    option = [[ApplicationData sharedInstance].contactsArray objectAtIndex:indexPath.row];
    [btnSelectAllContact setImage:[UIImage imageNamed:@"radio_off.png"] forState:UIControlStateNormal];
    if (option.isSelected) {
        cell.checkImg.image = [UIImage imageNamed:[iCMSApplicationData sharedInstance].checkImg];
    }
    else {
        cell.checkImg.image = [UIImage imageNamed:[iCMSApplicationData sharedInstance].uncheckImg];
    }
    option.isSelected = !(option.isSelected);
    [tableView reloadData];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) touchesBegan : (NSSet *)touches withEvent:(UIEvent *)event {
    [[self.view findFirstResponder] resignFirstResponder];
    int y = shareView.frame.origin.y;
    int x = shareView.frame.origin.x;
    shareView.hidden = YES;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480) {
            EmailView.frame = CGRectMake(x, y,EmailView.frame.size.width,369);
            txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x,60.0, txtEmailBody.frame.size.width, 250);
            // iPhone Classic
        }
        if(result.height == 568) {
            EmailView.frame = CGRectMake(x, y,EmailView.frame.size.width,460);
            txtEmailBody.frame = CGRectMake(txtEmailBody.frame.origin.x,60.0, txtEmailBody.frame.size.width, 340);
            // iPhone 5
        }
    }

    [textEmail resignFirstResponder];
	[txtEmailBody resignFirstResponder];
}


#pragma mark -
#pragma mark Alert
- (void)showAlert:(NSString *)title Content:(NSString *)bodyText {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:bodyText
												   delegate:self cancelButtonTitle:NSLocalizedString(@"alert_cancel_btn_title",@"") otherButtonTitles: nil];
	[alert setContentMode:UIViewContentModeScaleAspectFit];
	[alert show];
	[alert release];
}


#pragma mark - Facebook API Calls
/**
 * Make a Graph API Call to get information about the current logged in user.
 */
- (void)apiFQLIMe {
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, name, pic, email FROM user WHERE uid=me()", @"query",
                                   nil];
    [facebook requestWithMethodName:@"fql.query"
                          andParams:params
                      andHttpMethod:@"POST"
                        andDelegate:self];
}

- (void)apiGraphUserPermissions {
    [facebook requestWithGraphPath:@"me/permissions" andDelegate:self];
}

#pragma - Private Helper Methods

/**
 * Show the logged in menu
 */

- (void)showLoggedIn {
    
    [self apiFQLIMe];
}

/**
 * Show the logged in menu
 */

- (void)showLoggedOut {
    
}

/**
 * Show the authorization dialog.
 */
- (void)faceBook {
    // Initialize Facebook
    if ([ApplicationData sharedInstance].facebook) {
        facebook = [[ApplicationData sharedInstance].facebook retain];
        facebook.sessionDelegate = self;
    } else {
        facebook = [[Facebook alloc] initWithAppId:kApiKey andDelegate:self];
        [ApplicationData sharedInstance].facebook = facebook;
    }
    
    // Check and retrieve authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"offline_access", @"email" ,@"publish_stream", nil];
    if (![facebook isSessionValid]) {
        [facebook authorize:permissions];
    } else {
        [self setStatus];
    }
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    [facebook logout];
}

- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

#pragma mark - FBSessionDelegate Methods
/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    [self showLoggedIn];
    
    [self storeAuthData:[facebook accessToken] expiresAt:[facebook expirationDate]];
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    DLog(@"token extended");
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self showLoggedOut];
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [alertView release];
    [self fbDidLogout];
}

#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response. This callback
 * gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    DLog(@"received response");
}

/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    [spinner stopAnimating];
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
    if ([result objectForKey:@"name"]) {
        
        ApplicationData *appdata = [ApplicationData sharedInstance];
        if (!appdata.userDetail) {
            appdata.userDetail = [[User alloc] init];
        }
        appdata.userDetail.facebookId = [NSString stringWithFormat:@"%@", [result valueForKey:@"uid"]];
        if(appdata.userDetail.facebookId.length > 0) {
            appdata.userDetail.email = [result valueForKey:@"email"];
            appdata.userDetail.passwordtoken = [NSString stringWithFormat:@"%@", [result valueForKey:@"uid"]];
            appdata.userDetail.userName = [result valueForKey:@"name"];
            appdata.userDetail.avatarURL = [result valueForKey:@"pic"];
          // appdata.userDeatail.fbuserName = [result valueForKey:@"username"];
        }
        
        [self performSelectorOnMainThread:@selector(setStatus) withObject:nil waitUntilDone:NO];
        
    } else {
        [self showAlert:NSLocalizedString(@"alert_success", @"title") Content:NSLocalizedString(@"alert_body_fb_shared", @"alert body")];
        txtShare.text = @"";
        if (status) {
            [self twitter];
            status=NO;
        }
    }
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    [spinner stopAnimating];
    [self showAlert:NSLocalizedString(@"alert_error", @"title") Content:NSLocalizedString(@"Alert_body_fb", @"alert body")];
	if (status) {
		[self twitter];
		status=NO;
	}
    DLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    DLog(@"Err code: %d", [error code]);
}


- (void)setStatus {
	
//    NSString *statusString =  [NSString stringWithFormat:@"%@",article.article_title];
     NSString *statusString =  [NSString stringWithFormat:@"%@",self.share_title];
//    NSString *shareLink = article.shareLink;
    NSString *shareLink = self.share_link;
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]
                                   initWithCapacity:1];
    [params setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey] forKey:@"name"];
    
    [params setObject:@"status" forKey:@"type"];
    [params setObject:txtShare.text forKey:@"message"];
    [params setObject:shareLink forKey:@"link"];
    [params setObject:statusString forKey:@"picture"];
    [facebook requestWithGraphPath:@"me/feed"
                         andParams:params
                     andHttpMethod:@"POST"
                       andDelegate:self];
	[spinner startAnimating];
}



/////////////////////////////////////////////////////////
////////////////////////// TWITTER
/////////////////////////////////////////////////////////


-(void)twitter{
	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: [iCMSApplicationData sharedInstance].twitter delegate:self];
	
	if (controller) {
		[self presentModalViewController:controller animated: NO];
	} else {
		[self OAuthTwitterController:nil authenticatedWithUsername:nil];
	}
}

#pragma mark SA_OAuthTwitterEngineDelegate

- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

//=============================================================================================================================
#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	
	SA_OAuthTwitterEngine *twitter = [[iCMSApplicationData sharedInstance] twitter];
	twitter._delegate = self;
    controller.navigationBar.tintColor = [ApplicationData sharedInstance].tintColor;
//	[twitter sendUpdate:[NSString stringWithFormat:@"%@ %@" ,article.article_title,article.shareLink]];
    [twitter sendUpdate:[NSString stringWithFormat:@"%@ %@" ,self.share_title,self.share_link]];
	[spinner startAnimating];
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	[spinner stopAnimating];
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	[spinner stopAnimating];
}

//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	[spinner stopAnimating];
    txtShare.text = @"";
	[self showAlert:NSLocalizedString(@"alert_success", @"title") Content:NSLocalizedString(@"alert_body_twitter_shared", @"alert body")];
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	[self showAlert:NSLocalizedString(@"alert_error", @"title") Content:NSLocalizedString(@"alert_body_twitter", @"alert body")];
	[spinner stopAnimating];
}

@end
