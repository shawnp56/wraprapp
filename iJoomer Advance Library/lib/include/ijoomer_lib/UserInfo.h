//
//  UserInfo.h
//  iJoomer
//
//  Created by Tailored Solutions on 25/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

//com.icms.ijoomeradvance

@interface UserInfo : NSObject {
	
	BOOL	 isRequired;
	int		 fieldId;
    NSString *Id;
	NSString *groupName;
	NSString *fieldName;
	NSString *fieldValue;
	NSString *fieldTempValue;
	NSString *fieldType;
	NSString *fieldCaption;
	NSMutableArray *fieldList;
	NSMutableArray *optionList;
    NSMutableDictionary *dictprivacy;
    
// vm **********
    NSString *operand;
    float price;
//****************
}
@property(assign)int code;
@property(assign)int fieldId;
@property(nonatomic, retain)NSString *groupName;
@property(nonatomic, retain)NSString *fieldName;
@property(nonatomic, retain)NSString *fieldValue;
@property(nonatomic, retain)NSString *fieldTempValue;
@property(nonatomic, retain)NSString *fieldType;
@property(nonatomic, retain)NSString *fieldCaption;
@property(nonatomic, retain)NSString *Id;
@property(nonatomic, retain)NSMutableArray *fieldList;
@property(nonatomic, retain)NSMutableArray *optionList;
@property(nonatomic, retain)NSMutableDictionary *dictprivacy;
@property(nonatomic, readwrite)BOOL isRequired;

// vm ****************************************
@property(nonatomic, retain)NSString *operand;
@property(nonatomic, readwrite)float price;
//********************************************
@property(nonatomic, retain)NSMutableArray *nameArray;
@property(nonatomic, retain)NSMutableArray *typeArray;
@property(nonatomic, retain)NSMutableArray *valueArray;
@property(nonatomic, readwrite)BOOL isSelectedEmail;
@property(nonatomic, readwrite)BOOL isSelectedOnsite;
@property(nonatomic, readwrite)BOOL isSelectedPush;
@property(nonatomic, readwrite)BOOL isSelected;

-(void)setNewValue;

@end
