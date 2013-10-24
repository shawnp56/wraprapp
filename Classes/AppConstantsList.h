//
//  Created by Tailored Solutions on 03/07/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//
#import <Foundation/Foundation.h>

//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////  Constants /////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef DEBUG_MODE
#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
//#define DLog( s, ... ) 
#else
#define DLog( s, ... ) 
#endif


#define TABLE_CELL_HEIGHT			68
#define UPLOAD_IMAGE_MAX_HEIGHT		200
#define UPLOAD_IMAGE_MAX_WIDTH		200
#define VIEW_TYPE                   @"thumb"

#define LOCATION_WAIT_TIME			15// in seconds
#define CORNER_RADIUS				15
#define SEARCH_INCREMENT			10
#define MYTOPIC_LIST_LIMIT          20
#define LIST_LIMIT					20
#define PAGE_COUNT					16
#define BLOG_PAGE_LIMIT				10
#define EVENT_LIST_LIMIT			10
#define BOTTOM_TAB_ITEM_COUNT       5
#define TAB_COUNT					9
#define MSG_LIST_LIMIT              15
#define ALBUM_LIMIT                 12
#define KNoId                       -999

#define MIN_DISTANCE                1
#define MAX_DISTANCE                100
#define kDistanceKey                @"setdistance"

#define USE_SERVER_TABS             YES
#define ISCHATREQUIRED              NO
#define ISARTICLEADDENABLED         YES
#define ISEDITORIMAGEREQUIRED		YES
#define ISFACEBOOKREQUIRED          YES
#define FIELD_PICKER                @"select"
#define FIELD_SWITCH                @"radio"
#define RADIOBUTTON_ON              @"1"
#define RADIOBUTTON_OFF             @"0"
#define ISUPDATEVOICE                YES 
#define ISPROFILEEVOICE              YES
#define ISCOMMENTVOICE               YES
#define ISPHOTOVOICE                 YES 
#define ISPHOTOCOMMENTVOICE          YES 
#define ISVIDEOCOMMENTVOICE          YES 
#define ISGROUPCOMMENTVOICE          YES 
#define ISGROUPWALLCOMMENTVOICE      YES 
#define ISEVENTDETAILTVOICE          YES
#define ISREPLYLISTTVOICE            YES
#define ISWRITEMSGTVOICE             YES

// For Twitter
#define kOAuthConsumerKey           @"8CDQjHRcv80RD2rM0IO2xQ"
#define kOAuthConsumerSecret        @"FgXI2Vt1xP1D5U46F44iRNkhjMFymv7hHK1MiHMhqOw"

// Facebook keys 

#define kApiKey                     @"250599871719740"
#define kApiSecret                  @"c129c5ddd70da2bb30835cc317ff8195"

#define BOTTOM_TAB_ITEM_COUNT_VM    3
 
#define REFRESH_HEADER_HEIGHT 70.0f


//http://www.danceworld-la.de

// FBConstant
#define FB_EXISTING              1
#define FB_CREATE                2

////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////// XML Tags /////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

#define TAG_CODE					@"code"
#define TAG_USERID					@"userid"
#define TAG_SESSION					@"sessionid"
#define TAG_DATA					@"data"
#define TAG_USER					@"user"
#define TAG_UID						@"uid"
#define TAG_STATUS					@"status"
#define TAG_AVATAR					@"avatar"
#define TAG_VIEWCOUNT				@"viewcount"
#define TAG_JOMSOCIAL               @"jomsocial"
#define TAG_ACTIVITIES              @"activities"
#define TAG_ACTIVITY                @"activity"
#define TAG_REGISTRATION            @"registration"


// CHATING
#define JS_DATA						@"l"
#define JS_USER_ID					@"i"
#define JS_USER_NAME				@"o"
#define JS_S						@"s"
#define JS_FROM						@"f"
#define JS_FROM_NAME				@"show"
#define JS_MESSAGE					@"m"
#define JS_LIST						@"lst"
#define JS_THUMB					@"thumb"
#define JS_LINK						@"link"


#define kUseLiveURL                 @"liveserver"
#define kLiveServerURL              @"liveurl"
#define kCurrentMonth               @"CurrentMonth"
#define kServerURL                  @"serverurl"
#define kExtraParam                 @"extraparam"
#define kUseDefaultURL              @"usedefault"

#define kThemeDefault                   @"Leather"

#define GENERAL_DATE_FORMAT				@"yyyy-MM-dd"
#define GENERAL_TIME_FORMAT				@"HH:mm:ss"
#define GENERAL_DATE_TIME_FORMAT_AMPM	@"yyyy-MM-dd HH:mm:ss"
#define GENERAL_COMMENT_DATE_FORMAT     @"MMM d, YYYY"
#define GENERAL_DATE_TIME_FORMAT_AMPM	@"yyyy-MM-dd HH:mm:ss"

typedef enum {
	
	jSuccess = 200,
	jNoContent = 204,
	jBadRequest = 400,
    jLoginRequired = 401,
	jErrorMessage = 404,
    jUnsupportedFile = 415,
    jInvalidData = 416,
    jErroronServer = 500,
    jUserNameError = 701,
    jEmailError = 702,
    jFBOption = 703,
    jSessionExpire = 704,
    jReportedContent = 705,
    JPermissionError = 706,
    jDuplicateData = 707,
    jWaitingForPermission = 708
    
} iJoomerErrorCode;

typedef enum {
	jLoginQuery = 0,
	jGeneralQuery,
	jProfileTypeQuery,
    jStatusQuery,
	jRemoveUserQuery,
	jProfileQuery,
	jLogoutQuery,
	jFullProfileQuery,
	jInboxQuery,
	jOutboxQuery,
    jInnerMsgQuery,
	jFriendsQuery,
    jAlbumQuery,
    jAlbumAddQuery,
	jPhotoAlbumQuery,
    jPhotoAlbumImagesQuery,
    jAddphotoQuery,
    jPhotoCommentQuery,
	jVideoAlbumQuery,
	jVideoAlbumVideosQuery,
	jNotificationQuery,
	jAcceptQuery,
	jRejectQuery,
	jUpdatesQuery,
	jAddFriendQuery,
	jSettingsQuery,
	jAddCountQuery,
	jPollQuery,
	jPastPollQuery,
	jPollResultQuery,
	jWallListQuery,
	jLikeQuery,
	jUnlikeQuery,
    jDislikeQuery,
	jPostQuery,
	jShareQuery,
	jEditProfileQuery,
	jSearchQuery,
	jMembersQuery,
	jJReviewQuery,
	jArticlelistQuery,
	jArticleDetailQuery,
	jCollectionUploadQuery,
	jSubmitReviewQuery,
	jGroupQuery,
    jGroupSearchQuery,
	jGroupwallQuery,
	jBlogQuery,
	jBlogDetailQuery,
	jChatListQuery,
	jChatHeartbeat,
	jChatSendQuery,
	jEventListQuery,
	jEventSearchQuery,
	jRegisterQuery,
    jFBSignup,
    jTabListQuery,
    jCategoryQuery,
	jSubCategoryQuery,
    jTopicListQuery,
    jRecentTopicsQuery,
    jTopicDetailQuery,
	jFavoriteTopicsQuery,
	jSetFavQuery,
	jSetUnFavQuery,
	jSubscribedTopicsQuery,
	jSubscribeQuery,
	jUnsubscribeQuery,
	jWhoIsOnlineQuery,
	jNewTopicQuery,
	jMyTopicsQuery,
	jReplyListQuery,
	jAddReplyQuery,
	jCheckSubCategoryQuery,
	jSubscribeWallQuery,
	jUnsubscribeWallQuery,
	jJomEventCategoryListQuery,
	jJomMyEventListQuery,
    jJomEventMemberListQuery, 
	jJomPastEventListQuery,
	jJomEventDetailQuery,
	jJomPastInvitationListQuery,
	jJomEditEvent,
	jJomLikeQuery,
	jJomInvitedFriendListQuery,
	jJomWallListQuery,
	jJomUnBlockUserQuery,
	jJomShareQuery,
	jJomSpecialEventQuery,
	jJomSpecialGalleryAlbumListQuery,
	jJomSpecialGalleryQuery,
    jJoinQuery,
    jUnjoinQuery,
    jMygroupQuery,
    jPendingQuery,
    jGroupCatQuery,
    jBulletingQuery,
    jDiscussionQuery,
    jGroupDetailQuery,
    jInvitedFriendListQuery,
    jEditGroup,
    jAdminListQuery,
    jMemberQuery,
    jBanQuery,
    jJomEditGroup,
    jDiscussionDetailQuery,
    jPostGroupQuery,
    jGroupEventQuery,
    jAddVideoQuery,
    jAddArticle,
    
    //SOBI PRO
    
    Scategory,
	SPROcategory,
	Sentries,
	SPROentries,
	Sentries1,
	SPROentries1,
	Sdetails,
	SPROdetails,
	Sconfig,
	Search,
	Sreview,
	SearchSobi,
	SProSectionQuery,
	SPROSearchContent,
	SProconfig,
	SearchSobiPro,
    
    //Sobi2
    
    Sfeatured,
    
    //blog
    
    jBlogCategoryListQuery,
    jBlogTagListQuery,
    jBlogCommentListQuery,
    jMyBlogListQuery,
    jMyCommentListQuery, //blog's my comments
    jMyTagListQuery,
    jTagBlogListQuery,
    jAddNewBlogQuery,

    
    jvmCategoryQuery,
	jvmSubCategoryQuery,
	jvmProductQuery,
	jvmsubProductQuery,
	jvmReviewQuery,
	jvmProductDetail,
	jvmWishProductQuery,
	jvmProductListingQuery,
	jvmAddReviewQuery,
	jvmDuplicateEmail,
	jvmDuplicateUserName,
	jvmRegisterQuery,
	jvmAdReviewQuery,
	jvmLogoutQuery,
	jvmAddToWishListQuery,
	jvmWishListDetailQuery,
    jvmPostListRequestQuery,
    jvmCartListQuery,
    jvmFullRegisterQuery,
    jvmFeatureQuery,
    jvmBillingAddressQuery,
    jvmSaveRegisterQuery,
    jvmShippingMethodQuery,
    jvmPaymentMethodQuery,
    jvmConfirmOrderQuery,
    jvmCompleteOrderQuery,
    jvmOrderDetailQuery,
    jvmConfigQuery,
    jvmCouponQuery,
    jvmDeleteCartQuery,
    jvmMyAccountResponse,
    jvmSearchCatQuery,
    jvmSearchQuery,
    jvmWishListingQuery,
    jNewSplaceQuery,
    jRequestReset,
    jRequestConfirmReset,
    jRequestCompleteReset,
    jDeleteWallQuery,
    jlikeUnlikeQuery,
    
    //iCMS..
    iCMSCategoryListQuery,
    iCMSFeaturedArticleListQuery,
    iCMSArchivedArticleListQuery,
    iCMSArticleDetailQuery,
    ICMSPingTestQuery
    
    
    
} HTTPRequest;

