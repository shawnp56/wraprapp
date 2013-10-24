//
//  Category.h
//  iJoomer
//
//  Created by Tailored Solutions on 30/08/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Option.h"
#import "IconDownloader.h"

@interface Category : NSObject <IconRecord> {

}

/////////new declaretion var//////
@property (nonatomic, retain) NSMutableArray *subCategoryList;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, readwrite) NSInteger Id;
@property (nonatomic, readwrite) NSInteger categories;
@property (nonatomic, readwrite) NSInteger groups;
@property (nonatomic, readwrite) NSInteger parent;
@property (nonatomic, readwrite) NSInteger totalWall;
@property (nonatomic, readwrite) NSInteger totalDiscussions;
@property (nonatomic, readwrite) NSInteger totalMembers;


//////////////////////////////////

@property (nonatomic, retain) NSMutableArray *commentList;
@property (nonatomic, retain) NSMutableArray *nearByList;
@property (nonatomic, retain) NSMutableArray *subCategoryFlagList;

@property (nonatomic, readwrite) NSInteger albumID;
@property (nonatomic, readwrite) NSInteger sectionId;
@property (nonatomic, retain) NSString *albumName;
@property (nonatomic, retain) NSString *albumDesc;
@property (nonatomic, retain) NSMutableArray *photos;
@property (nonatomic, retain) NSMutableArray *specialPhotos;
@property (nonatomic, retain) NSMutableArray *subCategories;
@property (nonatomic, readwrite) NSInteger cacheflag;
@property (nonatomic, readwrite) NSInteger categoryId;
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSMutableArray *articles;
@property(nonatomic, readwrite) NSInteger totalArticle;
@property (nonatomic, retain) Option *option;
@property (nonatomic, retain) NSString *introtext;
@property (nonatomic,retain) NSString *thumbURL;
@property (nonatomic,retain) UIImage *thumbImg;
@property (nonatomic,retain) UIImage *iconImg;
@property (nonatomic, readwrite) NSInteger hits;
@property (nonatomic, readwrite) NSInteger itemCount;
@property (nonatomic, readwrite) NSInteger itemId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSMutableArray *entries;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic,retain) UIImage *bigImage;
@property (nonatomic, retain) NSString *createdOn;
@property (nonatomic, retain)NSString *voteURL;
@property (nonatomic, retain)UIImage *voteImg;
@property (nonatomic, readwrite)NSInteger review;
@property (nonatomic, retain) NSMutableArray *reviewlist;
@property (nonatomic, retain) NSMutableArray *entryList;
@property (nonatomic, retain) NSMutableArray *groupList;
@property (nonatomic, readwrite)float	 latitude;
@property (nonatomic, readwrite) float	 longitude;
@property (nonatomic, retain)NSString *Street;
@property (nonatomic, readwrite)NSInteger Zipcode;
@property (nonatomic, retain)NSString *City;
@property (nonatomic, retain)NSString *County;
@property (nonatomic, retain)NSString *Country;
@property (nonatomic, retain)NSString *FerdralState;
@property (nonatomic, retain)NSString *desc;
@property (nonatomic, retain)NSString *email;
@property (nonatomic, retain)NSString *number;
@property (nonatomic, retain)NSString *fax;
@property (nonatomic, retain)NSString *website;
@property (nonatomic, retain) NSString *websiteName;
@property (nonatomic, retain) NSString *websiteUrl;

@property (nonatomic, readwrite) NSInteger blogCount;
@property (nonatomic, readwrite) NSInteger sectionID;
@property(nonatomic, retain) NSString *mapIcon;
@property(nonatomic, retain) UIImage  *mapImg;
@property (nonatomic , readwrite) BOOL isentry;
@property(nonatomic, readwrite) int likeCount;
@property(nonatomic, readwrite) int dislikeCount;
@property(nonatomic, readwrite) int commentCount;
@property(nonatomic, readwrite) BOOL isLiked;
@property(nonatomic, readwrite) BOOL isDisliked;
@property(nonatomic, readwrite) BOOL isDeleteAllowed;
@property(nonatomic, readwrite) BOOL isEditAllowed;

@property (nonatomic, retain) NSString *date;
@property(nonatomic, readwrite) int user_profile;
@property(nonatomic, readwrite) int permission;
@property (nonatomic,retain) NSString *user_avatar;
@end
