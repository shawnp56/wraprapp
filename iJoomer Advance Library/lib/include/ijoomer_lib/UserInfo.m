//
//  UserInfo.m
//  iJoomer
//
//  Created by Tailored Solutions on 25/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo

@synthesize code;
@synthesize groupName;
@synthesize fieldId;
@synthesize fieldName;
@synthesize fieldTempValue;
@synthesize fieldValue;
@synthesize fieldType;
@synthesize isRequired;
@synthesize fieldList;
@synthesize fieldCaption;
@synthesize optionList;
@synthesize Id;
@synthesize dictprivacy;
@synthesize nameArray,typeArray,valueArray,isSelected;
@synthesize isSelectedEmail,isSelectedOnsite,isSelectedPush;

// vm

@synthesize operand,price;


-(id)init
{
    self = [super init];
	if(self) {
		groupName = @"";
		fieldName = @"";
		fieldValue = @"";
		fieldTempValue = @"";
		fieldType = @"";
		fieldCaption = @"";
        Id = @"";
		fieldList = [[NSMutableArray alloc] init];
		optionList = [[NSMutableArray alloc] init];
        dictprivacy = [[NSMutableDictionary alloc] init];
        nameArray = [[NSMutableArray alloc] init];
        typeArray = [[NSMutableArray alloc] init];
        valueArray = [[NSMutableArray alloc] init];
        // vm
        
        operand=@"";
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)setNewValue
{
	self.fieldValue = self.fieldTempValue;
}

@end
