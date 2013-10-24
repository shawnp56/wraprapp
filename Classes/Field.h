//
//  Field.h
//  iJoomer
//
//  Created by Tailored Solutions on 18/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Field : NSObject {
	NSString *name;
	NSString *value;
	NSString *caption;
	NSMutableArray *fields;
	NSString *fieldType;

}
@property(nonatomic, retain)NSString *name;
@property(nonatomic, retain)NSString *value;
@property(nonatomic, retain)NSString *caption;
@property(nonatomic, retain)NSMutableArray *fields;
@property(nonatomic, retain)NSString *fieldType;

@end
