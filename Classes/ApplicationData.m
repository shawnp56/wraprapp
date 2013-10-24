//
//  ApplicationData.m
//  iJoomer
//
//  Created by Tailored Solutions on 03/07/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "ApplicationData.h"
#import "GPSLocationListner.h"
#import "User.h"
#import "Article.h"
#import "Privacy.h"
#import "iJoomerAppDelegate.h"
#import "SA_OAuthTwitterController.h"
#import "SA_OAuthTwitterEngine.h"
//#import "Data.h"
#import "Tab.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonCryptor.h>
#import "SQLiteManager.h"
#import "iJoomerAppDelegate.h"

static ApplicationData *applicationData = nil;
static int kBytesPerPixel = 5;

@implementation ApplicationData

//image upload int
@synthesize flag_ImgUpload;
@synthesize flag_Imgtotalcount;
@synthesize flag_imageUP;

@synthesize Voicedata;
//stor state or city name.
@synthesize MapCityname;
@synthesize MapStatename;
@synthesize Flag_City_State;
@synthesize Flag_MapDone;
///default_landing_screen handler.
@synthesize DefaultLandingscreenFlag;

// Database handler
@synthesize sqlManager;

//@synthesize newSplaceImage,newSplaceUrl,loadSplace;
//Theme
@synthesize isLoggedIn,groupArray,isDeleted,albumId;
@synthesize homebutton;
@synthesize createaccountbutton;
@synthesize celltextcolor;
@synthesize VMbackImg;
@synthesize MorebackImg;
@synthesize VMtextcolor;
@synthesize dataID;
@synthesize loggedUser;
@synthesize userId;
@synthesize replyID;
@synthesize locationUpdated;
@synthesize sessionId;
@synthesize tintColor;
@synthesize bgImage;
@synthesize themeChanged;
@synthesize userDetail;
@synthesize userDetailCached,logoImg;
//@synthesize settings;
@synthesize recipient;
@synthesize totalInMsg;
@synthesize totalOutMsg;
@synthesize galleryUser;
@synthesize isLoginRequired;
@synthesize defaultView;
@synthesize recList;
@synthesize defaultRegistarion;

// jom social config

@synthesize friendListLimit, memberListLimit, searchListLimit, activitiesListLimit;

@synthesize tabList;
@synthesize profilemenuList;
@synthesize friendmenuList;
@synthesize profileTypeList;
@synthesize inboxList;
@synthesize outboxList;
@synthesize albumList;
@synthesize friendList;
@synthesize memberList;
@synthesize searchList;
@synthesize notificationList;
@synthesize unreadMsgList;
@synthesize updatesList;
@synthesize grouplist;
@synthesize storelist;
@synthesize videolist;
@synthesize chatList;
@synthesize chatingList;
@synthesize eventList;

@synthesize locationManager;
@synthesize wifiReach;
@synthesize currentNetworkStatus;
@synthesize errorCode;

@synthesize selectedbutton;
@synthesize radioselected;
@synthesize radiononselected;
@synthesize commentbar;
@synthesize commentbackground;
@synthesize likeimg;
@synthesize unlikeimg;
@synthesize likebackground;
@synthesize isEditMode;
@synthesize selectedUser;
@synthesize mainServerURL;
@synthesize transimg;
@synthesize disclosureimg;
@synthesize outboxmsgimg;
@synthesize mailreceiveimg;
@synthesize mailsendimg; 
@synthesize mailwriteimg;
@synthesize profileMenuImages;
@synthesize friendMenuImages;
//@synthesize messageimg;
//@synthesize galleryimg;
//@synthesize wallimg;
@synthesize inboxmsgimg;
@synthesize pictureimg;
@synthesize videoimg;
@synthesize folderimg;
@synthesize textcolor;
@synthesize sepratorcolor;
@synthesize segmentcolor;
@synthesize sepratorimg;
@synthesize fontname;
@synthesize header1;
@synthesize header2;
@synthesize header3;
@synthesize header4;
@synthesize header5;
@synthesize header6;
@synthesize header7;
@synthesize header8;
@synthesize header9;
@synthesize color;
@synthesize inputtxtColor;
@synthesize addcommentbtn;
@synthesize textcolorhead;
@synthesize textcolortime;
@synthesize textViewImg;
@synthesize txtmsgcolor;
@synthesize msgSubjtextImg;
@synthesize msgdisclosureimg;
@synthesize txtviewColor;
@synthesize timecolor;
@synthesize newtheme;
@synthesize oldtheme;
@synthesize pinImg;
@synthesize totalMembers;
@synthesize totalFriends;
@synthesize totalSearched;
@synthesize totalBlogs;
@synthesize currentRequestType;
@synthesize directoryList;
@synthesize collectionList;
@synthesize cellbackgroundcolor;
@synthesize totalRecords;
@synthesize totalUpdates;

@synthesize facebook;
@synthesize userPermissions;
@synthesize twitter;
@synthesize settingFieldList;
@synthesize flag_cov_photo;//cover photo change flag.
@synthesize flag_cov_photochanged;//if cover photo change sucess then this will be 1.

//group-config
@synthesize isGroupEnable,isGroupCreate,isCreateAnnouncement,isCreateDiscussion,isGroupPhotos,isGroupVideos,isGroupEvent;
@synthesize groupcount;
@synthesize mygroupList;
@synthesize pendinglist;
@synthesize groupCategoryList;
@synthesize inviteMemberCount;
@synthesize totalAdmin;
@synthesize totalMemberCount;
@synthesize totalBannedCount;
@synthesize isViewDidload;

// bolg

@synthesize website;
@synthesize emailAdd;
@synthesize blogCategoryList; 
@synthesize bloglist;
@synthesize totalMyComments;
@synthesize totalMyBlogs;
@synthesize MyBlogList;
@synthesize MyBlogCommentList;
@synthesize myTagList;
@synthesize totalMyHits;
@synthesize tagBloglist;
@synthesize tagList;
@synthesize totalTgaBlogCount;
@synthesize categoryBloglist;
@synthesize totalBlogItems;


//kunena
@synthesize isReload;
@synthesize categoryList;
@synthesize recentTopics;
@synthesize recentTopicList;
@synthesize favoriteTopics;
@synthesize subscribedTopics;
@synthesize myTopics;
@synthesize tabBaritemsArray;

@synthesize user;

@synthesize topicMsg;
@synthesize isDataFetched;


// jom social 
@synthesize totalfavcount;
@synthesize totalmytopiccount;
@synthesize totalrecentcount;
@synthesize totalsubscribecount;
@synthesize jomPendingEventCount;
@synthesize jomPastEventCount;
@synthesize jomMyEventCount;
@synthesize allowCreateEvent;
@synthesize eventLikeCnt;
@synthesize eventDisLikeCnt;
@synthesize jomEventList;
@synthesize jomMyEventList;
@synthesize jomSpecialEventList;
@synthesize jomPastEvents;
@synthesize jomAdminList;
@synthesize jomGuestList;
@synthesize jomPendingList;
@synthesize jomCategoryList;
@synthesize jomTotalCount;
@synthesize errorMessage;
@synthesize jomSpecialGalleryAlbumList;
@synthesize jomSpecialGalleryList;
@synthesize selectedFriend;
@synthesize recUserList;


// new theme

@synthesize settingBtnImg;
@synthesize topImg;
@synthesize bottomImg;
@synthesize remeberbackImg;
@synthesize checkImg;
@synthesize uncheckImg;
@synthesize wallcellbottom;
@synthesize wallcellbottomdefault;



@synthesize sectionId;
@synthesize Scategories;
@synthesize ScatEntries;
@synthesize configArray;
@synthesize categoryView;
@synthesize featuredView;
@synthesize entryView;
@synthesize mapKey;
@synthesize ISFEATURED;
@synthesize voteURL;
@synthesize voteImg;
@synthesize searchArray;
@synthesize ISREVIEWREQUIRED;
@synthesize ISRADIUSREQUIERED;
@synthesize ISGALLERY;
@synthesize ISFEATUREDREQUIRED;
@synthesize SPROcategories;
@synthesize SPROcatEntries;
@synthesize businessDetail;
@synthesize ISPROREVIEWREQUIRED;
@synthesize ISPRORADIUSREQUIERED;
@synthesize ISPROFEATURED;
@synthesize ISPROGALLERY;
@synthesize ISPROFEATUREDREQUIRED;
@synthesize PROcategoryView;
@synthesize PROentryView;
@synthesize PROfeaturedView;
@synthesize PROsearchArray;
@synthesize ISICONREQUIRED;
@synthesize ISIMAGEREQUIRED;
@synthesize SfeaturedArray;
@synthesize cartReload,feature,favId,contactsArray;

@synthesize rootObject = _rootObject, rootName = _rootName, parseError = _parseError;

@synthesize PendingInvitation,myGroup,allGroup;

////////////////////////////////// virtuemart/////////////////////////////////////////
@synthesize userLoggedIn;
@synthesize showFeaturedYouSave,showFeaturedPrice;
@synthesize totalProducts;
@synthesize totalSearch;
@synthesize productView;
@synthesize featuredProductView;

@synthesize sortList,attribList;
@synthesize featuredProductList; 
@synthesize wishListProductList;
@synthesize latestProductList;
@synthesize wishDetailList;
@synthesize cartProductList;
@synthesize discountedPrice,couponDiscount,billingAddress,shippingList;
@synthesize billingInfo,shippingMethodList,infoID,orderDetailList;
@synthesize showAddCart,showPrice,showYouSave,showDescription;
@synthesize relatedProductList,invaliData,showWishList,paymentMode;
@synthesize paymentList,shipMethodID,shipInfoID,shippingFee,fee;
@synthesize totalTax,totalPrice,data,cartArray,subTotal,subTax;
@synthesize fullWishListArray,wishArray,wishDetailArray,vmcategoryList;
@synthesize floatPrice,subTotalInt,taxInt,shippingInt,wishListingArray,countryId;
@synthesize searchCategoryArray,totalCat,response,myAccountArray,fromVm;
@synthesize backbtnImage,barbtnImage,addbtnImage,tableHeaderImg,addbgImage;
@synthesize priceboxImage,imgbottomLine,couponcodeImage,searchImg,vmarrow,qtyAddImg,vmtextcolorheader;
@synthesize minusImg,vmRadioSelect,vmRadioUnSelect,selButton;
@synthesize whiteStarImg,redStarImg,relatedProdImage;
@synthesize vmRecipient;

@synthesize distance;
@synthesize ISCATEGORYHITSREQ;
@synthesize categoryEntryArray;



@synthesize selectedTab;


//Keep Session live
@synthesize counter;
@synthesize joomlasessiontime;
@synthesize ijoomersessiontime;
@synthesize sessiontime;
@synthesize totalSec;
@synthesize frndCount;
@synthesize groupCount;
@synthesize msgCount;
@synthesize albumArray;
@synthesize allAlbumArray;
@synthesize videoCategoryArray;
@synthesize myVideos;

///////Theme, application Menu /////////////
@synthesize arr_Themeglobal_List;
@synthesize arr_MenuSidebarList;
@synthesize arr_MenuTabbarList;
@synthesize arr_MenuHomeglobalList;
@synthesize dictGlobalConfig;
@synthesize dictextentionconfig;
@synthesize navBarImg;
@synthesize showTabs;
@synthesize cellbackImg;
@synthesize wallRemoveImg;

////////////////////////////////////////////
@synthesize selectedMSGindex;
///////////////////////////////////////////


////////////////////////////////////// jom social //////////////////////////

@synthesize subMenu;
@synthesize subMenuSep;
@synthesize AllVideos,downloadImg,reportImg,delImg,totalAllAlbums,totalMyAlbums;
@synthesize totalAllVideos,totalMyVideos,groupFieldsArray,eventFieldsArray;
@synthesize selectedCollection;
@synthesize shareImg,incomingMsg,outgoingMsg;
@synthesize chat;

@synthesize eventArray;
@synthesize photoArray;
@synthesize videoArray;
@synthesize profileArray,totalWall;

///////////////////////////////////////////////////////////////////////////


- (id)init {
	if(self == [super init])
    {
        //image upload int
        flag_ImgUpload = 0;
        flag_Imgtotalcount = 0;
        flag_imageUP= NO;
        
        Voicedata = nil;
        
        //stor state or city name.
        MapCityname = @"";
        MapStatename = @"";
        Flag_City_State = 0;
        Flag_MapDone = 0;
        
        // Database handler
        sqlManager = [[SQLiteManager alloc] initDatabase:DB_NAME];
        
		themeDictionary = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Data.plist"]];
		valuePicker = [themeDictionary objectForKey:@"themes"];
		[valuePicker retain];
        groupArray = [[NSMutableArray alloc] init];
        eventArray = [[NSMutableArray alloc] init];
        photoArray = [[NSMutableArray alloc] init];
        videoArray = [[NSMutableArray alloc] init];
        profileArray = [[NSMutableArray alloc] init];
        selectedFriend = @"";
        sessionId = @"";
        _stack = [[NSMutableArray alloc] init];
        _nameStack = [[NSMutableArray alloc] init];
        _rootObject = nil;
        _rootName = nil;
        _chars = nil;
        _parseError = nil;

        userDetail = [[User alloc] init];
        galleryUser = [[User alloc] init];
		errorCode = jSuccess;
        recUserList = [[NSArray alloc]init];
        contactsArray = [[NSMutableArray alloc]init];
        // jom social config
        timeString = @"";
        recList = [[NSMutableArray alloc]init];
//        friendListLimit = SEARCH_INCREMENT;
//        memberListLimit = SEARCH_INCREMENT;
//        searchListLimit = SEARCH_INCREMENT;
        activitiesListLimit = LIST_LIMIT;
        
        totalSec = 0;
		locationUpdated=0;
        favId = 0;
		totalRecords = 0;
        totalUpdates = 0;
        totalWall = 0;
		userId = 0;
		totalMembers = 0;
		totalFriends = 0;
		totalSearched = 0;
		totalBlogs = 0;
        totalOutMsg = 0;
        totalInMsg = 0;
        
        flag_cov_photo = 0;//cover photo change flag.
        flag_cov_photochanged = 0;//if cover photo change sucess then this will be 1.
        
		userDetailCached = NO;
		isEditMode = NO;
		allowCreateEvent = NO;
        isLoginRequired = NO;

        isLoggedIn = NO;
		recipient = @"";
		errorMessage = @"";
        defaultView = @"";
        defaultRegistarion = @"";
        tabList = [[NSMutableArray alloc] init];
        profilemenuList = [[NSMutableArray  alloc] init];
        friendmenuList = [[NSMutableArray alloc]init];
		profileTypeList = [[NSMutableArray alloc] init];
		inboxList =  [[NSMutableArray alloc] init];
		outboxList = [[NSMutableArray alloc] init];
		albumList =  [[NSMutableArray alloc] init];
		friendList = [[NSMutableArray alloc] init];
		memberList = [[NSMutableArray alloc] init];
		searchList = [[NSMutableArray alloc]init];
        albumArray = [[NSMutableArray alloc]init];
        allAlbumArray = [[NSMutableArray alloc]init];
        videoCategoryArray = [[NSMutableArray alloc]init];
        AllVideos = [[NSMutableArray alloc] init];
        myVideos = [[NSMutableArray alloc]init];
		notificationList = [[NSMutableArray alloc] init];
		unreadMsgList = [[NSMutableArray alloc] init];
		updatesList =  [[NSMutableArray alloc] init];
		directoryList =[[NSMutableArray alloc]init];

		collectionList =[[NSMutableArray alloc]init];
		grouplist = [[NSMutableArray alloc]init];
		storelist = [[NSMutableArray alloc]init];
		videolist = [[NSMutableArray alloc] init];
		chatList = [[NSMutableArray alloc] init];
		chatingList = [[NSMutableArray alloc] init];
		eventList = [[NSMutableArray alloc] init];
        settingFieldList = [[NSMutableArray alloc] init];
		
        
        //Theam.
        wallcellbottom = @"";
        wallcellbottomdefault = @"";
        
        //blog
        
        website = @"";
        emailAdd = @"";
        bloglist  = [[NSMutableArray alloc]init];
        blogCategoryList = [[NSMutableArray alloc]init];
        tagList = [[NSMutableArray alloc]init];
        myTagList = [[NSMutableArray alloc]init];
        MyBlogList = [[NSMutableArray alloc] init];
        MyBlogCommentList = [[NSMutableArray alloc] init];
        categoryBloglist = [[NSMutableArray alloc] init];
        tagBloglist = [[NSMutableArray alloc] init];
        
        //group
        mygroupList = [[NSMutableArray alloc] init];
        pendinglist = [[NSMutableArray alloc]init];
        groupCategoryList = [[NSMutableArray alloc]init];
        
        // Kunena
		categoryList = [[NSMutableArray alloc] init];
		recentTopics = [[NSMutableArray alloc] init];
        recentTopicList = [[NSMutableArray alloc] init];
		favoriteTopics = [[NSMutableArray alloc] init];
		subscribedTopics = [[NSMutableArray alloc] init];
		myTopics = [[NSMutableArray alloc]init];
        tabBaritemsArray = [[NSMutableArray alloc] init];
		user = [[User alloc] init];
		isDataFetched = NO;

		//jom social
		
		jomCategoryList = [[NSMutableArray alloc] init];
		jomMyEventList = [[NSMutableArray alloc] init];
		jomPastEvents = [[NSMutableArray alloc] init];
		jomPendingList = [[NSMutableArray alloc] init];
		jomEventList = [[NSMutableArray alloc] init];
		jomAdminList = [[NSMutableArray alloc] init];
		jomGuestList = [[NSMutableArray alloc] init];
		jomSpecialEventList = [[NSMutableArray alloc] init];
		jomSpecialGalleryAlbumList = [[NSMutableArray alloc] init];
		jomSpecialGalleryList = [[NSMutableArray alloc] init];
	
        self.locationManager = [[GPSLocationListner alloc] init];
        //[self.locationManager changeLocationUpdationStatus:YES];
		
        

        
        PROcategoryView = @"";
		PROentryView = @"";
		PROfeaturedView = @"";
		voteURL = @"";
		voteImg = nil;
        Scategories = [[NSMutableArray alloc] init];
		ScatEntries = [[NSMutableArray alloc] init];
		SPROcategories = [[NSMutableArray alloc] init];
		SPROcatEntries = [[NSMutableArray alloc] init];
        configArray = [[NSMutableArray alloc]init];
        
		entryView = @"";
		featuredView = @"";
		mapKey =@"";
		searchArray = [[NSMutableArray alloc]init];
		businessDetail = [[NSMutableArray alloc]init];
		PROsearchArray = [[NSMutableArray alloc]init];
        SfeaturedArray = [[NSMutableArray alloc]init];
        
        
        ISCATEGORYHITSREQ = NO;
        categoryEntryArray = [[NSMutableArray alloc]init];

        distance = @"";

        selectedTab = @"";
        /////// virtuemart/////////
        
        showDescription = 1;
        fromVm = NO;
        userLoggedIn = [[User alloc] init];
        productView = @"";
        categoryView = @"";
        featuredProductView = @"";
        countryId = @"";
        response = @"";
        vmRecipient = @"";
//        showPrice = YES;
//        showFeaturedPrice = YES;
        fullWishListArray=[[NSMutableArray alloc]init];
        featuredProductList = [[NSMutableArray alloc] init];
		wishListProductList =  [[NSMutableArray alloc] init];
		latestProductList = [[NSMutableArray alloc] init];
		cartProductList= [[NSMutableArray alloc] init];
        wishDetailList=[[NSMutableArray alloc]init];
        sortList=[[NSMutableArray alloc]init];
        wishDetailArray = [[NSMutableArray alloc] init];
        wishArray = [[NSMutableArray alloc] init];
        searchCategoryArray=[[NSMutableArray alloc]init];
        myAccountArray=[[NSMutableArray alloc]init];
        wishListingArray = [[NSMutableArray alloc]init];
        shippingList = [[NSMutableArray alloc]init];
        shippingMethodList = [[NSMutableArray alloc]init];
        paymentList = [[NSMutableArray alloc]init];
        vmcategoryList = [[NSMutableArray alloc]init];
        
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
		wifiReach = [[Reachability reachabilityWithHostName:@"www.google.com"] retain];
		[wifiReach startNotifer];
		currentNetworkStatus = ReachableViaWiFi;
		[self reachabilityChanged:nil];
		      
        // Create twitter object
		twitter = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: nil];
		twitter.consumerKey = kOAuthConsumerKey;
		twitter.consumerSecret = kOAuthConsumerSecret;
        
        userPermissions = [[NSMutableDictionary alloc] initWithCapacity:1];
        
        
    /////////Theme, application Menu ////////////////////////////////////////////////////////
        
        arr_Themeglobal_List = [[NSMutableArray alloc]init];//theam array.
        arr_MenuSidebarList = [[NSMutableArray alloc]init];//sidebar menu array.
        arr_MenuTabbarList = [[NSMutableArray alloc]init];//tabbar menu array.
        arr_MenuHomeglobalList = [[NSMutableArray alloc]init];//Home screen menu array.
        dictGlobalConfig = [[NSDictionary alloc]init];//global config.
        dictextentionconfig = [[NSDictionary alloc]init];//extention config.
        
        navBarImg = @"";
        showTabs = 0;
        wallRemoveImg = @"";
        cellbackImg = @"";
    
    /////////////////////////////////////////////////////////////////////////////////////////
        selectedMSGindex = 0;
    //////////////////////////////////////////////////////////////////////////////////////////
        
        
    ////////////////////////////////////// jom social //////////////////////////
    
        subMenu = @"";
        subMenuSep = @"";
        downloadImg = @"";
        delImg = @"";
        reportImg = @"";
        shareImg = @"";
        incomingMsg = @"";
        outgoingMsg = @"";
        groupFieldsArray = [[NSMutableArray alloc]init];
        eventFieldsArray = [[NSMutableArray alloc]init];
        
    ///////////////////////////////////////////////////////////////////////////

	}
	return self;
}

//-(void)loadNewSplace:(UIView *)view {
//    UIImage *img = (UIImage *)[view viewWithTag:-123456];
//    if (img) {
//        return;
//    }
//    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hideSplace) userInfo:nil repeats:YES];
//    UIImage *statusImage = newSplaceImage;
//    newSplaceImageView = [[UIImageView alloc] 
//                          initWithImage:statusImage];
//    newSplaceImageView.tag = -123456;
//    [view addSubview:newSplaceImageView];
//}
//
//-(void)hideSplace {
//    [newSplaceImageView removeFromSuperview];
//    [timer invalidate];
//    timer = nil;
//}

-(void)AlertView
{
    NSString *alertMsg;
    switch (self.errorCode) {
		case jBadRequest:
            alertMsg = @"Wrong Data.";
			break;
            
		case jLoginRequired:
            alertMsg = @"Invalid Username or Password.";
			break;
            
		case jErroronServer:
            alertMsg = @"Server Error.";
			break;
            
		case jSuccess:
			alertMsg = @"Success.";
            break;
        case jNoContent:
            alertMsg = @"No Content Found.";
			break;
            
        case jErrorMessage:
            alertMsg = @"No Such Request Found.";
			break;
            
        case jUnsupportedFile:
            alertMsg = @"Unsupported File Type.";
			break;
            
        case jInvalidData:
            alertMsg = @"Upload Limit Exceeded.";
			break;
            
        case jUserNameError:
            alertMsg = @"Username Already Exists.";
			break;
            
        case jEmailError:
            alertMsg = @"Email Already Exists.";
			break;
            
        case jFBOption:
            alertMsg = @"Facebook User Not Found.";
			break;
            
        case jSessionExpire:
            alertMsg = @"Session Expired.";
			break;
            
        case jReportedContent:
            alertMsg = @"Permission Denied.";
			break;
            
        case JPermissionError:
            alertMsg = @"Restricted Access.";
			break;
            
        case jDuplicateData:
            alertMsg = @"Request already exists.";
			break;
            
        case jWaitingForPermission:
            alertMsg = @"Awaiting approval.";
			break;
            
        default:
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:alertMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)initialize {
}

+ (ApplicationData*)sharedInstance {
    if (applicationData == nil) {
        applicationData = [[super allocWithZone:NULL] init];
		[applicationData initialize];
        [applicationData retain];
    }
    
    return applicationData;
}

-(void)animateImage1:(UIView *)view
{
    UIImage *img = (UIImage *)[view viewWithTag:-9999];
    if (img) {
        return;
    }
    UIImage *statusImage = [UIImage imageNamed:@"record_btn.png"];
    activityImageView = [[UIImageView alloc]
                         initWithImage:statusImage];
    
    //Add more images which will be used for the animation
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"record_btn.png"],
                                         [UIImage imageNamed:@"record_btn_hover"],
                                                                                 nil];
    
    //Set the duration of the animation (play with it
    //until it looks nice for you)
    activityImageView.animationDuration = 1.5;
    
    //Position the activity image view somewhere in
    //the middle of your current view
    activityImageView.frame = CGRectMake(
                                         view.frame.size.width/2
                                         -statusImage.size.width/2,
                                         view.frame.size.height/2
                                         -statusImage.size.height/2,
                                         statusImage.size.width,
                                         statusImage.size.height);
    
    activityImageView.tag = -9999;
    [activityImageView startAnimating];
    activityImageView.hidden = NO;
    [view addSubview:activityImageView];
}

-(void)animateImagePlay:(UIView *)view
{
    UIImage *img = (UIImage *)[view viewWithTag:-9999];
    if (img) {
        return;
    }
    UIImage *statusImage = [UIImage imageNamed:@"voice_icon.png"];
    activityImageView = [[UIImageView alloc]
                         initWithImage:statusImage];
    
    //Add more images which will be used for the animation
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"voice_icon.png"],
                                         [UIImage imageNamed:@"voice_icon_hover.png"],
                                         nil];
    
    //Set the duration of the animation (play with it
    //until it looks nice for you)
    activityImageView.animationDuration = 1.5;
    
    //Position the activity image view somewhere in
    //the middle of your current view
    activityImageView.frame = CGRectMake(
                                         view.frame.size.width/2
                                         -statusImage.size.width/2,
                                         view.frame.size.height/2
                                         -statusImage.size.height/2,
                                         statusImage.size.width+5/2,
                                         statusImage.size.height+5/2);
    
    activityImageView.tag = -9999;
    [activityImageView startAnimating];
    activityImageView.hidden = NO;
    [view addSubview:activityImageView];
}




//Alertview Methods

-(void)animateImage:(UIView *)view
{
    UIImage *img = (UIImage *)[view viewWithTag:-9999];
    if (img) {
        return;
    }
    UIImage *statusImage = [UIImage imageNamed:@"0.png"];
    activityImageView = [[UIImageView alloc] 
                         initWithImage:statusImage];
    
    //Add more images which will be used for the animation
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"0.png"],
                                         [UIImage imageNamed:@"1.png"],
                                         [UIImage imageNamed:@"2.png"],
                                         [UIImage imageNamed:@"3.png"],
                                         [UIImage imageNamed:@"4.png"],
                                         nil];
    
    //Set the duration of the animation (play with it
    //until it looks nice for you)
    activityImageView.animationDuration = 1.5;
    
    //Position the activity image view somewhere in 
    //the middle of your current view
    activityImageView.frame = CGRectMake(
                                         view.frame.size.width/2
                                         -statusImage.size.width/2, 
                                         view.frame.size.height/2
                                         -statusImage.size.height/2, 
                                         statusImage.size.width, 
                                         statusImage.size.height);
    
    activityImageView.tag = -9999;
    //    UIImage *img = (UIImage *)[view viewWithTag:-9999];
    //    if (!img) {
    //Start the animation
    [activityImageView startAnimating];
    activityImageView.hidden = NO;
    [view addSubview:activityImageView];
    //    }
}

-(void)stopImage
{
    [activityImageView stopAnimating];
    activityImageView.hidden = YES;
    [activityImageView removeFromSuperview];
    
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedInstance] retain];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}

//- (void)release {
//    //do nothing
//}

- (id)autorelease {
    return self;
}

+ (NSString *)encodeStringForURL:(NSString *)originalURL {
	NSMutableString *escaped = [[[NSMutableString alloc] init] autorelease];
	[escaped appendString:[originalURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];       
	return escaped;	
}

- (void) changeTheme
{
	
    newtheme = [[NSUserDefaults standardUserDefaults] stringForKey:@"Theme"];
	dataForPicker = [[valuePicker allKeys]retain];
	if(!newtheme || [newtheme length] == 0)
    {
		newtheme = kThemeDefault;
		NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
		[userPreferences setObject:kThemeDefault forKey:@"Theme"];
	}
    NSDictionary *dict = [valuePicker valueForKey:newtheme];
    if(!dict || [dict count] == 0)
    {
        newtheme = [dataForPicker objectAtIndex:0];
        dict = [valuePicker valueForKey:newtheme];
        
        NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
		[userPreferences setObject:newtheme forKey:@"Theme"];
    }
	
    for (Tab *record in tabList) {
        NSString *imgName = [NSString stringWithFormat:@"%@_%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"Theme"], record.title];
        record.tabimg = [UIImage imageNamed:imgName];
    }
    
    wallRemoveImg = [dict valueForKey:@"wallRemoveImg"];
    cellbackImg = [dict valueForKey:@"cellbackImg"];
    navBarImg = [dict valueForKey:@"navBarImg"];
    wallcellbottom = [dict valueForKey:@"wallcellbottom"];
    wallcellbottomdefault = [dict valueForKey:@"wallcellbottomdefault"];
    homebutton =[dict valueForKey:@"homebutton"];
    createaccountbutton =[dict valueForKey:@"createaccountbutton"];
    VMbackImg =[dict valueForKey:@"VMbackImg"];
    MorebackImg =[dict valueForKey:@"MorebackImg"];
    
    profileMenuImages = [dict objectForKey:@"profilemenuimages"];
    friendMenuImages = [dict objectForKey:@"friendmenuimages"];
	bgImage =[dict valueForKey:@"background"];
	selectedbutton =[dict valueForKey:@"button"];
	radioselected =[dict valueForKey:@"radioselected"];
	radiononselected =[dict valueForKey:@"radiononselected"];
	commentbar =[dict valueForKey:@"commentbar"];
	commentbackground =[dict valueForKey:@"comment-small"];
	likebackground = [dict valueForKey:@"likebarimg"];
//	likeimg = [dict valueForKey:@"likeimg"];
//	unlikeimg =[dict valueForKey:@"unlikeimg"];
	transimg = [dict valueForKey:@"transimg"];
	disclosureimg = [dict valueForKey:@"arrow"];
	outboxmsgimg = [dict valueForKey:@"outboxmsgimg"];
	mailreceiveimg =[dict valueForKey:@"mailreceiveimg"];
	mailsendimg = [dict valueForKey:@"mailsendimg"];
	mailwriteimg =[dict valueForKey:@"mailwriteimg"];
	viewdetailimg =[dict valueForKey:@"viewdetailimg"];
	inboxmsgimg = [dict valueForKey:@"inboxmsgimg"];
	pictureimg =[dict valueForKey:@"pictureimg"];
	videoimg =[dict valueForKey:@"videoimg"];
	folderimg = [dict valueForKey:@"folderimg"];
	fontname = [dict valueForKey:@"font"];
    shareImg = [dict valueForKey:@"share-small"];
	sepratorimg =[dict valueForKey:@"customseprator"];
	transimg =[dict valueForKey:@"transimg"];
	addcommentbtn = [dict valueForKey:@"addcommentbutton"];
	textViewImg = [dict valueForKey:@"textviewImg"];
	msgSubjtextImg = [dict valueForKey:@"msginputimg"];
	msgdisclosureimg = [dict valueForKey:@"msg_arrow"];
	pinImg = [dict valueForKey:@"map_pinImg"];
    
    
    // new theme
    
    settingBtnImg = [dict valueForKey:@"settingBtnImg"];
    topImg = [dict valueForKey:@"topImg"];
    bottomImg = [dict valueForKey:@"bottomImg"];
    downloadImg = [dict valueForKey:@"downloadImg"];
    remeberbackImg = [dict valueForKey:@"remeberbackImg"];
    checkImg = [dict valueForKey:@"checkImg"];
    uncheckImg = [dict valueForKey:@"uncheckImg"];
    
    // vm theme
    
    backbtnImage = [dict valueForKey:@"backbtnImage"];
    barbtnImage = [dict valueForKey:@"barbtnImage"];
    addbtnImage = [dict valueForKey:@"addbtnImage"];
    tableHeaderImg = [dict valueForKey:@"tableHeaderImg"];
    addbgImage = [dict valueForKey:@"addbgImage"];
    priceboxImage = [dict valueForKey:@"priceboxImage"];
    imgbottomLine = [dict valueForKey:@"imgbottomLine"];
    couponcodeImage = [dict valueForKey:@"couponcodeImage"];
    searchImg = [dict valueForKey:@"searchImg"];
    vmarrow = [dict valueForKey:@"vmarrow"];
    qtyAddImg = [dict valueForKey:@"qtyAddImg"];
    minusImg = [dict valueForKey:@"minusImg"];
    vmRadioSelect = [dict valueForKey:@"vmRadioSelect"];
    vmRadioUnSelect = [dict valueForKey:@"vmRadioUnSelect"];
    selButton = [dict valueForKey:@"selButton"];
    whiteStarImg = [dict valueForKey:@"whiteStarImg"];
    redStarImg = [dict valueForKey:@"redStarImg"];
    relatedProdImage = [dict valueForKey:@"relatedProdImage"];
    subMenu = [dict valueForKey:@"submenu"];
    subMenuSep = [dict valueForKey:@"submenu-sep"];
    incomingMsg = [dict valueForKey:@"incoming-msg"];
    outgoingMsg = [dict valueForKey:@"outgoing-msg"];
    likeimg = [dict valueForKey:@"like-small"];
	unlikeimg =[dict valueForKey:@"unlike-small"];
    reportImg = [dict valueForKey:@"reportImg"];
    delImg = [dict valueForKey:@"delImg"];
    logoImg = [dict valueForKey:@"logoImg"];
    
	header1 = [UIFont fontWithName:[dict valueForKey:@"header1"] size:[[dict valueForKey:@"size1"]intValue]];
	header2 = [UIFont fontWithName:[dict valueForKey:@"header2"] size:[[dict valueForKey:@"size2"]intValue]];
	header3 = [UIFont fontWithName:[dict valueForKey:@"header3"] size:[[dict valueForKey:@"size3"]intValue]];
	header4 = [UIFont fontWithName:[dict valueForKey:@"header4"] size:[[dict valueForKey:@"size4"]intValue]];
	header5 = [UIFont fontWithName:[dict valueForKey:@"header5"] size:[[dict valueForKey:@"size5"]intValue]];
	header6 = [UIFont fontWithName:[dict valueForKey:@"header6"] size:[[dict valueForKey:@"size6"]intValue]];
	header7 = [UIFont fontWithName:[dict valueForKey:@"header7"] size:[[dict valueForKey:@"size7"]intValue]];
	header8 = [UIFont fontWithName:[dict valueForKey:@"header8"] size:[[dict valueForKey:@"size8"]intValue]];
	header9 = [UIFont fontWithName:[dict valueForKey:@"header9"] size:[[dict valueForKey:@"size9"]intValue]];
	
    
    NSDictionary *celltablecolordict = [dict valueForKey:@"celltextcolor"];
	self.celltextcolor = [UIColor colorWithRed:[[celltablecolordict valueForKey:@"red"]floatValue] green:[[celltablecolordict valueForKey:@"green"]floatValue] blue:[[celltablecolordict valueForKey:@"blue"]floatValue] alpha:[[celltablecolordict valueForKey:@"alpha"]floatValue]] ;
    
    NSDictionary *celltablecolordict1 = [dict valueForKey:@"VMtextcolor"];
	self.VMtextcolor = [UIColor colorWithRed:[[celltablecolordict1 valueForKey:@"red"]floatValue] green:[[celltablecolordict1 valueForKey:@"green"]floatValue] blue:[[celltablecolordict1 valueForKey:@"blue"]floatValue] alpha:[[celltablecolordict1 valueForKey:@"alpha"]floatValue]] ;
    
    
	NSDictionary *tintcolordict = [dict valueForKey:@"tintcolor"];
	self.tintColor = [UIColor colorWithRed:[[tintcolordict valueForKey:@"red"]floatValue] green:[[tintcolordict valueForKey:@"green"]floatValue] blue:[[tintcolordict valueForKey:@"blue"]floatValue] alpha:[[tintcolordict valueForKey:@"alpha"]floatValue]];

    NSDictionary *tablecolordict = [dict valueForKey:@"textcolor"];
	self.textcolor = [UIColor colorWithRed:[[tablecolordict valueForKey:@"red"]floatValue] green:[[tablecolordict valueForKey:@"green"]floatValue] blue:[[tablecolordict valueForKey:@"blue"]floatValue] alpha:[[tablecolordict valueForKey:@"alpha"]floatValue]] ;
	
	NSDictionary *tempColor = [dict valueForKey:@"inputcolor"];
	self.inputtxtColor = [UIColor colorWithRed:[[tempColor valueForKey:@"red"]floatValue] green:[[tempColor valueForKey:@"green"]floatValue] blue:[[tempColor valueForKey:@"blue"]floatValue] alpha:[[tempColor valueForKey:@"alpha"]floatValue]];
    
	NSDictionary *textcolorheader = [dict valueForKey:@"textcolorheader"];
	self.textcolorhead = [UIColor colorWithRed:[[textcolorheader valueForKey:@"red"]floatValue] green:[[textcolorheader valueForKey:@"green"]floatValue] blue:[[textcolorheader valueForKey:@"blue"]floatValue] alpha:[[textcolorheader valueForKey:@"alpha"]floatValue]] ;

	NSDictionary *textcolortimer = [dict valueForKey:@"textcolortime"];
	self.textcolortime = [UIColor colorWithRed:[[textcolortimer valueForKey:@"red"]floatValue] green:[[textcolortimer valueForKey:@"green"]floatValue] blue:[[textcolortimer valueForKey:@"blue"]floatValue] alpha:[[textcolortimer valueForKey:@"alpha"]floatValue]] ;
	
	NSDictionary *colordict =[dict valueForKey:@"color"];
	self.color = [UIColor colorWithRed:[[colordict valueForKey:@"red"]floatValue] green:[[colordict valueForKey:@"green"]floatValue] blue:[[colordict valueForKey:@"blue"]floatValue] alpha:[[colordict valueForKey:@"alpha"]floatValue]] ;
	
	NSDictionary *sepratorColor = [dict valueForKey:@"sepratorColor"];
	self.sepratorcolor = [UIColor colorWithRed:[[sepratorColor valueForKey:@"red"]floatValue] green:[[sepratorColor valueForKey:@"green"]floatValue] blue:[[sepratorColor valueForKey:@"blue"]floatValue] alpha:[[sepratorColor valueForKey:@"alpha"]floatValue]] ;
	
	NSDictionary *segmentcolordict = [dict valueForKey:@"segmentcolor"];
	self.segmentcolor = [UIColor colorWithRed:[[segmentcolordict valueForKey:@"red"]floatValue] green:[[segmentcolordict valueForKey:@"green"]floatValue] blue:[[segmentcolordict valueForKey:@"blue"]floatValue] alpha:[[segmentcolordict valueForKey:@"alpha"]floatValue]];
	
	NSDictionary *msgcolor = [dict valueForKey:@"msgColor"];
	self.txtmsgcolor = [UIColor colorWithRed:[[msgcolor valueForKey:@"red"]floatValue] green:[[msgcolor valueForKey:@"green"]floatValue] blue:[[msgcolor valueForKey:@"blue"]floatValue] alpha:[[msgcolor valueForKey:@"alpha"]floatValue]];

	NSDictionary *txtViewColor = [dict valueForKey:@"txtviewcolor"];
	self.txtviewColor = [UIColor colorWithRed:[[txtViewColor valueForKey:@"red"]floatValue] green:[[txtViewColor valueForKey:@"green"]floatValue] blue:[[txtViewColor valueForKey:@"blue"]floatValue] alpha:[[txtViewColor valueForKey:@"alpha"]floatValue]];

	NSDictionary *timecolour = [dict valueForKey:@"timeColor"];
	self.timecolor = [UIColor colorWithRed:[[timecolour valueForKey:@"red"]floatValue] green:[[timecolour valueForKey:@"green"]floatValue] blue:[[timecolour valueForKey:@"blue"]floatValue] alpha:[[timecolour valueForKey:@"alpha"]floatValue]];

	NSDictionary *cellbackcolor = [dict valueForKey:@"cellbackcolor"];
	self.cellbackgroundcolor = [UIColor colorWithRed:[[cellbackcolor valueForKey:@"red"]floatValue] green:[[cellbackcolor valueForKey:@"green"]floatValue] blue:[[cellbackcolor valueForKey:@"blue"]floatValue] alpha:[[cellbackcolor valueForKey:@"alpha"]floatValue]];

    NSDictionary *vmtexcolorhead = [dict valueForKey:@"vmtextcolorheader"];
	self.vmtextcolorheader = [UIColor colorWithRed:[[vmtexcolorhead valueForKey:@"red"]floatValue] green:[[vmtexcolorhead valueForKey:@"green"]floatValue] blue:[[vmtexcolorhead valueForKey:@"blue"]floatValue] alpha:[[vmtexcolorhead valueForKey:@"alpha"]floatValue]];
    
	themeChanged = FALSE;
}

+ (UIImage *)generateResizingImage:(UIImage *)originalImage {
	CGSize newSize, currentSize;
	currentSize = originalImage.size;
	if(currentSize.height > currentSize.width) {
		if(currentSize.height > UPLOAD_IMAGE_MAX_HEIGHT || currentSize.width > UPLOAD_IMAGE_MAX_WIDTH) {
			newSize.height = UPLOAD_IMAGE_MAX_HEIGHT;
			newSize.width = UPLOAD_IMAGE_MAX_WIDTH;
		} else {
			newSize = currentSize;
		}
	} else {
		if(currentSize.width > UPLOAD_IMAGE_MAX_HEIGHT || currentSize.height > UPLOAD_IMAGE_MAX_WIDTH) {
			newSize.width = UPLOAD_IMAGE_MAX_HEIGHT;
			newSize.height = UPLOAD_IMAGE_MAX_WIDTH;
		} else {
			newSize = currentSize;
		}
	}
	UIGraphicsBeginImageContext( newSize );
	[originalImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

+ (UIImage *)generateStarImages:(float)rating {
	UIImage *result = nil;
	
	if(rating > 5.0) {
		rating /= 2.0;
	}
	
	int offset = 2;
//    UIImage *yellowStar = [UIImage imageNamed:@"star_yellow.png"];
//	UIImage *whiteStar = [UIImage imageNamed:@"star_white.png"];

    UIImage *yellowStar = [UIImage imageNamed:[ApplicationData sharedInstance].redStarImg];
	UIImage *whiteStar = [UIImage imageNamed:[ApplicationData sharedInstance].whiteStarImg];

    
	CGSize size = CGSizeMake(80, 14.0);
	
	CGRect imageRect = CGRectMake(0.0, 0.0, 14.0, 14.0);
	
	unsigned char *data = calloc(1,size.width*size.height*kBytesPerPixel);
	if (data != NULL) {
		// kCGImageAlphaPremultipliedLast documented by Apple as the value to use
		// for a context with alpha
		CGContextRef context = CGBitmapContextCreate (
													  data, size.width, size.height, 8, size.width*kBytesPerPixel,
													  CGColorSpaceCreateDeviceRGB(), kCGImageAlphaPremultipliedLast);
		if(context != NULL) {
			UIGraphicsPushContext(context);
			// UIImage is upside down compared to CGContext.
			CGContextTranslateCTM(context, 0, size.height);
			CGContextScaleCTM(context, 1, -1);
			
			int i = 1;
			
			for (; i <= rating; ++i) {
				[yellowStar drawInRect:imageRect];
				imageRect.origin.x = (imageRect.size.width + offset)*i;
			}
			
			float remainValue = rating - (i-1);
			
			for (; i <= 5; ++i) {
				[whiteStar drawInRect:imageRect];
				imageRect.origin.x = i * (imageRect.size.width + offset);
			}
			
			if(remainValue > 0.1) {
				imageRect.origin.x = 0.0;
                float xPos = (rating - remainValue)*(imageRect.size.width + offset);
				imageRect.size.width = yellowStar.size.width * remainValue;
				
				CGImageRef imageRef = CGImageCreateWithImageInRect([yellowStar CGImage], imageRect);
				// or use the UIImage wherever you like
				imageRect.origin.x = xPos;
				[[UIImage imageWithCGImage:imageRef] drawInRect:imageRect]; 
				
				CGImageRelease(imageRef);
			}
			
			UIGraphicsPopContext();
			CGImageRef imageRef = CGBitmapContextCreateImage(context);
			if (imageRef != NULL) {
				result = [UIImage imageWithCGImage:imageRef];
				CGImageRelease(imageRef);
			}
			CGContextRelease(context);
		}
		free(data);
	} 
	return result;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////Called by Reachability whenever status changes.//////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

- (void) reachabilityChanged: (NSNotification* )note {
	NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
	if(currentNetworkStatus == netStatus) {
		return;
	}
	currentNetworkStatus = netStatus;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (NSString*)topName {
    return [_nameStack lastObject];
}

- (id)topObject:(BOOL)create {
    id object = [_stack objectAtIndex:_stack.count-1];
    if (object == [NSNull null] && create) {
        object = [NSMutableDictionary dictionary];
        [_stack replaceObjectAtIndex:_stack.count-1 withObject:object];
    }
    return object;
}

- (id)topContainer {
    if (_stack.count < 2) {
        return nil;
    } else {
        id object = [_stack objectAtIndex:_stack.count-2];
        if (object == [NSNull null]) {
            object = [NSMutableDictionary dictionary];
            [_stack replaceObjectAtIndex:_stack.count-2 withObject:object];
        }
        return object;
    }
}

- (void)flushCharacters {
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < _chars.length; ++i) {
        unichar c = [_chars characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            if (_stack.count) {
                [_stack replaceObjectAtIndex:_stack.count-1 withObject:_chars];  
            }
            break;
        }
    }
    
    [_chars release];
    _chars = nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"d"]) {
    [self flushCharacters];
    
    id object = nil;
    
        object = [NSNull null];
        [_stack addObject:object];
        [_nameStack addObject:elementName];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!_chars) {
        _chars = [string mutableCopy];
    } else {
        [_chars appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    NSString *string = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    if (!_chars) {
        _chars = [string mutableCopy];
    } else {
        [_chars appendString:string];
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"d"]) {
    [self flushCharacters];
    
    id object = [[[self topObject:NO] retain] autorelease];
    NSString* name = [[self.topName retain] autorelease];
    [_stack removeLastObject];
    [_nameStack removeLastObject];
    
    if (!_stack.count) {
        _rootObject = [object retain];
        _rootName = [name retain];
    } else {
        id topObject = [self topObject:YES];
        if ([topObject isKindOfClass:[NSMutableArray class]]) {
            [topObject addObject:object];
        } else if ([topObject isKindOfClass:[NSMutableDictionary class]]) {
            [topObject setObject:object forKey:name];
        }
    }
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)error {
    _parseError = [error retain];
}

- (void)logout: (UIViewController *) parentcontroller
{


    if (facebook) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [ApplicationData sharedInstance].facebook.accessToken = nil;
        [ApplicationData sharedInstance].facebook.expirationDate = nil;
    }
    sessionId = @"";
	recipient = @"";
    vmRecipient = @"";
	userDetail = nil;
	//settings = nil;
	loggedUser = 0;
	totalFriends = 0;
	totalMembers = 0;
	totalSearched = 0;
	totalBlogs = 0;
	userId = 0;
    totalUpdates = 0;
	userDetailCached = NO;
    
//	[parentcontroller.navigationController popToRootView1ControllerAnimated:NO];
//	iJoomerAppDelegate *appdelegate =(iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];	
//	[[appdelegate customTabController] setSelectedIndex:0];
	
	[inboxList removeAllObjects];
	[outboxList removeAllObjects];
	[albumList removeAllObjects];
	[friendList removeAllObjects];
	[memberList removeAllObjects];
	[searchList removeAllObjects];
	[notificationList removeAllObjects];
	[unreadMsgList removeAllObjects];
	[updatesList removeAllObjects];
	[directoryList removeAllObjects];
    [albumArray removeAllObjects];
    [allAlbumArray removeAllObjects];
	[collectionList removeAllObjects];
	[grouplist removeAllObjects];
    [groupArray removeAllObjects];
    [eventArray removeAllObjects];
    [photoArray removeAllObjects];
    [videoArray removeAllObjects];
    [profileArray removeAllObjects];
    
    //blog
    
    [bloglist removeAllObjects];
    [blogCategoryList removeAllObjects];
    [myTagList removeAllObjects];
    [MyBlogList removeAllObjects];
    [MyBlogCommentList removeAllObjects];
    [categoryBloglist removeAllObjects];
    
	
	[storelist removeAllObjects];
	[videolist removeAllObjects];
	[chatList removeAllObjects];
	[chatingList removeAllObjects];
	[eventList removeAllObjects];
    [settingFieldList removeAllObjects];
    
    [categoryList removeAllObjects];
	//[recentTopics removeAllObjects];
    recentTopics = [[NSMutableArray alloc]init];

    //[recentTopicList removeAllObjects];
    [ApplicationData sharedInstance].recentTopicList = [[NSMutableArray alloc]init ];
	[favoriteTopics removeAllObjects];
	[subscribedTopics removeAllObjects];
	[myTopics removeAllObjects];
	user = nil;
	[tabBaritemsArray removeAllObjects];
    
    //group
    [mygroupList removeAllObjects];
    [pendinglist removeAllObjects];
    [groupCategoryList removeAllObjects];
    [recList removeAllObjects];
	// jom soial
	[jomEventList removeAllObjects];
	[jomPastEvents removeAllObjects];
	[jomCategoryList removeAllObjects];
    [settingFieldList removeAllObjects];
	[jomPendingList removeAllObjects];
	[jomAdminList removeAllObjects];
	[jomGuestList removeAllObjects];
	[jomSpecialEventList removeAllObjects];
	[jomSpecialGalleryAlbumList removeAllObjects];
	[jomSpecialGalleryList removeAllObjects];
    
    // vm
    
    [featuredProductList removeAllObjects];
    [wishListProductList removeAllObjects];
    [latestProductList removeAllObjects];
    [cartProductList removeAllObjects];
    [wishDetailList removeAllObjects];
    [sortList removeAllObjects];
    [shippingList removeAllObjects];
    [shippingMethodList removeAllObjects];
    [paymentList removeAllObjects];
    [orderDetailList removeAllObjects];
    [relatedProductList removeAllObjects];
    [wishListingArray removeAllObjects];
    [wishArray removeAllObjects];
    [wishDetailArray removeAllObjects];
    [fullWishListArray removeAllObjects];
    [searchCategoryArray removeAllObjects];
    [myAccountArray removeAllObjects];
    [wishListingArray removeAllObjects];
    [vmcategoryList removeAllObjects];

    [categoryEntryArray removeAllObjects];
    
    
    
    [groupFieldsArray removeAllObjects];
    [eventFieldsArray removeAllObjects];
}


+ (NSData *)AES128EncryptWithKey:(NSString *)key Str:(NSData *)plain
{
    // ‘key’ should be 16 bytes for AES128
    char keyPtr[kCCKeySizeAES128 + 1]; // room for terminator (unused)
    bzero( keyPtr, sizeof( keyPtr ) ); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof( keyPtr ) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [plain length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That’s why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc( bufferSize );
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt( kCCEncrypt, kCCAlgorithmAES128, kCCOptionECBMode | kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES128,
                                          NULL /* initialization vector (optional) */,
                                          [plain bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted );
    if( cryptStatus == kCCSuccess )
    {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free( buffer ); //free the buffer
    return nil;
}

+ (NSData *)AES128DecryptWithKey:(NSString *)key Str:(NSData *)plain{
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused)
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [plain length];
	
	//See the doc: For block ciphers, the output size will always be less than or
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesDecrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES128,
                                          NULL /* initialization vector (optional) */,
                                          [plain bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
	}
	
	free(buffer); //free the buffer;
	return nil;
}


-(void)onTick:(NSTimer *)timer {
    
    for( int index = 0; index < ijoomertime; index++ ) 
    {
        //code I want to execute
        [self performSelector:@selector(loopMethod) 
                   withObject:nil 
                   afterDelay:2.0];   
    }

}

- (void)updateTimer{

}

-(void)pauseLayer:(CALayer*)layer
{

}

-(void)resumeLayer:(CALayer*)layer
{

}
-(void)keepsession{

    
}

-(void)stoptimer{
 
}

//////#####
-(void) setNotificationcount
{
    iJoomerAppDelegate *appdelegate = (iJoomerAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if ([ApplicationData sharedInstance].frndCount == 0)
    {
        appdelegate.btnFriendCount.hidden = YES;
    }
    else
    {
        appdelegate.btnFriendCount.hidden = NO;
        [appdelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
    }
    
    if ([ApplicationData sharedInstance].msgCount == 0)
    {
        appdelegate.btnMsgCount.hidden = YES;
    }
    else
    {
        appdelegate.btnMsgCount.hidden = NO;
        [appdelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
    }
    
    if ([ApplicationData sharedInstance].groupCount == 0)
    {
        appdelegate.btnGroupCount.hidden = YES;
    }
    else
    {
        appdelegate.btnGroupCount.hidden = NO;
        [appdelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
    }
}
//////#####


////////Tab Bar Menu set

-(void)TabReset
{
    
}

/////////////////////////


- (void)dealloc {
    
    
	[userDetail release];
    [groupArray release];
    [eventArray release];
    [photoArray release];
    [videoArray release];
    [profileArray release];
	[selectedUser release];
	//[settings release];
	[recipient release];
	[profileTypeList release];
	[inboxList release];
	[outboxList release];
	[albumList release];
	[friendList release];
	[memberList release];
	[searchList release];
    [settingFieldList release];
	[notificationList release];
	[unreadMsgList release];
	[updatesList release];
	[locationManager release];
	[wifiReach release];
    [selectedFriend release];
	[directoryList release];
	[collectionList release];
	[bloglist release];
	[storelist release];
	[grouplist release];
	[videolist release];
	[chatList release];
	[chatingList release];
	[eventList release];
	[facebook release];
    [tabList release];
	[profilemenuList release];
    [friendmenuList  release];
    
    // blog
    
    [website release];
    [emailAdd release];
    [blogCategoryList release];
    [MyBlogList release];
    [MyBlogCommentList release];
    [myTagList release];
    [tagBloglist release];
    [tagList release];
    [categoryBloglist release];
    
    //group
    [mygroupList release];
    [pendinglist release];
    [groupCategoryList release];
    
    //kunena
	[categoryList release];
	[recentTopics release];
    [recentTopicList release];
	[favoriteTopics release];
	[subscribedTopics release];
	[myTopics release];
	[user release];
	[tabBaritemsArray release];
	
	// jom social
	[jomMyEventList release];
	[errorMessage release];
	[jomPastEvents release];
	[jomPendingList release];
	[jomAdminList release];
	[jomGuestList release];
	[jomSpecialEventList release];
	[jomSpecialGalleryAlbumList release];
	[jomSpecialGalleryList release];
    
    [_stack release];
    [_nameStack release];
    [_rootObject release];
    [_rootName release];
    [_chars release];
    [_parseError release];
    
    [galleryUser release];
    [defaultView release];
    [defaultRegistarion release];
    
    //vm
    [countryId release];
    [featuredProductView release];
    [featuredProductList release];
    [wishListProductList release];
	[cartProductList release];
	[latestProductList release];
    [wishDetailList release];
    [wishArray release];
    [shippingList release];
    [searchCategoryArray release];
    [myAccountArray release];
    [shippingMethodList release];
    [paymentList release];
    [vmcategoryList release];
    [albumArray release];
    [allAlbumArray release];

    
    [contactsArray release];
    [videoCategoryArray release];
    [myVideos release];
    [AllVideos release];
    
    ////////////////////////////////////// jom social //////////////////////////
    
    [subMenu release];
    [subMenuSep release];
    [delImg release];
    [reportImg release];
    [groupFieldsArray release];
    [eventFieldsArray release];
    [shareImg release];
    [incomingMsg release];
    [outgoingMsg release];
    ///////////////////////////////////////////////////////////////////////////

    if (false) {
        [super dealloc];
    }
   	
}

@end
