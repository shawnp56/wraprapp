//
//  FormController.h
//  iJoomer
//
//  Created by Tailored Solutions on 20/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestResponseManager.h"
#import "RequestManager.h"
#import "ImageUploader.h"
#import "ImageUploader.h"


@class UserInfo;
@class TableCellOwner;
@class MoreCell;
@class UserDetailCell;
@class User;
@class Section;

@interface FormController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,
RequestManagerDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ImageUploaderDelegate> {
	
	IBOutlet UITableView *tableView;
	IBOutlet UIActivityIndicatorView *spinner;
	IBOutlet UIImageView *backImg;
	
	NSMutableArray *fields;
	NSMutableDictionary *cellDictionary;
	
	TableCellOwner *cellOwner;
	UserDetailCell *userCell;
	
	ImageUploader *imageUploader;
	NSArray *pickerSelectioList; //to store values of picker value
	
	Section *selectedSection;
}

@property (nonatomic, assign) NSMutableArray *fields;
@property (nonatomic , assign)UserDetailCell *userCell;
@property (nonatomic ,assign)User *userDetail;

- (IBAction)cellSelectionButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;

- (void) themechange;
- (void) fetchData;
- (void)postData; //to post data to server
- (void)saveUserDetails;
- (void)showAlert:(NSString *)title Content:(NSString *)bodyText;
- (NSData*)createFormData:(NSDictionary*)myDictionary withBoundary:(NSString*)myBounds;

@end
