//
//  Option.h
//  iJoomer
//
//  Created by Tailored Solutions on 29/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Option : NSObject {

	NSString *name;
	NSString *value;
    NSString *caption;
	BOOL isSelected;
    BOOL isSeletionRequired;
    
    // vm
    
    NSString *tempName;
    NSString *operand;
    NSString *ID;
    NSString *url;

    float price;
    UIImage *thumbImg;
    
}
@property(nonatomic, retain)UIImage *thumbImg;

@property(nonatomic, retain)NSString *name;
@property(nonatomic, retain)NSString *caption;
@property(nonatomic, retain)NSString *value;
@property(nonatomic, readwrite)BOOL isSelected;
@property(nonatomic, readwrite)BOOL isSeletionRequired;

// vm

@property(nonatomic, retain)NSString *tempName;
@property(nonatomic, retain)NSString *operand;
@property(nonatomic, retain)NSString *ID;
@property(nonatomic, retain)NSString *url;
@property(nonatomic, readwrite)float price;
@property(nonatomic, readwrite)BOOL isSelectedEmail;
@property(nonatomic, readwrite)BOOL isSelectedOnsite;
@property(nonatomic, readwrite)BOOL isSelectedPush;

@property (nonatomic,assign) int contactId;
@property(nonatomic, retain)NSString *email;

@end
