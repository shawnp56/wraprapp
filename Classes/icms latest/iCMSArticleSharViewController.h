//
//  iCMSArticleSharViewController.h
//  iJoomer
//
//  Created by Tailored Solutions on 4/11/13.
//
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "GAITrackedViewController.h"
#import <MessageUI/MessageUI.h>
#import "SA_OAuthTwitterController.h"
#import "MGTwitterEngine.h"
#import "SA_OAuthTwitterEngine.h"
#import "Facebook.h"
#import "ApplicationData.h"

@class TableCellOwner;//iCMSArticle;
@class Option;

@interface iCMSArticleSharViewController : UIViewController <UIActionSheetDelegate,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate,MFMailComposeViewControllerDelegate,SA_OAuthTwitterControllerDelegate,MGTwitterEngineDelegate,FBDialogDelegate, FBSessionDelegate,FBRequestDelegate> {

    IBOutlet UIImageView *backImg;
    IBOutlet UITableView *tableView;
    IBOutlet UIActivityIndicatorView *spinner;
    
    
    
    IBOutlet UIButton *btnFacebook;
    IBOutlet UIButton *btnTwitter;
    IBOutlet UIButton *btnFTShare;
    BOOL isFacebook;
    IBOutlet UIButton *btnLoadEmailAddress;
    NSString *allEmails;
    
    TableCellOwner *cellOwner;
    NSMutableDictionary *cellArray;
    
    IBOutlet UIView *shareView;
    IBOutlet UIImageView *shaveViewBackImg;
    IBOutlet UITextField *txtShare;
    
    
    
    IBOutlet UIButton *btnDismiss;
    IBOutlet UIButton *btnFTCancle;
    Facebook *facebook;
    
    IBOutlet UIView *EmailView;
    IBOutlet UITextField *textEmail;
    IBOutlet UITextView *txtEmailBody;
    IBOutlet UIButton *btnEmailCancel;
    IBOutlet UIButton *btnEmailSend;
    
    
    IBOutlet UIView *ContactView;
    IBOutlet UIButton *btnHideContent;
    IBOutlet UIButton *btnSelectEmilAdd;
    IBOutlet UIButton *btnSelectAllContact;
    IBOutlet UIButton *btnDeSelectAllContact;
    
    
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
    
    NSString *share_title;
    NSString *share_link;
    NSString *share_photo_url;
    
//    iCMSArticle *article;
    
    Option *option;
}

//@property (nonatomic,retain) iCMSArticle *article;
@property (nonatomic,retain) NSString *share_title;
@property (nonatomic,retain) NSString *share_link;
@property (nonatomic,retain) NSString *share_photo_url;

- (IBAction)FacebookButtonPressed:(id)sender;
- (IBAction)TwitterButtonPressed:(id)sender;
- (IBAction)LoadEmailButtonPressed:(id)sender;
- (IBAction)DismissButtonPressed:(id)sender;
- (IBAction)CancelFTShareButtonPressed:(id)sender;
- (IBAction)CancelEmailButtonPressed:(id)sender;
- (IBAction)EmailSendButtonPressed:(id)sender;
- (IBAction)HideContentViewPressed:(id)sender;
- (IBAction)AppendEmailAddress:(id)sender;
- (IBAction)FTShareButtonPressed:(id)sender;
- (IBAction)SelectAllContactButtonPressed:(id)sender;
- (IBAction)DeSelectAllContactsButtonPressed:(id)sender;

-(void)twitter;
-(void) faceBook;

- (void)showAlert:(NSString *)title Content:(NSString *)bodyText;

@end
