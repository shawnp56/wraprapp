//
//  Category.m
//  iJoomer
//
//  Created by Tailored Solutions on 30/08/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "Category.h"


@implementation Category

/////////new declaretion var//////
@synthesize subCategoryList;
@synthesize name;
@synthesize description;
@synthesize Id;
@synthesize categories;
@synthesize groups;
@synthesize parent;
//////////////////////////////////


@synthesize albumID;
@synthesize albumName;
@synthesize albumDesc;
@synthesize photos;
@synthesize specialPhotos;
@synthesize cacheflag;
@synthesize categoryId;
@synthesize categoryName;
@synthesize articles;
@synthesize totalArticle;
@synthesize subCategories;
@synthesize option;
@synthesize hits;
@synthesize thumbImg;
@synthesize thumbURL;
@synthesize itemCount;
@synthesize itemId;
@synthesize title;
@synthesize entries;
@synthesize bigImage;
@synthesize imageURL;
@synthesize createdOn;
@synthesize voteImg;
@synthesize review;
@synthesize voteURL;
@synthesize reviewlist;
//@synthesize groupList;
@synthesize latitude;
@synthesize longitude;
@synthesize entryList;
@synthesize Street;
@synthesize Zipcode;
@synthesize City;
@synthesize County;
@synthesize Country;
@synthesize FerdralState;
@synthesize desc;
@synthesize email;
@synthesize number;
@synthesize fax;
@synthesize website;
@synthesize sectionId;
@synthesize introtext;
@synthesize groupList;
@synthesize blogCount;
@synthesize websiteUrl;
@synthesize websiteName;
@synthesize sectionID;
@synthesize mapIcon;
@synthesize mapImg;
@synthesize iconImg;

//Sobi2
@synthesize nearByList;
@synthesize subCategoryFlagList;
@synthesize isentry;
@synthesize likeCount,dislikeCount,commentCount,commentList,isLiked,isDisliked,isDeleteAllowed,isEditAllowed;

@synthesize date;
@synthesize user_avatar;
@synthesize user_profile;
@synthesize permission;
-(id)init
{
	if(self == [super init]) {
		
        /////////new declaretion var//////
        subCategoryList = [[NSMutableArray alloc] init];;
        name = @"";
        description = @"";
        Id = 0;
        categories = 0;
        groups = 0;
        parent = 0;
        //////////////////////////////////
        
		albumName = @"";
		albumDesc = @"";
		thumbURL = @"";
		introtext =@"";
		thumbImg = nil;
		bigImage = nil;
		voteImg = nil;
        iconImg = nil;
		imageURL = @"";
		createdOn = @"";
		voteURL = @"";
		Street = @"";
		Zipcode = 0;
		City = @"";
		County = @"";
		Country = @"";
		FerdralState = @"";
		desc = @"";
		review = 0;
		hits = 0;
		itemCount = 0;
		itemId  = 0;
		sectionId = 0;
		photos = [[NSMutableArray alloc] init];
		articles = [[NSMutableArray alloc] init];
        subCategories = [[NSMutableArray alloc] init];
        commentList = [[NSMutableArray alloc] init];
		title = @"";
		entries =  [[NSMutableArray alloc]init]; 
		reviewlist = [[NSMutableArray alloc]init];
		groupList = [[NSMutableArray alloc]init];
		entryList = [[NSMutableArray alloc]init];
        subCategoryFlagList = [[NSMutableArray alloc]init];
        nearByList = [[NSMutableArray alloc]init];
		email = @"";
		number = @"";
		fax = @"";
		website = @"";
        websiteName = @"";
        websiteUrl = @"";
        mapIcon =@"";
        
        date = @"";
        user_avatar = @"";
        user_profile = 0;
        permission = 0;
        
        mapImg = nil;
        isentry = NO;
        
        option = [[Option alloc]init];
	}
	return self;
}

- (void)dealloc {
    if (photos) {
       [photos release]; 
    }
	if (albumName) {
        [albumName release];
    }
	if (thumbURL) {
        [thumbURL release];
    }
	if (thumbImg) {
        [thumbImg release];
    }
	if (bigImage) {
        [bigImage release];
    }
    if (imageURL) {
        [imageURL release];
    }
    if (albumDesc) {
        [albumDesc release];
    }
    if (title) {
        [title release];
    }
    if (articles) {
        [articles release];
    }
    if (subCategories) {
        [subCategories release];
    }
    if (introtext) {
        [introtext release];
    }
    if (entries) {
        [entries release];
    }
    if (voteURL) {
        [voteURL release];
    }
    if (voteImg) {
        [voteImg release];
    }
    if (reviewlist) {
        [reviewlist release];
    }
    if (createdOn) {
        [createdOn release];
    }
    if (groupList) {
        [groupList release];
    }
    if (entryList) {
        [entryList release];
    }
    if (Street) {
        [Street release];
    }
    if (desc) {
        [desc release];
    }
    if (City) {
        [City release];
    }
    if (County) {
        [County release];
    }
    if (Country) {
        [Country release];
    }
	if (FerdralState) {
      [FerdralState release];  
    }
    if (email) {
        [email release];
    }
    if (number) {
        [number release];
    }
    if (fax) {
       [fax release]; 
    }
    if (website) {
        [website release];
    }
    if (option) {
        [option release];
    }
    if (websiteName) {
        [websiteName release];
    }
    if (websiteUrl) {
        [websiteUrl release];
    }
    if (mapImg) {
        [mapImg release];
    }
    if (mapIcon) {
        [mapIcon release];
    }
    if (nearByList) {
        [nearByList release];
    }
	if (subCategoryFlagList) {
       [subCategoryFlagList release]; 
    }
	if (iconImg) {
       [iconImg release]; 
    }
    if (commentList) {
        [commentList release];
    }
    //[groupList release];
    [super dealloc];

}
/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// IconRecord Delegate Methods //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)getImageURL {
	return self.thumbURL;
}

- (void)setImage:(UIImage *)image ImageKey:(NSString *)imageKey {
	if (image) {
		self.thumbImg = image;
	}
	self.thumbURL = @"";	
}

- (void)imageDownloadingError:(NSString *)imageKey {
	thumbURL = @"";
}

@end