//
//  iCMSApplicationData.h
//  iJoomer
//
//  Created by Tailored Solutions on 4/9/13.
//
//

#import <Foundation/Foundation.h>
#import "AppConstantsList.h"
#import "Reachability.h"
#import "FBConnect.h"
#import "iCMSArticle.h"



@class SA_OAuthTwitterEngine;
@class SQLiteManager;
@class User;

@interface iCMSApplicationData : NSObject {
    
    NSString *StrClassName;
    
    NSString *bgImage;
    NSString *newtheme;
    NSString *oldtheme;
    NSString *navBarImg;
    NSString *tabBarImg;
    NSString *checkImg;
    NSString *uncheckImg;
    
    User *userDeatail;
    
    UIColor *textcolor;
    UIColor *textcolorhead;
    UIColor *tintColor;
    
    BOOL themeChanged;
    int pageLimit;
    int totalArchived;
    int totalFeatured;
    int totalArticle;
    
   
    
    NSDictionary *themeDictionary;
	NSDictionary *valuePicker;
	NSArray *dataForPicker;
    
    NSMutableArray *iCMSCategoryList;
    NSMutableArray *iCMSArticleList;
    NSMutableArray *iCMSFeaturedArticleList;
    NSMutableArray *iCMSArchivedArticleList;
    NSMutableArray *contactsArray;
    NSMutableArray *favoriteArticleList;
    iCMSArticle *article;
    
    
    // To check newtwork status
	Reachability* wifiReach;
	NetworkStatus currentNetworkStatus;
    
	// Error Code
	iJoomerErrorCode errorCode;
    
    // facebook
	//Facebook *facebook;
    NSMutableDictionary *userPermissions;
    
    // Twitter object
    SA_OAuthTwitterEngine *twitter;
    
    // Database handler
	SQLiteManager *sqlManager;
    
    ///////Theme, application Menu /////////////
    
    //Data fetch and store ina db flags.
    BOOL feturedListFlag;
    BOOL archiveListFlag;
    BOOL categoryListFlag;
    BOOL articalListFlag;
}

@property(nonatomic, retain) NSString *StrClassName;

@property (nonatomic,retain) User *userDeatail;
@property (nonatomic,assign) int pageLimit;
@property (nonatomic,assign) int totalArchived;
@property (nonatomic,assign) int FeaturedpageLimit;
@property (nonatomic,assign) int totalFeatured;
@property (nonatomic,assign) int ArticlepageLimit;
@property (nonatomic,assign) int totalArticle;

@property(nonatomic, retain) Facebook *facebook;
@property(nonatomic, retain) SA_OAuthTwitterEngine *twitter;
@property (nonatomic,retain) NSString *navBarImg;
@property (nonatomic,retain) NSString *tabBarImg;
@property(nonatomic, retain) NSString *bgImage;
@property(nonatomic, retain) NSString *newtheme;
@property(nonatomic, retain) NSString *oldtheme;
@property(nonatomic, retain) NSString *checkImg;
@property(nonatomic, retain) NSString *uncheckImg;
@property (nonatomic,retain) NSString *wallRemoveImg; // $
@property (nonatomic,retain) NSString *cellbackImg;  // $
@property BOOL showTabs;   // $
@property(nonatomic, retain)SQLiteManager *sqlManager;

@property (nonatomic,retain) iCMSArticle *article;

@property(nonatomic, readwrite) BOOL themeChanged;
@property(assign)iJoomerErrorCode errorCode;
@property(nonatomic, retain) UIFont *header1;
@property(nonatomic, retain) UIFont *header2;
@property(nonatomic, retain) UIFont *header3;
@property(nonatomic, retain) UIFont *header4;
@property(nonatomic, retain) UIFont *header5;
@property(nonatomic, retain) UIFont *header6;
@property(nonatomic, retain) UIFont *header7;
@property(nonatomic, retain) UIFont *header8;
@property(nonatomic, retain) UIFont *header9;

@property(nonatomic, retain) UIColor *textcolor;
@property(nonatomic, retain) UIColor *textcolorhead;
@property(nonatomic, retain) UIColor *tintColor;
@property(nonatomic, retain) UIColor *tabtextcolor;
@property(nonatomic, retain) UIColor *moreCellBackColor;

@property (nonatomic,retain) NSMutableArray *iCMSCategoryList;
@property (nonatomic,retain) NSMutableArray *iCMSArticleList;
@property (nonatomic,retain) NSMutableArray *iCMSFeaturedArticleList;
@property (nonatomic,retain) NSMutableArray *iCMSArchivedArticleList;
@property (nonatomic,retain) NSMutableArray *contactsArray;
@property (nonatomic,retain) NSMutableArray *favoriteArticleList;

///////Theme, application Menu /////////////

//Data fetch and store ina db flags.
@property(assign) BOOL feturedListFlag;
@property(assign) BOOL archiveListFlag;
@property(assign) BOOL categoryListFlag;
@property(assign) BOOL articalListFlag;

+(iCMSApplicationData*) sharedInstance;
- (void) reachabilityChanged:(NSNotification *)note;
+(NSString *)encodeStringForURL:(NSString *)originalURL;

- (void)readFavoritArticle;
- (bool)addToFavoritList;
- (bool)deleteFromFavoriteList;

- (void) changeTheme;

///Tabbar menu set.
-(void)TabReset;
@end
