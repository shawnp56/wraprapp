//
//  GlobalObjects.h
//  ijoomer_lib
//
//  Created by tailored on 10/12/12.
//  Copyright (c) 2013 tailored. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonCryptor.h>
#import <sqlite3.h>
#import "User.h"
#import "Wall.h"
#import "Group.h"
#import "Category.h"
#import "Photo.h"
#import "Video.h"
#import "videocategories.h"
//#define static_Logcashing_flag @"YES"
#define static_Keysfordatastring @"screens, menuitem, options, articleimages, content_data, menu, adminMenu, option, group_data, event_data, image_data, privacy, profile_video, condition"


@interface GlobalObjects : NSObject
//jomsocial.....
//ProfileDetail.



+ (User *) ProfileDetail:(NSDictionary *) dict;

////FBLogin.
//+ (User *) FBLogin:(NSDictionary *) dict;

//registration stap 1.
+ (User *) Registration:(NSDictionary *) dict;

//userdetail.
+(User *) Userdetail :(NSDictionary *) dict;

//all member or friends list.
+(NSMutableArray *) Memberlist :(NSDictionary *) dict Exttask :(NSString *)exttask;

//notification member profile.
+(User *) Notification_member_profile :(NSDictionary *) dict;

//member search.
+(NSMutableArray *) MemberSearch :(NSDictionary *) dict;

//activities.
+(NSMutableArray *) Activities :(NSDictionary *) dict;

//profile Type
+(NSMutableArray *) ProfileType :(NSDictionary *) dict;

//User Privacy settings Type
+(NSMutableArray *) UserPrivacysettings :(NSDictionary *) dict;

+(NSMutableArray *)Wall:(NSDictionary *)dict;

+(Wall *)Share:(NSDictionary *)dict;

+(NSMutableArray *)Like:(NSDictionary *)dict;

+(NSMutableArray *)Comments:(NSDictionary *)dict;

+(NSMutableArray *)Albums:(NSDictionary *)dict;

+(Category *)Photos:(NSDictionary *)dict Album:(Category *)albumObj;

+(Category *)PhotoComments:(NSDictionary *)dict Comment:(Category *)albumObj;

+(Photo *)PhotoComment:(NSDictionary *)dict Comment:(Photo *)photoObj;

+(NSMutableArray *)getPhoneBook;

+(User *)videoList:(NSDictionary *)dict Video:(User *)userObj;

+(int)AllvideoListFinal:(NSDictionary *)dict;

+(Category *)AllvideoList:(NSDictionary *)dict Video:(Category *)videoObj;

+(Video *)videoComments:(NSDictionary *)dict Comment:(Video *)videoObj;

+(NSMutableArray *)videocategories:(NSDictionary *)dict;

+(BOOL)Applicationconfigration:(NSDictionary *)dict;

+(NSMutableArray *)ApplicationMenulist:(NSString *)screenname menuposition:(int)menupos;

+(NSMutableArray *)Applicationtheme;

+(int)MessagesConversationList:(NSDictionary *)dict;

+(NSMutableArray *)MessagesDetailList:(NSDictionary *)dict;

/////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////Joomsocial Group///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
+(int)GroupcategoriesList:(NSDictionary *)dict;

+(NSMutableArray *)GroupList:(NSDictionary *)dict;

+(Group *)GroupDetail:(NSDictionary *)dict;

+(void)GroupFieldsList:(NSDictionary *)dict;

+(NSMutableArray *)DiscussionList:(NSDictionary *)dict;

+(NSMutableArray *) GroupMemberlist :(NSDictionary *) dict;

+(NSMutableArray *)FileList:(NSDictionary *)dict;

/////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////Jomsocial Events///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////


+(NSMutableArray *)EventList:(NSDictionary *)dict;

+(Event *)EventDetail:(NSDictionary *)dict;


/////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////key fatching for data store///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

//fatch images of config
- (void)applicationconfigImagesdownloadfromURL;

+(BOOL)KeyStoreAsString :(NSString *)keyname;

/////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////key fatching for data store///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

@end
