//
//  ApplicationData.h
//  iJoomer
//
//  Created by Tailored Solutions on 03/07/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstantsList.h"
#import "Reachability.h"
#import "FBConnect.h"

#define DB_NAME						@"JoomerLib_IOS2.0.sqlite"

@class GPSLocationListner;
@class User,Article;
@class Privacy;
@class ChatHeartbeat;
@class SA_OAuthTwitterEngine;
@class Data;
@class SQLiteManager;

@interface ApplicationData : NSObject<NSXMLParserDelegate> {
    
    //Voice data.
    NSData *Voicedata;

	NSInteger loggedUser;
	NSInteger locationUpdated;
	NSInteger userId;
    int dataID;
    int replyID;
    
	NSString *mainServerURL;
	NSString *sessionId;
	NSString *bgImage;
	NSString *selectedbutton;
	NSString *radioselected;
	NSString *radiononselected;
	NSString *commentbar;
	NSString *commentbackground;
	NSString *likeimg;
	NSString *unlikeimg;
	NSString *likebackground;
	NSString *recipient;
	NSString *transimg;
	NSString *disclosureimg;
	NSString *msgdisclosureimg;
	NSString *outboxmsgimg;
	NSString *mailreceiveimg;
	NSString *mailsendimg;
	NSString *mailwriteimg;
	NSString *viewdetailimg;
	NSString *inboxmsgimg;
	NSString *pictureimg;
	NSString *videoimg;
	NSString *folderimg;
	NSString *sepratorimg;
	NSString *fontname;
	NSString *addcommentbtn;
	NSString *textViewImg;
    NSString *msgSubjtextImg;
	NSString *newtheme;
	NSString *oldtheme;
	NSString *pinImg;
    
    int totalInMsg;
    int totalOutMsg;

    
	UIColor *tintColor;
	UIColor *color;   //background color and border color
	UIColor *textcolor; 
	UIColor *sepratorcolor;
	UIColor *segmentcolor;
	UIColor *inputtxtColor;
	UIColor *textcolorhead;
	UIColor *textcolortime;
	UIColor *txtmsgcolor;
	UIColor *txtviewColor;
	UIColor *timecolor;
	UIColor *cellbackgroundcolor;
	UIFont *header1;
	UIFont *header2;
	UIFont *header3;
	UIFont *header4;
	UIFont *header5;
	UIFont *header6;	
	UIFont *header7;
	UIFont *header8;
	UIFont *header9;

    
//    jom social confing
    
    int friendListLimit;
    int memberListLimit;
    int searchListLimit;
    int activitiesListLimit;
//    vm theme
    
    UIColor *vmtextcolorheader;
    NSString *backbtnImage;
    NSString *barbtnImage;
    NSString *addbtnImage;
    NSString *tableHeaderImg;
    NSString *addbgImage;
    NSString *priceboxImage;
    NSString *imgbottomLine;
    NSString *couponcodeImage;
    NSString *searchImg;
    NSString *vmarrow;
    NSString *qtyAddImg;
    NSString *minusImg;
    NSString *vmRadioSelect;
    NSString *vmRadioUnSelect;
    NSString *selButton;
    NSString *whiteStarImg;
    NSString *redStarImg;
    NSString *relatedProdImage;
    
	BOOL themeChanged;
	BOOL userDetailCached;
	BOOL isEditMode;
    BOOL isLoginRequired;
	
	int totalFriends;
	int totalMembers;
	int totalSearched;
	int totalRecords;
	
	NSDictionary *themeDictionary;
	NSDictionary *valuePicker;
	NSArray *dataForPicker;
	
	User *selectedUser;
	User *userDetail;
    User *galleryUser;

    NSMutableArray *tabList;
    NSMutableArray *profilemenuList;
    NSMutableArray *friendmenuList;
	NSMutableArray *profileTypeList;
	NSMutableArray *inboxList;
	NSMutableArray *outboxList;
	NSMutableArray *albumList;
	NSMutableArray *friendList;
	NSMutableArray *memberList;
	NSMutableArray *notificationList;
	NSMutableArray *unreadMsgList;
	NSMutableArray *updatesList;

	NSMutableArray *searchList;
	NSMutableArray *directoryList;
	NSMutableArray *collectionList;
	NSMutableArray *grouplist;
	NSMutableArray *storelist;
	NSMutableArray *videolist;
	NSMutableArray *chatList;
	NSMutableArray *chatingList;
	NSMutableArray *eventList;
    NSArray *profileMenuImages;
    NSArray *friendMenuImages;
    NSMutableArray *settingFieldList;
    
    NSMutableArray *Scategories;
	NSMutableArray *ScatEntries;
	NSMutableArray *SPROcategories;
	NSMutableArray *SPROcatEntries;
	NSMutableArray *configArray;
	NSString *categoryView;
	NSString *featuredView;
	NSString *mapKey;
	NSString *entryView;
	NSString *PROcategoryView;
	NSString *PROentryView;
	NSString *PROfeaturedView;
	NSMutableArray *searchArray;
	NSMutableArray *PROsearchArray;
	NSMutableArray *businessDetail;
	NSMutableArray *SfeaturedArray;
	BOOL ISREVIEWREQUIRED; 
	BOOL ISRADIUSREQUIERED;
	BOOL ISFEATURED;
	BOOL ISGALLERY;
	BOOL ISFEATUREDREQUIRED;
	BOOL ISICONREQUIRED;
	BOOL ISIMAGEREQUIRED;
	
	
	BOOL ISPROREVIEWREQUIRED; 
	BOOL ISPRORADIUSREQUIERED;
	BOOL ISPROFEATURED;
	BOOL ISPROGALLERY;
	BOOL ISPROFEATUREDREQUIRED;
    
    // blog
    
    int totalBlogComments;
    int totalMyBlogs;
    int totalMyComments;
    int totalMyHits;
    int totalTagBlogCount;
    int totalBlogItems;
    int totalBlogs;
    
    NSMutableArray *blogCategoryList;
	NSMutableArray *bloglist;
    NSMutableArray *MyBlogList;
    NSMutableArray *MyBlogCommentList;
    NSMutableArray *tagList;
    NSMutableArray *myTagList;
    NSMutableArray *tagBloglist;
    NSMutableArray *categoryBloglist;

    NSString *website;
    NSString *emailAdd;
    
    //group
    BOOL isGroupEnable,isGroupCreate,isCreateAnnouncement,isCreateDiscussion,isGroupPhotos,isGroupVideos,isGroupEvent;
    int groupcount;
    
    int inviteMemberCount;
    int totalAdmin;
    int totalMemberCount;
    int totalBannedCount;
    
    NSMutableArray *mygroupList;
    NSMutableArray *pendinglist;
    NSMutableArray *groupCategoryList;
    BOOL isViewDidload;

    
    //kunena
    BOOL isReload;
    int totalfavcount;
    int totalmytopiccount;
    int totalrecentcount;
    int totalsubscribecount;
	NSMutableArray *categoryList;   //Array to store all the Objects of Category Class
	NSMutableArray *recentTopics;
    NSMutableArray *recentTopicList;
	NSMutableArray *favoriteTopics;   //Array to store objects of Topic Class which are set as Favorite by the user
	NSMutableArray *subscribedTopics; 
//Array to store objects of Topic Class which are Subscribed by the user
    
    
	// jom social
	
    int jomTotalCount;
    int jomMyEventCount;
    int jomPendingEventCount;
    int jomPastEventCount;
	int eventLikeCnt;
	int eventDisLikeCnt;
    
	NSString *errorMessage;
	BOOL allowCreateEvent;
	NSMutableArray *jomCategoryList;
	NSMutableArray *jomEventList;
	NSMutableArray *jomMyEventList;
	NSMutableArray *jomPastEvents;
	NSMutableArray *jomPendingList;
	NSMutableArray *jomAdminList;
	NSMutableArray *jomGuestList;
	NSMutableArray *jomSpecialEventList;
	NSMutableArray *jomSpecialGalleryAlbumList;
	NSMutableArray *jomSpecialGalleryList;

    
    User *userLoggedIn;
    Data *data;
    
    BOOL showFeaturedPrice;
    BOOL showFeaturedYouSave;
    BOOL showAddCart;
    BOOL showPrice;
    BOOL showYouSave;
    BOOL showWishList;
    BOOL showDescription;
    BOOL billingInfo;
    BOOL cartReload;
    BOOL feature;
    BOOL invaliData;
    BOOL fromVm;
    
    int totalProducts;
    int totalSearch;
    int totalCat;
    
    float subTotalInt;
    float taxInt;
    float shippingInt;
    float floatPrice;
    
    NSString *infoID;
    NSString *shipInfoID;
    NSString *shipMethodID;
    NSString *shippingFee;
    NSString *productView;
    NSString *featuredProductView;
    NSString *paymentMode;
    NSString *subTax;
    NSString *subTotal;
    NSString *response;
    NSString *countryId;
    NSString *vmRecipient;
    
    NSMutableArray *featuredProductList;
    NSMutableArray *wishListProductList;
    NSMutableArray *latestProductList;
    NSMutableArray *cartProductList;
	NSMutableArray *sortList;
    NSMutableArray *wishDetailList;
	NSMutableArray *attribList;
    NSMutableArray *cartArray;
    NSMutableArray *orderDetailList;
    NSMutableArray *relatedProductList;
    NSMutableArray *fullWishListArray;
    NSMutableArray *wishArray;
    NSMutableArray *wishDetailArray;
    NSMutableArray *wishListingArray;
    NSMutableArray *searchCategoryArray;
    NSMutableArray *myAccountArray;
    NSMutableArray *vmcategoryList;
    
	//store the path for msg compose image. 
	User *user;   //Reference to the Current LoggedIn User
    // Error Code
	
	NSMutableArray *tabBaritemsArray;
    
    BOOL isDataFetched;
    
    NSMutableArray* _stack;
    NSMutableArray* _nameStack;
    id _rootObject;
    NSString* _rootName;
    NSMutableString* _chars;
    NSError* _parseError;
    
	// To check newtwork status
    Reachability* wifiReach;
	NetworkStatus currentNetworkStatus;
	
	// GPS data listner
	GPSLocationListner *locationManager;
	
	// Error Code
	iJoomerErrorCode errorCode;
	
	// HTTP Request type
	HTTPRequest currentRequestType;
	
	// facebook
	Facebook *facebook;
    NSMutableDictionary *userPermissions;
    
    // Twitter object
	SA_OAuthTwitterEngine *twitter;
    
    // Database handler
	SQLiteManager *sqlManager;
    
    // new theme
    
    NSString *settingBtnImg;
    NSString *topImg;
    NSString *bottomImg;
    NSString *remeberbackImg;
    NSString *checkImg;
    NSString *uncheckImg;
    
    UIColor *loggedUserNameColor;
    UIImageView *activityImageView;
    
    int myGroup;
    int allGroup;
    int PendingInvitation;
    
    
    NSString *distance;
    NSMutableArray *categoryEntryArray;
    BOOL ISCATEGORYHITSREQ;
    NSString *selectedTab;
    
    
    //Theme
    NSString *homebutton;
    NSString *createaccountbutton;
    UIColor *celltextcolor;
    UIColor *VMtextcolor;
    NSString *VMbackImg;
    NSString *MorebackImg;
    NSString *wallcellbottom;
    NSString *wallcellbottomdefault;
    //Keep Session live 
    
    int counter;
    float joomlasessiontime;
    float ijoomersessiontime;
    int sessiontime;
    
    int ijoomertime;
    int  joomlatime;
    NSTimer *sessiontimer;
    NSDate *startDate;
    int touchCount;
    NSString *timeString;
    int currenttime;
    int totalSec;
    BOOL isLoggedIn;
    NSMutableArray *groupArray;
    NSMutableArray *eventArray;
    NSMutableArray *photoArray;
    NSMutableArray *videoArray;
    NSMutableArray *profileArray;
//    NSString *newSplaceUrl;
//    UIImage *newSplaceImage;
//    UIImageView *newSplaceImageView;
//    NSTimeInterval timerStartTime;
//    NSTimer *timer;
    int frndCount;
    int msgCount;
    int groupCount;
    NSMutableArray *albumArray;
    NSMutableArray *allAlbumArray;
    NSMutableArray *contactsArray;
    NSMutableArray *videoCategoryArray;
    NSMutableArray *myVideos;
    NSMutableArray *AllVideos;
    BOOL isDeleted;
    int albumId;
    
    
    
    ////////////////////////// jom social //////////////////////////
    NSString *subMenu;
    NSString *subMenuSep;

    int totalAllAlbums;
    int totalMyAlbums;
    int totalAllVideos;
    int totalMyVideos;
    NSString *downloadImg;
    NSString *delImg;
    NSString *reportImg;
    NSMutableArray *groupFieldsArray;
    NSMutableArray *eventFieldsArray;
    Article *selectedCollection;
    NSString *shareImg;
    NSString *incomingMsg;
    NSString *outgoingMsg;
    
    //stor state or city name.
    NSString *MapCityname;
    NSString *MapStatename;
    int Flag_City_State;
    int Flag_MapDone;
    
    //image upload int.
    int flag_ImgUpload;
    int flag_Imgtotalcount;
    BOOL flag_imageUP;
    
}
//image upload int 
@property (assign, nonatomic)int flag_ImgUpload;
@property (assign, nonatomic)int flag_Imgtotalcount;
@property (assign, nonatomic)BOOL flag_imageUP;

//Voice Data.
@property (assign, nonatomic) NSData *Voicedata;

//stor state or city name.
@property(nonatomic, readwrite)int Flag_City_State;
@property(nonatomic, readwrite)int Flag_MapDone;
@property(nonatomic, retain) NSString *MapCityname;
@property(nonatomic, retain) NSString *MapStatename;

///default_landing_screen handler.
@property(assign)BOOL DefaultLandingscreenFlag;

// Database handler
@property(nonatomic, retain)SQLiteManager *sqlManager;

@property(nonatomic, readwrite)BOOL isDeleted;
@property(nonatomic, readwrite)int albumId;
@property(nonatomic, readwrite)int frndCount;
@property(nonatomic, readwrite)int msgCount;
@property(nonatomic, readwrite)int groupCount;
@property(nonatomic, retain) NSMutableArray *albumArray;
@property(nonatomic, retain) NSMutableArray *allAlbumArray;
@property(nonatomic, retain) NSMutableArray *contactsArray;
@property(nonatomic, retain) NSMutableArray *videoCategoryArray;
@property(nonatomic, retain) NSMutableArray *AllVideos;
@property(nonatomic, retain) NSMutableArray *myVideos;
//@property(nonatomic, retain) NSString *newSplaceUrl;
//@property(nonatomic, retain) UIImage *newSplaceImage;
//@property(nonatomic, readwrite) BOOL loadSplace;

// //Keep Session live
@property(nonatomic, retain) NSMutableArray *groupArray;
@property(nonatomic, retain) NSMutableArray *eventArray;
@property(nonatomic, retain) NSMutableArray *photoArray;
@property(nonatomic, retain) NSMutableArray *videoArray;
@property(nonatomic, retain) NSMutableArray *profileArray;
@property(nonatomic,readwrite)int totalSec;
@property(nonatomic,readwrite)int counter;
@property(nonatomic,readwrite)float joomlasessiontime;
@property(nonatomic,readwrite)float ijoomersessiontime;
@property(nonatomic,readwrite)int sessiontime;
@property (nonatomic, readwrite)BOOL isLoggedIn;
//Theme
@property(nonatomic, retain) NSString *homebutton;
@property(nonatomic, retain) NSString *createaccountbutton;
@property(nonatomic, retain) UIColor *celltextcolor; 
@property(nonatomic, retain) UIColor *VMtextcolor; 

@property(nonatomic, retain) NSString *VMbackImg;
@property(nonatomic, retain) NSString *MorebackImg;
@property(nonatomic, retain) NSString *wallcellbottom;
@property(nonatomic, retain) NSString *wallcellbottomdefault;


@property(nonatomic, retain)NSMutableArray *categoryEntryArray;
@property(nonatomic, retain)NSString *distance;
@property(nonatomic, readwrite) BOOL ISCATEGORYHITSREQ;
@property(nonatomic, readwrite)int myGroup;
@property(nonatomic, readwrite)int allGroup;
@property(nonatomic, readwrite)int PendingInvitation;

@property(nonatomic, readwrite) BOOL userDetailCached;
@property(nonatomic, readwrite) BOOL themeChanged;
@property(nonatomic, readwrite) BOOL isEditMode;
@property(nonatomic, readwrite) BOOL isLoginRequired;
@property(nonatomic, retain) NSString *defaultView;
@property(nonatomic, retain) NSString *defaultRegistarion;
@property(nonatomic, retain) NSString *selectedTab;

@property(assign)int dataID;
@property(nonatomic, readwrite)int totalMembers;
@property(nonatomic, readwrite)int totalFriends;
@property(nonatomic, readwrite)int totalSearched;
@property(nonatomic, readwrite)int totalBlogs;
@property(nonatomic, readwrite)int jomTotalCount;
@property(nonatomic, readwrite)int totalInMsg;
@property(nonatomic, readwrite)int totalOutMsg;
@property(assign) int totalRecords;
@property(assign) int totalUpdates;

// jom social confing

@property(nonatomic, readwrite) int friendListLimit;
@property(nonatomic, readwrite) int memberListLimit;
@property(nonatomic, readwrite) int searchListLimit;
@property(nonatomic, readwrite) int activitiesListLimit;

@property(nonatomic, readwrite) NSInteger loggedUser;
@property(nonatomic, readwrite) NSInteger locationUpdated;
@property(nonatomic, readwrite) NSInteger userId;

@property(nonatomic, retain) UIColor *tintColor;
@property(nonatomic, retain) UIColor *textcolor; 
@property(nonatomic, retain) UIColor *sepratorcolor;
@property(nonatomic, retain) UIColor *segmentcolor;
@property(nonatomic, retain) UIColor *inputtxtColor;
@property(nonatomic, retain) UIColor *color;
@property(nonatomic, retain) UIColor *textcolorhead;
@property(nonatomic, retain) UIColor *textcolortime;
@property(nonatomic, retain) UIColor *txtmsgcolor;
@property(nonatomic, retain) UIColor *txtviewColor;
@property(nonatomic, retain) UIColor *timecolor;
@property(nonatomic, retain) UIColor *cellbackgroundcolor;
@property(nonatomic, retain) NSString *mainServerURL;
@property(nonatomic, retain) NSString *bgImage;
@property(nonatomic, retain) NSString *selectedbutton;
@property(nonatomic, retain) NSString *radioselected;
@property(nonatomic, retain) NSString *radiononselected;
@property(nonatomic, retain) NSString *commentbar;
@property(nonatomic, retain) NSString *commentbackground;
@property(nonatomic, retain) NSString *likeimg;
@property(nonatomic, retain) NSString *unlikeimg;
@property(nonatomic, retain) NSString *likebackground;
@property(nonatomic, retain) NSString *transimg;
@property(nonatomic, retain) NSString *addcommentbtn;
@property(nonatomic, retain) NSString *disclosureimg;
@property(nonatomic, retain) NSString *outboxmsgimg;
@property(nonatomic, retain) NSString *mailreceiveimg;
@property(nonatomic, retain) NSString *mailsendimg;
@property(nonatomic, retain) NSString *mailwriteimg;
@property(nonatomic, retain) NSString *inboxmsgimg;
@property(nonatomic, retain) NSString *pictureimg;
@property(nonatomic, retain) NSString *videoimg;
@property(nonatomic, retain) NSString *folderimg;
@property(nonatomic, retain) NSString *sepratorimg;
@property(nonatomic, retain) NSString *fontname;
@property(nonatomic, retain) NSString *recipient;
@property(nonatomic, retain) NSString *sessionId;
@property(nonatomic, retain) NSString *textViewImg;
@property(nonatomic, retain) NSString *msgSubjtextImg;
@property(nonatomic, retain) NSString *msgdisclosureimg;
@property(nonatomic, retain) NSString *newtheme;
@property(nonatomic, retain) NSString *oldtheme;
@property(nonatomic, retain) NSString *pinImg;

// vm theme

@property(nonatomic, retain) NSString *backbtnImage;
@property(nonatomic, retain) NSString *barbtnImage;
@property(nonatomic, retain) NSString *addbtnImage;
@property(nonatomic, retain) NSString *tableHeaderImg;
@property(nonatomic, retain) NSString *addbgImage;
@property(nonatomic, retain) NSString *priceboxImage;
@property(nonatomic, retain) NSString *imgbottomLine;
@property(nonatomic, retain) NSString *couponcodeImage;
@property(nonatomic, retain) NSString *searchImg;
@property(nonatomic, retain) NSString *vmarrow;
@property(nonatomic, retain) NSString *qtyAddImg;
@property(nonatomic, retain) NSString *minusImg;
@property(nonatomic, retain) UIColor *vmtextcolorheader;
@property(nonatomic, retain) NSString *vmRadioSelect;
@property(nonatomic, retain) NSString *vmRadioUnSelect;
@property(nonatomic, retain) NSString *selButton;
@property(nonatomic, retain) NSString *whiteStarImg;
@property(nonatomic, retain) NSString *redStarImg;
@property(nonatomic, retain) NSString *relatedProdImage;
@property(nonatomic, retain) NSString *vmRecipient;

@property(nonatomic, retain) UIFont *header1;
@property(nonatomic, retain) UIFont *header2;
@property(nonatomic, retain) UIFont *header3;
@property(nonatomic, retain) UIFont *header4;
@property(nonatomic, retain) UIFont *header5;
@property(nonatomic, retain) UIFont *header6;
@property(nonatomic, retain) UIFont *header7;
@property(nonatomic, retain) UIFont *header8;
@property(nonatomic, retain) UIFont *header9;

@property(nonatomic, retain) NSMutableArray *tabList;
@property(nonatomic, retain) NSMutableArray *profilemenuList;
@property(nonatomic, retain) NSMutableArray *friendmenuList;
@property(nonatomic, retain) NSMutableArray *profileTypeList;
@property(nonatomic, retain) NSMutableArray *inboxList;
@property(nonatomic, retain) NSMutableArray *outboxList;
@property(nonatomic, retain) NSMutableArray *albumList;
@property(nonatomic, retain) NSMutableArray *friendList;
@property(nonatomic, retain) NSMutableArray *memberList;
@property(nonatomic, retain) NSMutableArray *notificationList;
@property(nonatomic, retain) NSMutableArray *unreadMsgList;
@property(nonatomic, retain) NSMutableArray *updatesList;
@property(nonatomic, retain) NSMutableArray *searchList;
@property(nonatomic, retain) NSMutableArray *directoryList;
@property(nonatomic, retain) NSMutableArray *collectionList;
@property(nonatomic, retain) NSMutableArray *grouplist;
@property(nonatomic, retain) NSMutableArray *storelist;
@property(nonatomic, retain) NSMutableArray *videolist;
@property(nonatomic, retain) NSMutableArray *chatList;
@property(nonatomic, retain) NSMutableArray *chatingList;
@property(nonatomic, retain) NSMutableArray *eventList;
@property(nonatomic, retain) NSArray *profileMenuImages;
@property(nonatomic, retain) NSArray *friendMenuImages;
@property(nonatomic, retain) NSMutableArray *settingFieldList;


// blog
@property(assign) int totalMyBlogs;
@property(assign) int totalMyComments;
@property(assign) int totalMyHits;
@property(assign) int totalTgaBlogCount;
@property(assign) int totalBlogItems;
@property(nonatomic, retain) NSString *emailAdd;
@property(nonatomic, retain) NSString *website;
@property(nonatomic, retain) NSMutableArray *blogCategoryList;
@property(nonatomic, retain) NSMutableArray *bloglist;
@property(nonatomic, retain) NSMutableArray *MyBlogList;
@property(nonatomic, retain) NSMutableArray *MyBlogCommentList;
@property(nonatomic, retain) NSMutableArray *tagList;
@property(nonatomic, retain) NSMutableArray *myTagList;
@property(nonatomic, retain) NSMutableArray *tagBloglist;
@property(nonatomic, retain) NSMutableArray *categoryBloglist;

//kunena
@property (assign) BOOL isReload;
@property(nonatomic, readwrite)int totalfavcount;
@property(nonatomic, readwrite)int totalmytopiccount;
@property(nonatomic, readwrite)int totalrecentcount;
@property(nonatomic, readwrite)int totalsubscribecount;
@property (nonatomic,retain) NSMutableArray *categoryList;
@property (nonatomic,retain) NSMutableArray *recentTopics;
@property (nonatomic,assign) NSMutableArray *recentTopicList;
@property (nonatomic,retain) NSMutableArray *favoriteTopics;
@property (nonatomic,retain) NSMutableArray *subscribedTopics;
@property (nonatomic,retain) NSMutableArray *myTopics;
@property (nonatomic,retain) NSMutableArray* tabBaritemsArray;

@property (nonatomic,retain) User *user;
@property (nonatomic,retain) User *galleryUser;
@property (nonatomic,retain) NSString *topicMsg;
@property (nonatomic,readwrite) BOOL isDataFetched;

// jom soical
@property(nonatomic, retain) NSString *errorMessage;
@property(nonatomic, readwrite) BOOL allowCreateEvent;
@property(nonatomic, readwrite)int eventLikeCnt;
@property(nonatomic, readwrite)int eventDisLikeCnt;
@property(nonatomic, readwrite)int jomMyEventCount;
@property(nonatomic, readwrite)int jomPendingEventCount;
@property(nonatomic, readwrite)int jomPastEventCount;
@property(nonatomic, retain) NSMutableArray *jomEventList;
@property(nonatomic, retain) NSMutableArray *jomMyEventList;
@property(nonatomic, retain) NSMutableArray *jomPastEvents;
@property(nonatomic, retain) NSMutableArray *jomCategoryList;
@property(nonatomic, retain) NSMutableArray *jomPendingList;
@property(nonatomic, retain) NSMutableArray *jomAdminList;
@property(nonatomic, retain) NSMutableArray *jomGuestList;
@property(nonatomic, retain) NSMutableArray *jomSpecialEventList;
@property(nonatomic, retain) NSMutableArray *jomSpecialGalleryAlbumList;
@property(nonatomic, retain) NSMutableArray *jomSpecialGalleryList;

@property(nonatomic, assign) User *userDetail;
//@property(nonatomic, assign) Privacy *settings;

@property(nonatomic,readwrite, assign) id rootObject;
@property(nonatomic,readonly) NSString* rootName;
@property(nonatomic,readonly) NSError* parseError;

@property(nonatomic, assign) NetworkStatus currentNetworkStatus;
@property(nonatomic, assign) User *selectedUser;
@property(nonatomic, retain) GPSLocationListner *locationManager;
@property(nonatomic, retain) Reachability* wifiReach;
@property(assign)iJoomerErrorCode errorCode;
@property(assign)HTTPRequest currentRequestType;
@property(nonatomic, retain) Facebook *facebook;
@property(nonatomic, retain) NSMutableDictionary *userPermissions;
@property(nonatomic, retain)SA_OAuthTwitterEngine *twitter;

//group-config

@property(nonatomic,readwrite)BOOL isGroupEnable,isGroupCreate,isCreateAnnouncement,isCreateDiscussion,isGroupPhotos,isGroupVideos,isGroupEvent;
@property(assign)int groupcount;

@property(nonatomic,retain)NSMutableArray *mygroupList;
@property(nonatomic,retain)NSMutableArray *pendinglist;
@property(nonatomic,retain)NSMutableArray *groupCategoryList;
@property(nonatomic, readwrite)int inviteMemberCount;
@property (nonatomic, readwrite)int totalAdmin;
@property (nonatomic, readwrite)int totalMemberCount;
@property (nonatomic, readwrite)int totalBannedCount;
@property (nonatomic, readwrite)BOOL isViewDidload;


// new theme

@property(nonatomic, retain) NSString *settingBtnImg;
@property(nonatomic, retain) NSString *topImg;
@property(nonatomic, retain) NSString *bottomImg;
@property(nonatomic, retain) NSString *remeberbackImg;
@property(nonatomic, retain) NSString *checkImg;
@property(nonatomic, retain) NSString *uncheckImg;



@property(nonatomic, readwrite)int sectionId;

@property(nonatomic, readwrite) BOOL ISFEATURED;
@property(nonatomic, readwrite) BOOL ISFEATUREDREQUIRED;
@property(nonatomic, readwrite) BOOL ISREVIEWREQUIRED; 
@property(nonatomic, readwrite) BOOL ISRADIUSREQUIERED;
@property(nonatomic, readwrite) BOOL ISPROREVIEWREQUIRED; 
@property(nonatomic, readwrite) BOOL ISPRORADIUSREQUIERED;
@property(nonatomic, readwrite) BOOL ISPROFEATURED;
@property(nonatomic, readwrite) BOOL ISPROGALLERY;
@property(nonatomic, readwrite) BOOL ISPROFEATUREDREQUIRED;
@property(nonatomic, readwrite) BOOL ISICONREQUIRED;
@property(nonatomic, readwrite) BOOL ISIMAGEREQUIRED;
@property(nonatomic, readwrite) BOOL ISGALLERY;


@property(nonatomic, retain) NSString *categoryView;
@property(nonatomic, retain) NSString *featuredView;
@property(nonatomic, retain) NSString *mapKey;
@property(nonatomic, retain) NSString *entryView;
@property(nonatomic, retain) NSString *PROcategoryView;
@property(nonatomic, retain) NSString *PROentryView;
@property(nonatomic, retain) NSString *PROfeaturedView;
@property(nonatomic, retain) NSString *voteURL;

@property(nonatomic, retain)UIImage *voteImg;

@property(nonatomic, retain) NSMutableArray *Scategories;
@property(nonatomic, retain) NSMutableArray *ScatEntries;
@property(nonatomic, retain) NSMutableArray *SPROcategories;
@property(nonatomic, retain) NSMutableArray *SPROcatEntries;
@property(nonatomic, retain) NSMutableArray *configArray;
@property(nonatomic, retain) NSMutableArray *searchArray;
@property(nonatomic, retain) NSMutableArray *businessDetail;
@property(nonatomic, retain) NSMutableArray *PROsearchArray;
@property(nonatomic, retain) NSMutableArray *SfeaturedArray;

///////////////////////////////////////// virtumart //////////////////////////////////////////

@property(nonatomic,assign)User *userLoggedIn;
@property(nonatomic,retain)Data *data;

@property(nonatomic, readwrite)BOOL showFeaturedPrice;
@property(nonatomic, readwrite)BOOL showFeaturedYouSave;
@property(nonatomic, readwrite)BOOL billingInfo;
@property(nonatomic, readwrite)BOOL showPrice;
@property(nonatomic, readwrite)BOOL showYouSave;
@property(nonatomic, readwrite)BOOL showWishList;
@property(nonatomic, readwrite)BOOL showDescription;
@property(nonatomic, readwrite)BOOL showAddCart;
@property(nonatomic, readwrite)BOOL invaliData;
@property(nonatomic, readwrite)BOOL feature;
@property(nonatomic, readwrite)BOOL cartReload;
@property(nonatomic, readwrite)BOOL fromVm;
@property(nonatomic, readwrite)int totalProducts;
@property(nonatomic, readwrite)int totalSearch;
@property(nonatomic, readwrite)int totalCat;

@property(nonatomic, readwrite)float totalTax;
@property(nonatomic, readwrite)float totalPrice;
@property(nonatomic, readwrite)float floatPrice;
@property(nonatomic, readwrite)float subTotalInt;
@property(nonatomic, readwrite)float taxInt;
@property(nonatomic, readwrite)float shippingInt;


@property(nonatomic,retain)NSString *subTax;
@property(nonatomic,retain)NSString *productView;
@property(nonatomic,retain)NSString *featuredProductView;
@property(nonatomic,retain)NSString *couponDiscount;
@property(nonatomic,retain)NSString *discountedPrice;
@property(nonatomic,retain)NSString *billingAddress;
@property(nonatomic,retain)NSString *infoID;
@property(nonatomic,retain)NSString *shipInfoID;
@property(nonatomic,retain)NSString *shipMethodID;
@property(nonatomic,retain)NSString *shippingFee;
@property(nonatomic,retain)NSString *fee;
@property(nonatomic,retain)NSString *paymentMode;
@property(nonatomic,retain)NSString *subTotal;
@property(nonatomic,retain)NSString *response;
@property(nonatomic,retain)NSString *countryId;

@property(nonatomic,retain)NSMutableArray *shippingList;
@property(nonatomic,retain)NSMutableArray *shippingMethodList;
@property(nonatomic,retain)NSMutableArray *paymentList;
@property(nonatomic,retain)NSMutableArray *orderDetailList;
@property(nonatomic,retain)NSMutableArray *featuredProductList;
@property(nonatomic,retain)NSMutableArray *fullWishListArray;
@property(nonatomic, retain)NSMutableArray *wishArray;
@property(nonatomic,retain)NSMutableArray *wishListProductList;
@property(nonatomic,retain)NSMutableArray *latestProductList;
@property(nonatomic,retain)NSMutableArray *cartProductList;
@property(nonatomic,retain)NSMutableArray *wishDetailList;
@property(nonatomic,retain)NSMutableArray *sortList;
@property(nonatomic,retain)NSMutableArray *attribList;
@property(nonatomic,retain)NSMutableArray *cartArray;
@property(nonatomic, retain)NSMutableArray *wishDetailArray;
@property(nonatomic, retain)NSMutableArray *relatedProductList;
@property(nonatomic, retain)NSMutableArray *wishListingArray;
@property(nonatomic, retain)NSMutableArray *searchCategoryArray;
@property(nonatomic,retain)NSMutableArray *myAccountArray;
@property(nonatomic,retain)NSMutableArray *vmcategoryList;
@property(nonatomic,retain)NSString *selectedFriend;
@property(nonatomic,retain)NSArray *recUserList;
@property(nonatomic,retain)NSMutableArray *recList;

@property(nonatomic,readwrite) int replyID;
@property(nonatomic,readwrite) int favId;

@property(nonatomic, readwrite)int flag_cov_photo;//cover photo change flag.
@property(nonatomic, readwrite)int flag_cov_photochanged;//if cover photo change sucess then this will be 1.

///////Theme, application Menu /////////////

@property(nonatomic,retain)NSMutableArray *arr_Themeglobal_List;
@property(nonatomic,retain)NSMutableArray *arr_MenuTabbarList;
@property(nonatomic,retain)NSMutableArray *arr_MenuSidebarList;
@property(nonatomic,retain)NSMutableArray *arr_MenuHomeglobalList;
@property(nonatomic,retain)NSDictionary *dictGlobalConfig;
@property(nonatomic,retain)NSDictionary *dictextentionconfig;

@property (nonatomic,retain) NSString *navBarImg;// $
@property BOOL showTabs;// $
@property (nonatomic,retain) NSString *wallRemoveImg; // $
@property (nonatomic,retain) NSString *cellbackImg;// $
@property(nonatomic, retain) NSString *logoImg;
////////////////////////////////////////////

@property int selectedMSGindex;// $


////////////////////////////////////// jom social //////////////////////////

@property(nonatomic, retain) NSString *subMenu;
@property(nonatomic, retain) NSString *subMenuSep;

@property(nonatomic,readwrite) int totalAllAlbums;
@property(nonatomic,readwrite) int totalMyAlbums;
@property(nonatomic,readwrite) int totalAllVideos;
@property(nonatomic,readwrite) int totalMyVideos;
@property(nonatomic,readwrite) int totalWall;
@property(nonatomic, retain) NSString *downloadImg;
@property(nonatomic, retain) NSString *delImg;
@property(nonatomic, retain) NSString *reportImg;
@property(nonatomic, retain) NSMutableArray *groupFieldsArray;
@property(nonatomic, retain) NSMutableArray *eventFieldsArray;
@property(nonatomic, assign) Article *selectedCollection;
@property(nonatomic, retain) NSString *shareImg;
@property(nonatomic, retain) NSString *incomingMsg;
@property(nonatomic, retain) NSString *outgoingMsg;

@property(nonatomic, assign) ChatHeartbeat *chat;
///////////////////////////////////////////////////////////////////////////

+(ApplicationData*)sharedInstance;
+(NSString *)encodeStringForURL:(NSString *)originalURL;
+(UIImage *)generateResizingImage:(UIImage *)originalImage;
+(UIImage *)generateStarImages:(float)rating;

//-(void)loadNewSplace:(UIView *)view;
//-(void)hideSplace;
- (void) changeTheme;
- (void) reachabilityChanged:(NSNotification *)note;
- (void) logout:(UIViewController *) parentcontroller;
-(void)animateImage:(UIView *)view;
-(void)animateImage1:(UIView *)view;
-(void)animateImagePlay:(UIView *)view;
-(void)stopImage;


//+(void)iJJosLogin:(LoginViewController *)sender username:(NSString *)username password:(NSString *)password;
- (void)updateTimer;
-(void)keepsession;
-(void)stoptimer;
//- (void)openLoginView;
-(void)pauseLayer:(CALayer*)layer;

+ (NSData *)AES128EncryptWithKey:(NSString *)key Str:(NSData *)plain;
+ (NSData *)AES128DecryptWithKey:(NSString *)key Str:(NSData *)plain;

- (void) setNotificationcount;

///Tabbar menu set.
-(void)TabReset;

@end
