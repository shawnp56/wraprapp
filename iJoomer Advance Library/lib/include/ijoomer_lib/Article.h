//
//  Article.h
//  iJoomer
//
//  Created by Tailored Solutions on 07/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"

@class Category;

@interface Article : NSObject<IconRecord> {
	
}

@property(nonatomic, readwrite)int catId;
@property(nonatomic, readwrite)int userId;
@property(nonatomic, readwrite)int Id;
@property(nonatomic, readwrite) NSInteger articleid;
@property(nonatomic, retain) NSString *articletitle;
@property(nonatomic, retain) NSString *introtext;
@property(nonatomic, readwrite) NSInteger articlehits;
@property(nonatomic, retain) NSString *writtenby;
@property(nonatomic, retain) NSString *date;
@property(nonatomic, retain) NSString *articledesc;
@property(nonatomic, readwrite) NSInteger articleCount;
@property(nonatomic, retain) NSMutableArray *grouplist;
@property(nonatomic, retain) NSMutableArray *reviewlist;
@property(nonatomic, retain) NSMutableArray *reviewFieldList;
@property(nonatomic, retain) NSMutableArray *criteriaList;
@property(nonatomic,readwrite)NSInteger sectionID;

@property(nonatomic, retain)Category *imageList;
@property(nonatomic, retain)NSString *thumbURL;
@property(nonatomic, retain)UIImage *thumbImg;
@property(nonatomic, readwrite)float editorRating;
@property(nonatomic, readwrite)int editorCount;
@property(nonatomic, readwrite)float userRating;
@property(nonatomic, readwrite)int userCount;
@property(nonatomic, readwrite)BOOL isDetailAvailable;
@property(nonatomic, readwrite)BOOL isReviewAllow;
@property(nonatomic, readwrite)BOOL downloaded;
@property(nonatomic, retain)NSString *youtubeURL;
@property(nonatomic, retain)NSString  *reviewTitleMode;
@property(nonatomic, retain)NSString  *reviewContentMode;
@property(nonatomic, readwrite)float latitude;
@property(nonatomic, readwrite)float longitude;
@property(nonatomic, readwrite)float distance;
@property(nonatomic, readwrite)int scal;
@property(nonatomic, readwrite)int increment;
@property(nonatomic, readwrite)int graphType;
@property(readwrite) int uploadImageLimit;
@property(nonatomic, retain) NSString *mapIcon;
@property(nonatomic, retain) UIImage  *mapImg;

@end
