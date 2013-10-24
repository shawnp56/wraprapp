//
//  Review.h
//  iJoomer
//
//  Created by Tailored Solutions on 13/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Review : NSObject {
	NSInteger Id;
    NSInteger userId;
	NSString *title;
	NSString *text;
	NSString *reviewersName;
	NSString *reviewersEmail;
	float reviewersRating;
	NSString *reviewersDate;
	NSMutableArray *grouparray;
	NSMutableArray *commentarray;

}

@property(nonatomic, readwrite) NSInteger Id;
@property(nonatomic, readwrite) NSInteger userId;
@property(nonatomic, retain)NSString *title;
@property(nonatomic, retain)NSString *text;
@property(nonatomic, retain)NSString *reviewersName;
@property(nonatomic, retain)NSString *reviewersEmail;
@property(nonatomic, readwrite)float reviewersRating;
@property(nonatomic, retain)NSString *reviewersDate;
@property(nonatomic, retain)NSMutableArray *grouparray;
@property(nonatomic, retain)NSMutableArray *commentarray;

@end
