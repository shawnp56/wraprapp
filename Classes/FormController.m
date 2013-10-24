//
//  FormController.m
//  iJoomer
//
//  Created by Tailored Solutions on 20/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FormController.h"
#import "ApplicationData.h"
#import "TableCellOwner.h"
#import "UserInfo.h"
#import "UserDetailCell.h"
#import "User.h"
#import "AppConstantsList.h"
#import "RequestResponseManager.h"
#import "Section.h"
#import "Category.h"
#import "ImageUploader.h"


static NSString *kCellIdentifier = @"UserDetailCell";
@implementation FormController
@synthesize fields,userCell,userDetail;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	cellOwner = [[TableCellOwner alloc] init];
	cellDictionary = [[NSMutableDictionary alloc]init];
	fields = [[NSMutableArray alloc]init];
	
	[tableView setSeparatorColor:[ApplicationData sharedInstance].sepratorcolor];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)] autorelease];
	backImg.image = [UIImage imageNamed:[ApplicationData sharedInstance].bgImage];
	
	NSArray* fieldList = [[NSArray alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"trade.plist"]];
	self.title = NSLocalizedString (@"form_title",@"");
	[tableView setBackgroundColor:[UIColor clearColor]];
	
	//adding of trade.plist values to UserInfo object and adding it to fields object
	for(int i =0 ; i < [fieldList count] ; i++)
	{
		UserInfo *record = [[UserInfo alloc]init];
		NSDictionary *fieldDictonary = [fieldList objectAtIndex:i];
		DLog(@"Field : %@", fieldDictonary);
		record.fieldId=i+1;
		record.fieldName = [fieldDictonary objectForKey:@"field_caption"];
		record.fieldCaption = [fieldDictonary objectForKey:@"field_name"];
		record.fieldType = [fieldDictonary objectForKey:@"field_type"];
		[fields addObject:record];
		[record release];
	}
	
	[tableView setSeparatorColor:[UIColor clearColor]];
	[ApplicationData sharedInstance].isEditMode = YES;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
	[tableView reloadData];
		  
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	if([cellDictionary count] > 0) {
		[tableView reloadData];
	} else {
		if([[ApplicationData sharedInstance].formCategories.optionList count] == 0){
			[self fetchData];
		}
	}  
	
}

- (void)showAlert:(NSString *)title Content:(NSString *)bodyText {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:bodyText
												   delegate:self cancelButtonTitle:NSLocalizedString(@"alert_cancel_btn_title",@"") otherButtonTitles: nil];
	[alert setContentMode:UIViewContentModeScaleAspectFit];	
	[alert show];	
	[alert release];
}



- (void)postData	{
	
	NSString *boundary = @"----1010101010";
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	NSMutableData *postbody = [NSMutableData data];
	NSMutableDictionary *postVariables = [[NSMutableDictionary alloc] init];
	
	//posting of values 
	
	for(int i = 0 ; i< [fields count] ; i ++)
	{		
		UserInfo *saveRecord = [fields objectAtIndex:i];
		if([saveRecord.fieldType isEqualToString:@"select"]) {
			[postVariables setValue:[NSString stringWithFormat:@"%d", saveRecord.fieldId] forKey:saveRecord.fieldCaption];
		} else {
			[postVariables setValue:saveRecord.fieldTempValue forKey:saveRecord.fieldCaption];
		}
	}

	DLog(@"Post Variables : %@", postVariables);
	
	// post values to CreateFormDate 
	
	[postbody appendData:[self createFormData:postVariables withBoundary:boundary]]; 
	
	NSString *requesturl = [NSString stringWithFormat:[ApplicationData sharedInstance].mainServerURL, POST_FORM_URL];
	
	imageUploader = [[ImageUploader alloc] init];
    imageUploader.delegate = self;
    [imageUploader startUpload:requesturl PostData:postbody Boundry:contentType];
	
}
- (NSData*)createFormData:(NSDictionary*)myDictionary withBoundary:(NSString*)myBounds {
    
    NSMutableData *myReturn = [[NSMutableData alloc] init];
    
    NSArray *formKeys = [myDictionary allKeys];
    for (int i = 0; i < [formKeys count]; i++) {
        [myReturn appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",myBounds] dataUsingEncoding:NSASCIIStringEncoding]]; 
        [myReturn appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@",[formKeys objectAtIndex:i],[myDictionary valueForKey:[formKeys objectAtIndex:i]]] dataUsingEncoding:NSASCIIStringEncoding]];
    }
    return myReturn;
}

- (void)themechange{
	backImg.image = [UIImage imageNamed:[ApplicationData sharedInstance].bgImage];
	self.navigationController.navigationBar.tintColor = [ApplicationData sharedInstance].tintColor;
}
//saving of user details of form
- (void)saveUserDetails {
	NSArray *cells = [cellDictionary allValues];
	for(UserDetailCell *cell in cells) {
		[cell saveFieldValue];
	}
}

- (void)requestCompleted {
	
	[spinner stopAnimating];
	switch ([ApplicationData sharedInstance].errorCode) {
		case jNetworkError:
			[self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"alert_no_network", @"Network error message")];
			break;
            
		case jSessionError:
			[self performSelectorOnMainThread:@selector(sessionExpired) withObject:nil waitUntilDone:YES];
			break;
			
		case jErroronServer:
			[self showAlert:NSLocalizedString(@"alert_error",@"Error title") Content:NSLocalizedString(@"alert_body_server", @"Network error message")];
			break;
			
		case jSuccess:
					[self performSelectorOnMainThread:@selector(loaded) withObject:nil waitUntilDone:NO];
					break;
		default:
			break;
	}
}

- (void)loaded {
	[tableView reloadData];
}

- (void)fetchData {
	[spinner startAnimating];
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	RequestResponseManager *requestManager = [RequestResponseManager sharedInstance];
	
	NSString *urlPart = [NSString stringWithFormat:FORMDETAIL_URL];//, userDetail.userId, [ApplicationData sharedInstance].sessionId];
	NSString *requesturl = [NSString stringWithFormat:[ApplicationData sharedInstance].mainServerURL, urlPart];
	
	// Send Request
	
	[requestManager setRequestPropery:self ExtraInfo:[ApplicationData sharedInstance].formCategories];
	[requestManager sendGetHttpRequest:requesturl RequestType:jFormQuery];
	
	[pool release];
}

#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView1 {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UserInfo *record = [fields objectAtIndex:indexPath.row];
    
	CGFloat height = 30.0;
	CGSize size;
	if([ApplicationData sharedInstance].isEditMode) {
        if ([record.fieldType isEqualToString:@"textarea"]) {
			height = 80;
		}
        else {
            height = 35;
        }
	} else {
		size = [record.fieldTempValue sizeWithFont:[UIFont boldSystemFontOfSize:12] constrainedToSize:CGSizeMake(181, 9999) lineBreakMode:UILineBreakModeWordWrap];

		height = size.height + 8;
	}
    NSString *name = record.fieldName;
    if (record.isRequired)
        name = [NSString stringWithFormat:@"%@ *", record.fieldName];
    
	size = [name sizeWithFont:[UIFont fontWithName:@"Helvetica" size:12] constrainedToSize:CGSizeMake(110, 9999) 
				lineBreakMode:UILineBreakModeWordWrap];
	CGFloat nameHeight = size.height + 8;
	height = MAX(height, nameHeight);
	return MAX(30, height);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [fields count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UserInfo *record = [fields objectAtIndex:indexPath.row];
	
	UserDetailCell *cell = [cellDictionary objectForKey:[NSString stringWithFormat:@"%d", record.fieldId]];
	if (cell == nil)
	{
		[cellOwner loadMyNibFile:kCellIdentifier];
		cell = (UserDetailCell *)cellOwner.cell;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.tag = record.fieldId;
        [cell.txtFieldValue setDelegate:self];
        [cell.txtViewValue setDelegate:self];
		cell.userData = record;
		[cell reloadCell];
		[cellDictionary setObject:cell forKey:[NSString stringWithFormat:@"%d", record.fieldId]];
		
		if ([record.fieldType compare:@"select" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
			
			cell.btnPicker.tag = record.fieldId;
			[cell.btnPicker addTarget:self action:@selector(cellSelectionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
			
		}
	} else {
		cell.userData = record;
		[cell reloadCell];
	}
    return cell;
}

- (void)tableView:(UITableView *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableViewController deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Event Methods

- (IBAction)saveButtonPressed:(id)sender {
	[spinner startAnimating];
	
	[self saveUserDetails];
	
	BOOL flag = YES;
	
	for (UserInfo *record in [ApplicationData sharedInstance].formCategories.optionList) {
		if ([userCell.userData.fieldTempValue length] == 0){
			flag = NO;
			break;
		}
		
		if (!flag) {
			break;
		}
	}
	
    if (!flag) {
        [self showAlert:NSLocalizedString(@"alert_error",@"Error title") 
				Content:NSLocalizedString(@"improper_content",@"alert body")];
		[spinner stopAnimating];
        
    }
	if ([userCell.userData.fieldTempValue length]> 0) {
		[self postData];
		[self resignFirstResponder];
		[self showAlert:NSLocalizedString(@"success",@"") Content:NSLocalizedString(@"reg_success",@"")];
	}
	
}


- (IBAction)cellSelectionButtonPressed:(id)sender {
	
	userCell = [cellDictionary objectForKey:[NSString stringWithFormat:@"%d", [sender tag]]];
	if([sender tag] == 6) {
		pickerSelectioList = [ApplicationData sharedInstance].formCategories.optionList;
	} else if(selectedSection){
		pickerSelectioList = selectedSection.categorys;
	}
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n"
															 delegate:self cancelButtonTitle:nil  destructiveButtonTitle:nil
													otherButtonTitles:NSLocalizedString(@"Done_title",@""),NSLocalizedString(@"button_cancel",@""),nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	
	actionSheet.tag = 1;
	
	UIPickerView *selectionPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
	selectionPicker.delegate = self;
	selectionPicker.dataSource = self;
	selectionPicker.showsSelectionIndicator = YES;
	selectionPicker.tag = 99;
	
	
	actionSheet.alpha = 0.8;
	
	// add this picker to our view controller, initially hidden
	[actionSheet insertSubview:selectionPicker atIndex:0];
	
	actionSheet.destructiveButtonIndex =1;	// make the second button red (destructive)
	[actionSheet showFromTabBar:self.tabBarController.tabBar];// showInView:self.view]; // show from our tabbar view (pops up in the middle of the tabbar)
	[actionSheet release];
	//changed = NO;
	
}

#pragma mark -
#pragma mark dismissing keyboard

- (void)keyboardWillShow:(NSNotification *)notification {
	tableView.frame = CGRectMake(0, 0, 320, 200);
}

- (void)keyboardDidHide:(NSNotification *)notification {
	tableView.frame = CGRectMake(0, 0, 320, 367);
}

#pragma mark -
#pragma mark textView delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    UserDetailCell *cell = nil;
    tableView.frame = CGRectMake(0, 0, 320, 200);
    
    UIView *subView = [textView superview];
    while (![subView isKindOfClass:[UserDetailCell class]]) {
        subView = [subView superview];
        DLog(@"Class List : %@", [subView class]);
    }
    cell = (UserDetailCell *)subView;
    
    if([cell isKindOfClass:[UserDetailCell class]]) {
        for(int i=[[ApplicationData sharedInstance].formCategories.optionList count]-1; i>=0; --i) {
			NSInteger fieldIndex = [fields indexOfObject:cell.userData]; 
            if(fieldIndex != NSNotFound) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:fieldIndex inSection:i];    
                [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                break;
            }
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    UserDetailCell *cell = nil;
    tableView.frame = CGRectMake(0, 0, 320, 200);
    
    UIView *subView = [textField superview];
    while (![subView isKindOfClass:[UserDetailCell class]]) {
        subView = [subView superview];
        DLog(@"Class List : %@", [subView class]);
    }
    cell = (UserDetailCell *)subView;
    
    if([cell isKindOfClass:[UserDetailCell class]]) {
        for(int i=[[ApplicationData sharedInstance].formCategories.optionList count]-1; i>=0; --i) {
			NSInteger fieldIndex = [fields indexOfObject:cell.userData]; 
            if(fieldIndex != NSNotFound) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:fieldIndex inSection:i];    
                [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                break;
            }
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn: (UITextField *)textField {
	[textField resignFirstResponder];
	
	return YES;
}


#pragma mark -
#pragma mark ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if( buttonIndex == 0) {
		UIPickerView *picker = (UIPickerView *)[actionSheet viewWithTag:99];
		
		//Fetching of section name and category from picker list
		
		if([pickerSelectioList count] > 0) {
			NSString *cellValue;
			NSObject *rowValue = [pickerSelectioList objectAtIndex:[picker selectedRowInComponent:0]];
			int recordId = -1;//for fetching id of section and category
			if([rowValue isKindOfClass:[Section class]]) {
				Section *option = (Section *)rowValue;
				selectedSection = option;
				cellValue = option.sectionName;
				recordId = option.sectionId;
			} else if([rowValue isKindOfClass:[Category class]]) {
				Category *option = (Category *)rowValue;
				cellValue = option.categoryName;
				recordId = option.categoryId;
			}
			[userCell.btnPicker setTitle:cellValue forState:UIControlStateNormal];
			userCell.userData.fieldTempValue = cellValue;
			userCell.userData.fieldId = recordId;
			userCell.lblFieldValue.text = cellValue;
			userCell.txtFieldValue.text = cellValue;
		}
	} 
}

#pragma mark -
#pragma mark PickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	return [pickerSelectioList count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSObject *rowValue = [pickerSelectioList objectAtIndex:row];
	
	//setting values of section name and category name to the form field from picker list
	
	if([rowValue isKindOfClass:[Section class]]) {
		Section *option = (Section *)rowValue;
		return option.sectionName;
	} else if([rowValue isKindOfClass:[Category class]]) {
		Category *option = (Category *)rowValue;
		return option.categoryName;
	}
	return NULL_STRING;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 240;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
	[spinner release];
	[tableView release];
	[backImg release];
	[fields release];
	[cellDictionary release];
    [super dealloc];
}
- (void)appImageDidUpload {
	//NSString *xmlContent = [[NSString alloc] initWithData:imageUploader.activeDownload encoding:NSUTF8StringEncoding];
	[self requestCompleted];
	imageUploader = nil;
}

@end

