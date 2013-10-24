//
//  ServerSettingsViewController.m
//  iJoomer
//
//  Created by Mac HDD on 10/12/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "ServerSettingsViewController.h"
#import "AppConstantsList.h"
#import "ApplicationData.h"
#import "iCMSApplicationData.h"
#import "Reachability.h"
#import "iCMS.h"
#import "iCMSGlobalObject.h"

@implementation ServerSettingsViewController

#pragma mark -
#pragma mark viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    [spinner stopAnimating];
    appdelegate = (iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    
	titleBar.tintColor = [iCMSApplicationData sharedInstance].tintColor;
	lblDefault.textColor = [ApplicationData sharedInstance].textcolor;
	isSSLEnable = NO;
    txtServerURL.delegate = self;
    [btnSsl setImage:[UIImage imageNamed:[iCMSApplicationData sharedInstance].uncheckImg] forState:UIControlStateNormal];
	NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
	NSString *serverURL = [userSettings objectForKey:@"serverurl"];
	if(serverURL) {
		[txtServerURL setText:serverURL];
	}
    //	if([userSettings boolForKey:kUseDefaultURL]) {
    //		[urlSelectionSwitch setOn:YES];
    //	} else {
    //		[urlSelectionSwitch setOn:NO];
    //	}
	
	bgImageView.image = [UIImage imageNamed:[ApplicationData sharedInstance].bgImage];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [txtServerURL setText:@""];
    [spinner stopAnimating];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            bgImageView.frame = CGRectMake(0, 0, 320, 460);
            // iPhone Classic
        }
        if(result.height == 568)
        {
            bgImageView.frame = CGRectMake(0, 0, 320, 568);
            // iPhone 5
        }
    }
    [self themeChange];
}

- (void)themeChange {
    spinner.backgroundColor = [iCMSApplicationData sharedInstance].textcolor;
}


#pragma mark -
#pragma mark dealloc

- (void)dealloc {
    [super dealloc];
}

#pragma mark UIButton Events

- (IBAction)testConnection {
	// set custom server url settings
    [spinner startAnimating];
    NSString *strURL = txtServerURL.text;
    if([strURL length] > 0) {
        if (isSSLEnable == YES) {
            if(![strURL hasPrefix:@"https://"]) {
                strURL = [NSString stringWithFormat:@"https://%@", strURL];
            }
        }
        else {
            if(![strURL hasPrefix:@"http://"]) {
                strURL = [NSString stringWithFormat:@"http://%@", strURL];
            }
        }
        
//        if(![strURL hasSuffix:@"/"]) {
//            strURL = [strURL stringByAppendingString:@"/index.php?option=com_ijoomeradv"];
//        }
//        else{
//            strURL = [strURL stringByAppendingString:@"index.php?option=com_ijoomeradv"];
//        }
        
        wifiReach = [[Reachability alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
        
        
        
        wifiReach = [[Reachability reachabilityWithHostName:strURL] retain];
        [wifiReach startNotifer];
        currentNetworkStatus = ReachableViaWiFi;
        [self reachabilityChanged:nil];
        [ApplicationData sharedInstance].mainServerURL = strURL;
        
        [[NSUserDefaults standardUserDefaults] setObject:strURL forKey:kServerURL];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSMutableDictionary *postVariables = [[NSMutableDictionary alloc] init];
        NSDictionary *dict = [iCMS ClintTestURlPingResponce:@"" ExtTask:@"ping" TaskdataDictionary:postVariables Imagedata:nil];
        DLog(@"response dict : %@",dict);
        
        if ([[dict objectForKey:@"code"] intValue] == 200 ) {
            
            NSArray *componentList = [dict objectForKey:@"extensions"];
            DLog(@"%@",componentList);
            NSString *strCompoName = @"";
            NSString *strCompoList = @"";
            for (int i = 0; i < [componentList count]; i++) {
                strCompoName = [componentList objectAtIndex:i];
                if ([strCompoList length] == 0) {
                    strCompoList = strCompoName;
                }
                else {
                    strCompoList = [NSString stringWithFormat:@"%@,%@",strCompoList,strCompoName];
                }
            }
            DLog(@"strCompoList : %@",strCompoList);
            if ([strCompoList rangeOfString:@"ICMS"].location != NSNotFound) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test Successfull"
                                                                message:strCompoList delegate:nil cancelButtonTitle:NSLocalizedString(@"alert_cancel_btn_title",@"") otherButtonTitles:nil];
                alert.tag = 2;
                alert.delegate = self;
                [alert show];
                [alert release];
                currentRequestType = ICMSPingTestQuery;
                [self requestCompleted];
            }
            else {
                [spinner stopAnimating];
                [self showAlert:@"Test Failure" Content:@"Sorry iJoomer Advance not configure on your website.\nFor more info visit:\nwww.ijoomer.com"];
            }
        }
    } else {
        [spinner stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert", @"title") message:NSLocalizedString(@"alert_body_url", @"message") delegate:nil cancelButtonTitle:NSLocalizedString(@"alert_cancel_btn_title",@"") otherButtonTitles:nil];
        alert.tag = 1;
        [alert show];
        [alert release];
        return;
    }
}

-(void)jBadRequest{
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"alert_no_network", @"Network error message")];
}

-(void)jErroronServer{
    [self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"alert_body_server", @"Network error message")];
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
            [self performSelectorOnMainThread:@selector(jErroronServer) withObject:nil waitUntilDone:NO];
            
			break;
			
		case jSuccess:
			switch (currentRequestType) {
					
				case ICMSPingTestQuery:
                    
					break;
				default:
					break;
			}
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ((buttonIndex == 0) && (alertView.tag == 2)) {
        [self ResetNewConfig];
    }
}

- (void) ResetNewConfig {
   //////////////////////////////////////////////////////////////////
//    NSDictionary *dict =  [JoomlaRegistration CreateDictionary:@"logout" TaskdataDictionary:nil Imagedata:nil];
    //[ijoomer_lib Logout:[ApplicationData sharedInstance].loggedUser static_URL:sever_static_URL];
//    NSNumber *num = [dict objectForKey:@"code"];
//    int code = [num intValue];
//    [ApplicationData sharedInstance].errorCode = code;
    currentRequestType = jLogoutQuery;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Str_Login_REQ"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Str_FBLogin_REQ"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[ApplicationData sharedInstance] logout:nil];

//    if ([ApplicationData sharedInstance].errorCode == 200) {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Str_Login_REQ"];
//        
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Str_FBLogin_REQ"];
//        
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [[ApplicationData sharedInstance] logout:nil];
//    }
    /////////////////////////////////////////////////////////////////////////////
    deleteTable = [iCMS DropAllTabl];
    temp = [appdelegate fetchConfig];
    [self dismissModalViewControllerAnimated:YES];
}

- (void) reachabilityChanged: (NSNotification* )note {
	NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
	if(currentNetworkStatus == netStatus) {
		return;
	}
	currentNetworkStatus = netStatus;
}

- (IBAction)EnableSSL {
    if (isSSLEnable == YES) {
        isSSLEnable = NO;
        [btnSsl setImage:[UIImage imageNamed:[iCMSApplicationData sharedInstance].uncheckImg] forState:UIControlStateNormal];
    }
    else {
        isSSLEnable = YES;
        [btnSsl setImage:[UIImage imageNamed:[iCMSApplicationData sharedInstance].checkImg] forState:UIControlStateNormal];
    }
}

-(IBAction)cancelButtonPressed {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn: (UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark alert

- (void)showAlert:(NSString *)title Content:(NSString *)bodyText {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:bodyText
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert setContentMode:UIViewContentModeScaleAspectFit];
    alert.tag = 1;
	[alert show];
    
	[alert release];
}

@end
