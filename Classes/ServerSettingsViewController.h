//
//  ServerSettingsViewController.h
//  iJoomer
//
//  Created by Mac HDD on 10/12/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "RequestResponseManager.h"
#import "iJoomerAppDelegate.h"

@interface ServerSettingsViewController : UIViewController <UITextFieldDelegate,RequestManagerDelegate,UIAlertViewDelegate>{
	IBOutlet UITextField *txtServerURL;
	IBOutlet UISwitch *urlSelectionSwitch;
	IBOutlet UIButton *btnDone;
    IBOutlet UIButton *btnSsl;
	IBOutlet UINavigationBar *titleBar;
	IBOutlet UINavigationItem *titleItem;
	IBOutlet UIImageView *bgImageView;
	IBOutlet UILabel *lblDefault;
    IBOutlet UIActivityIndicatorView *spinner;
    BOOL isSSLEnable;
    
    Reachability *wifiReach;
    NetworkStatus currentNetworkStatus;
    HTTPRequest currentRequestType;
    iJoomerAppDelegate *appdelegate;
    BOOL temp;
    BOOL deleteTable;
}

- (IBAction)testConnection;
- (IBAction)cancelButtonPressed;
- (IBAction)EnableSSL;
- (BOOL)textFieldShouldReturn: (UITextField *)textField;
- (void)showAlert:(NSString *)title Content:(NSString *)bodyText;
@end
