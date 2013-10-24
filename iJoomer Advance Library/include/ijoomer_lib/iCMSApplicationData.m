//
//  iCMSApplicationData.m
//  iJoomer
//
//  Created by Tailored Solutions on 4/9/13.
//
//

#import "iCMSApplicationData.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonCryptor.h>
#import "SQLiteManager.h"
#import "iJoomerAppDelegate.h"
#import "SA_OAuthTwitterController.h"
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"
#import "SA_OAuthTwitterEngine.h"
#import "User.h"
#import "ICMSFavouriteArticleViewDelegate.h"

static iCMSApplicationData *applicationData = nil;

@implementation iCMSApplicationData

@synthesize StrClassName;

@synthesize bgImage;
@synthesize textcolor;
@synthesize textcolorhead;
@synthesize tintColor;
@synthesize tabtextcolor;
@synthesize moreCellBackColor;
@synthesize errorCode;
@synthesize newtheme;
@synthesize oldtheme;
@synthesize navBarImg;
@synthesize themeChanged;
@synthesize header1;
@synthesize header2;
@synthesize header3;
@synthesize header4;
@synthesize header5;
@synthesize header6;
@synthesize header7;
@synthesize header8;
@synthesize header9;
@synthesize iCMSCategoryList;
@synthesize iCMSArticleList;
@synthesize iCMSFeaturedArticleList;
@synthesize favoriteArticleList;
@synthesize iCMSArchivedArticleList;
@synthesize contactsArray;
@synthesize wallRemoveImg;
@synthesize showTabs;

@synthesize pageLimit;
@synthesize totalArchived;
@synthesize FeaturedpageLimit;
@synthesize totalFeatured;
@synthesize ArticlepageLimit;
@synthesize totalArticle;

@synthesize facebook;
@synthesize twitter;
@synthesize userDeatail;
@synthesize article;
@synthesize sqlManager;

///////Theme, application Menu /////////////

////////////////////////////////////////////

//Data fetch and store ina db flags.
@synthesize feturedListFlag;
@synthesize archiveListFlag;
@synthesize categoryListFlag;
@synthesize articalListFlag;

@synthesize tabBarImg;
@synthesize checkImg;
@synthesize uncheckImg;

- (id)init {
	if(self == [super init]) {
        
        StrClassName = @"";
        
        sqlManager = [[SQLiteManager alloc] initDatabase:@"ICMSFavoriteArticle.sqlite"];
        themeDictionary = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Data.plist"]];
		valuePicker = [themeDictionary objectForKey:@"themes"];
		[valuePicker retain];
        
        errorCode = jSuccess;
        
        iCMSCategoryList = [[NSMutableArray alloc] init];
        iCMSArticleList = [[NSMutableArray alloc] init];
        iCMSFeaturedArticleList = [[NSMutableArray alloc] init];
        iCMSArchivedArticleList = [[NSMutableArray alloc] init];
        contactsArray = [[NSMutableArray alloc] init];
        favoriteArticleList = [[NSMutableArray alloc] init];
        //Data fetch and store ina db flags.
        feturedListFlag = NO;
        archiveListFlag = NO;
        categoryListFlag = NO;
        articalListFlag = NO;
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
		wifiReach = [[Reachability reachabilityWithHostName:@"www.google.com"] retain];
		[wifiReach startNotifer];
		currentNetworkStatus = ReachableViaWiFi;
		[self reachabilityChanged:nil];
        // Create twitter object
		twitter = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: nil];
		twitter.consumerKey = kOAuthConsumerKey;
		twitter.consumerSecret = kOAuthConsumerSecret;
        userDeatail = [[User alloc] init];
        userPermissions = [[NSMutableDictionary alloc] initWithCapacity:1];
        
        /////////Theme, application Menu ////////////////////////////////////////////////////////
               
        navBarImg = @"";
        showTabs = NO;
        
        article = [[iCMSArticle alloc] init];
        wallRemoveImg = @"";
        /////////////////////////////////////////////////////////////////////////////////////////
        
        pageLimit = 0;
        totalArchived = 0;
        FeaturedpageLimit = 0;
        totalFeatured = 0;
        ArticlepageLimit = 0;
        totalArticle = 0;

    }
    return self;
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

+ (NSString *)encodeStringForURL:(NSString *)originalURL {
	NSMutableString *escaped = [[[NSMutableString alloc] init] autorelease];
	[escaped appendString:[originalURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	return escaped;
}

- (void)initialize {
    
}

+ (iCMSApplicationData *)sharedInstance {
    if (applicationData == nil) {
        applicationData = [[super allocWithZone:NULL] init];
		[applicationData initialize];
        [applicationData readFavoritArticle];
        [applicationData retain];
    }
    
    return applicationData;
}

- (void) changeTheme {
	
    newtheme = [[NSUserDefaults standardUserDefaults] stringForKey:@"Theme"];
	dataForPicker = [[valuePicker allKeys]retain];
	if(!newtheme || [newtheme length] == 0) {
		newtheme = kThemeDefault;
		NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
		[userPreferences setObject:kThemeDefault forKey:@"Theme"];
	}
    NSDictionary *dict = [valuePicker valueForKey:newtheme];

    if(!dict || [dict count] == 0) {
        newtheme = [dataForPicker objectAtIndex:0];
        dict = [valuePicker valueForKey:newtheme];
        
        NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
		[userPreferences setObject:newtheme forKey:@"Theme"];
    }
    
    navBarImg = [dict valueForKey:@"navBarImg"];
    bgImage =[dict valueForKey:@"background"];
    wallRemoveImg = [dict valueForKey:@"wallRemoveImg"];
    tabBarImg = [dict valueForKey:@"tabBarImg"];
    checkImg = [dict valueForKey:@"checkImg"];
    uncheckImg = [dict valueForKey:@"uncheckImg"];
    
    header1 = [UIFont fontWithName:[dict valueForKey:@"header1"] size:[[dict valueForKey:@"size1"]intValue]];
	header2 = [UIFont fontWithName:[dict valueForKey:@"header2"] size:[[dict valueForKey:@"size2"]intValue]];
	header3 = [UIFont fontWithName:[dict valueForKey:@"header3"] size:[[dict valueForKey:@"size3"]intValue]];
	header4 = [UIFont fontWithName:[dict valueForKey:@"header4"] size:[[dict valueForKey:@"size4"]intValue]];
	header5 = [UIFont fontWithName:[dict valueForKey:@"header5"] size:[[dict valueForKey:@"size5"]intValue]];
	header6 = [UIFont fontWithName:[dict valueForKey:@"header6"] size:[[dict valueForKey:@"size6"]intValue]];
	header7 = [UIFont fontWithName:[dict valueForKey:@"header7"] size:[[dict valueForKey:@"size7"]intValue]];
	header8 = [UIFont fontWithName:[dict valueForKey:@"header8"] size:[[dict valueForKey:@"size8"]intValue]];
	header9 = [UIFont fontWithName:[dict valueForKey:@"header9"] size:[[dict valueForKey:@"size9"]intValue]];
    
	NSDictionary *tablecolordict = [dict valueForKey:@"textcolor"];
	self.textcolor = [UIColor colorWithRed:[[tablecolordict valueForKey:@"red"]floatValue] green:[[tablecolordict valueForKey:@"green"]floatValue] blue:[[tablecolordict valueForKey:@"blue"]floatValue] alpha:[[tablecolordict valueForKey:@"alpha"]floatValue]] ;
    
	NSDictionary *textcolorheader = [dict valueForKey:@"textcolorheader"];
	self.textcolorhead = [UIColor colorWithRed:[[textcolorheader valueForKey:@"red"]floatValue] green:[[textcolorheader valueForKey:@"green"]floatValue] blue:[[textcolorheader valueForKey:@"blue"]floatValue] alpha:[[textcolorheader valueForKey:@"alpha"]floatValue]] ;
    
    NSDictionary *tintcolordict = [dict valueForKey:@"tintcolor"];
	self.tintColor = [UIColor colorWithRed:[[tintcolordict valueForKey:@"red"]floatValue] green:[[tintcolordict valueForKey:@"green"]floatValue] blue:[[tintcolordict valueForKey:@"blue"]floatValue] alpha:[[tintcolordict valueForKey:@"alpha"]floatValue]];
    
    
    NSDictionary *tabtextcolordict = [dict valueForKey:@"tabtextcolor"];
	self.tabtextcolor = [UIColor colorWithRed:[[tabtextcolordict valueForKey:@"red"]floatValue] green:[[tabtextcolordict valueForKey:@"green"]floatValue] blue:[[tabtextcolordict valueForKey:@"blue"]floatValue] alpha:[[tabtextcolordict valueForKey:@"alpha"]floatValue]];
    
    NSDictionary *moreCellColor = [dict valueForKey:@"moreCellBackColor"];
	self.moreCellBackColor = [UIColor colorWithRed:[[moreCellColor valueForKey:@"red"]floatValue] green:[[moreCellColor valueForKey:@"green"]floatValue] blue:[[moreCellColor valueForKey:@"blue"]floatValue] alpha:[[moreCellColor valueForKey:@"alpha"]floatValue]];
    
	themeChanged = FALSE;
}

+ (id)allocWithZone:(NSZone *)zone {
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
- (id)autorelease {
    return self;
}

- (void)readFavoritArticle {
    [self.favoriteArticleList removeAllObjects];
    ICMSFavouriteArticleViewDelegate *delegate = [[ICMSFavouriteArticleViewDelegate alloc] init];
	sqlManager.delegate = delegate;
	[sqlManager readDatabase];
}

- (bool)addToFavoritList {
    ICMSFavouriteArticleViewDelegate *delegate = [[ICMSFavouriteArticleViewDelegate alloc] init];
	sqlManager.delegate = delegate;
	[self.favoriteArticleList addObject:self.article];
	return [sqlManager insertData];
}
- (bool)deleteFromFavoriteList {
	ICMSFavouriteArticleViewDelegate *delegate = [[ICMSFavouriteArticleViewDelegate alloc] init];
	sqlManager.delegate = delegate;
    
	if([sqlManager deleteData]) {
		[self.favoriteArticleList removeObject:self.article];
		return TRUE;
	}
	return FALSE;
}

////////Tab Bar Menu set

-(void)TabReset
{
    
}

/////////////////////////



- (void)dealloc {
    
    [bgImage release];
    [textcolor release];
    [textcolorhead release];
    [navBarImg release];
    
    [iCMSCategoryList release];
    [iCMSArticleList release];
    [iCMSFeaturedArticleList release];
    [iCMSArchivedArticleList release];
    [favoriteArticleList release];
    [contactsArray release];
    [facebook release];
    [article release];
    [super dealloc];
}
@end
