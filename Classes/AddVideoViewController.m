//
//  AddVideoViewController.m
//  iJoomer
//
//  Created by Tailored Solutions on 07/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddVideoViewController.h"
#import "RequestResponseManager.h"
#import "ApplicationData.h"
#import "Group.h"

@implementation AddVideoViewController
@synthesize permissionbtn;
@synthesize settingsdict;
@synthesize txtadd;
@synthesize videoobj;
@synthesize group;
@synthesize  catObj;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	settingsdict=[[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"settings.plist"]];
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"button_back",@"") style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	txtadd.delegate=self;
	self.title=@"Add Video";
	txtadd.hidden=YES;
	permissnlist = [settingsdict objectForKey:@"SettingValues"];
	NSLog(@"aaaaa%@",permissnlist);
	NSLog(@"aaaaa%d",catObj.albumID);
	[permissnlist retain];
	selectedsetting = -1;
	
}
- (void)viewWillAppear:(BOOL)animated {
	[self themechange];
}

-(void)touchesBegan :(NSSet *)touches withEvent:(UIEvent *)event
{
	[urlvideo resignFirstResponder];
	[txtadd resignFirstResponder];
	[super touchesBegan:touches withEvent:event];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (void)showAlert:(NSString *)title Content:(NSString *)bodyText {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:bodyText
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert setContentMode:UIViewContentModeScaleAspectFit];	
	[alert show];	
	[alert release];
}


-(IBAction)settingButtonPressed{
	
	[urlvideo resignFirstResponder];
	[locationtxt resignFirstResponder];
	[self showActionSheetWithPicker];
}

- (void)showActionSheetWithPicker {
	
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n"
															 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
													otherButtonTitles:NSLocalizedString(@"Done_title",@""),NSLocalizedString(@"button_cancel",@""), nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	
	UIPickerView *selectionPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
	selectionPicker.delegate = self;
	selectionPicker.dataSource = self;
	selectionPicker.showsSelectionIndicator = YES;
	actionSheet.alpha = 0.8;
	
	// add this picker to our view controller, initially hidden
	[actionSheet insertSubview:selectionPicker atIndex:0];
	actionSheet.destructiveButtonIndex = 1;	// make the second button red (destructive)
	[actionSheet showFromTabBar:self.tabBarController.tabBar];// showInView:self.view]; // show from our tabbar view (pops up in the middle of the tabbar)
	[actionSheet release];
	changed = NO;
	
}

-(void) textViewDidBeginEditing:(UITextView *)textView{
	if (textView.tag == 0) {
		[UIView beginAnimations:nil context:NULL]; {
			[UIView setAnimationCurve:UIViewAnimationTransitionFlipFromRight];
			[UIView setAnimationDuration:0.5];
			urlvideo.frame = CGRectMake(0.0, 0.0, 320.0, 200.0);
			txtadd.hidden = YES;
			permissionbtn.hidden=YES;
		} [UIView commitAnimations];
	}
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarStyleBlack target:self action:@selector(doneButtonPressed)] autorelease];
	
}


- (void)sendVideo
{
	if(![spinner isAnimating]) {
	RequestResponseManager *requestManager = [RequestResponseManager sharedInstance];
    NSString *urlPart = [NSString stringWithFormat:GROUP_ADD_VIDEO,group.Id,[ApplicationData sharedInstance].sessionId];
	NSString *requesturl = [NSString stringWithFormat:[ApplicationData sharedInstance].mainServerURL, urlPart];
    NSString *xml = [NSString stringWithFormat:XML_GROUP_ADD_VIDEO,videoobj.videoURL,videoobj.catID,locationtxt.text];
    // Send Request
    currentRequestType=jAddVideoQuery;
    [requestManager setRequestPropery:self ExtraInfo:videoobj];
    [requestManager sendPostHttpRequest:requesturl RequestType:jAddVideoQuery PostContent:xml];
		[spinner startAnimating];
	}

	
}

- (void) hideKeyboard:(UIView *)view  {
    NSArray *subviews = [view subviews];
    for (UIView *subview in subviews){
        if ([subview isKindOfClass:[UITextField class]]) {
            [subview resignFirstResponder];
        }
        [self hideKeyboard: subview ];
    }
}

- (void)themechange {
	backImg.image = [UIImage imageNamed:[ApplicationData sharedInstance].bgImage];
	self.navigationController.navigationBar.tintColor = [ApplicationData sharedInstance].tintColor;	
	//[catbtn setBackgroundImage:[UIImage imageNamed:[ApplicationData sharedInstance].msgSubjtextImg] forState:UIControlStateNormal];
	//[permissionbtn setBackgroundImage:[UIImage imageNamed:[ApplicationData sharedInstance].msgSubjtextImg] forState:UIControlStateNormal];
	[linkvideo setBackgroundImage:[UIImage imageNamed:[ApplicationData sharedInstance].selectedbutton] forState:UIControlStateNormal];
	videourl.textColor= [ApplicationData sharedInstance].textcolor; 
	location.textColor= [ApplicationData sharedInstance].textcolor; 
	category.textColor= [ApplicationData sharedInstance].textcolor; 
	permission.textColor= [ApplicationData sharedInstance].textcolor; 
	instruction.textColor= [ApplicationData sharedInstance].textcolor; 
	maxuploads.textColor= [ApplicationData sharedInstance].textcolor; 
	
}


- (IBAction)postButtonPressed
{

	int user;
	if([urlvideo.text length]) {
		if(!videoobj) {
			videoobj = [[Video alloc] init];
			
		}
		user=[txtadd.text intValue];
		
		videoobj.permissions=user;
		if(group)
		{
			videoobj.groupid=group.Id;
			videoobj.creatorType=@"group";
		}
		else
		{
			videoobj.creatorType=@"user";
			videoobj.groupid=0;
		}
		
		videoobj.catID=catObj.albumID;
		videoobj.videoURL = urlvideo.text;
		
		[self sendVideo];
	} 
	else {
		[self showAlert:@"invalid !" 
				Content:@"Please Fill All The Detail"];
	}
}


-(void) requestCompleted
{
	switch ([ApplicationData sharedInstance].errorCode) {
        case jNetworkError:
            [self showAlert:@"Error" Content:@"No Network"];
            break;
        case jSessionError:
            [self showAlert:@"Error" Content:@"Not Logged In!"];
            break;
        case jErroronServer:
            [self showAlert:@"Error" Content:@"Server Error"];
            break;
        case jSuccess:
			
			[catObj.photos addObject:videoobj];
			
			[self showAlert:@"Success!" Content:@"Video Successfully Created!"];
			[self.navigationController popViewControllerAnimated:YES];
			NSLog(@"[SUCCESS]");
			
		default:
			break;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// ActionSheet Delegate ////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == 0) {
		if(!changed){
			selectedsetting = 0;
			
			NSDictionary *dict= [permissnlist objectAtIndex:0];
			NSArray *arr = [dict allKeys];
			[permissionbtn setTitle:[arr objectAtIndex:0] forState:UIControlStateNormal];
		}
		changed = FALSE;
	} 
	else {
		[permissionbtn setTitle:@"Public" forState:UIControlStateNormal];
	}
	
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	return [permissnlist count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

	NSDictionary *dict= [permissnlist objectAtIndex:row];
	NSArray *arr = [dict allValues];
	return [arr objectAtIndex:0];

}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 150;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {	
	changed = YES;
	selectedsetting = row;
	
	NSDictionary *dict= [permissnlist objectAtIndex:row];
	NSArray *arr = [dict allKeys];
	
	[permissionbtn setTitle:[arr objectAtIndex:0] forState:UIControlStateNormal];	
	txtadd.text=[arr objectAtIndex:0];
}

- (BOOL)textFieldShouldReturn: (UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[permissionbtn release];
	[permissnlist release];
    [super dealloc];
}


@end
