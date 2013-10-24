//
//  AddVideoViewController.h
//  iJoomer
//
//  Created by Tailored Solutions on 07/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"
#import "Category.h"
#import "USer.h"
#import "RequestResponseManager.h"
#import "Group.h"

@interface AddVideoViewController : UIViewController<UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,RequestManagerDelegate,UITextFieldDelegate> {
	IBOutlet UILabel *videourl;
	IBOutlet UILabel *location;
	IBOutlet UILabel *category;
	IBOutlet UILabel *permission;
	IBOutlet UILabel *instruction;
	IBOutlet UILabel *maxuploads;
	IBOutlet UITextField *urlvideo;
	IBOutlet UITextField *locationtxt;
	IBOutlet UIButton *catbtn;
	IBOutlet UIButton *permissionbtn;
	IBOutlet UIButton *linkvideo;
	int selectedsetting;
	NSDictionary *settingsdict;
	NSArray *permissnlist;
	BOOL changed;
	IBOutlet UILabel *txtper;
	IBOutlet UITextField *txtadd;
	//UIBarButtonItem *doneButton;
	Video *videoobj;
	Category  *catObj;
	HTTPRequest currentRequestType;
	User *userDetail;
	Group *group;
	IBOutlet UIImageView *backImg;
	IBOutlet UIActivityIndicatorView *spinner;

}
@property(nonatomic,retain)IBOutlet UIButton *permissionbtn;
@property (nonatomic,retain) NSDictionary *settingsdict;
@property (nonatomic,retain)IBOutlet UITextField *txtadd;
@property (nonatomic,assign)Video *videoobj;
@property (nonatomic,assign)Group *group;
@property (nonatomic,assign)Category  *catObj;



- (void)showActionSheetWithPicker;
- (void)themechange;
-(void)showAlert:(NSString *)title Content:(NSString *)bodyText;

-(IBAction)postButtonPressed;
-(IBAction)settingButtonPressed;

-(void) requestCompleted;
@end
