//
//  iCMS.h
//  iJoomer
//
//  Created by Tailored Solutions on 4/9/13.
//
//

#import <Foundation/Foundation.h>
#import "iCMSApplicationData.h"
#import "JoomlaRegistration.h"


#define static_Keysfordatastring @"screens, menuitem, options, articleimages, content_data, menu, adminMenu, option, group_data, event_data, image_data, privacy, profile_video, condition"

#define arrayiCMSFieldconstant [NSArray arrayWithObjects: @"screens",@"menuitem",@"options",@"articleimages", @"content_data", @"menu", @"adminMenu", @"option", @"group_data", @"event_data", @"image_data", @"privacy", @"profile_video", @"condition",nil]

//,@"introtext",@"fulltext"

@interface iCMS : NSObject

/*
 
 Global Function for creating dictionary.
 
 This Function is use for Fetch data of ICMS All Category List and Store in Database as well Send to User.
 extView : viewname
 extTask : taskname
 Taskdatadict : Dictionary of Post Variables.
 Imagedata : imagedata
 */
+ (NSString *)CreateDictionary_iCMS :(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

/*
 
 Global Function for creating Tablestring.
 
 This Function is use for Fetch data of ICMS All Category List and Store in Database as well Send to User.
 allkey : allKeysArray
 allvalues : allValuesArray
 */
+(NSString *)Createtablestring:(NSArray *)allkey allvalues:(NSArray *)allvalue;

/*
 
 Global Function for populating data of ICMS All Category List.
 
 This Function is use for Fetch data of ICMS All Category List and Store in Database as well Send to User.
 extView : categories
 extTask : category
 extName : icms
 Taskdatadict : Dictionary of Post Variables.
 */

+(NSDictionary *)iCMSCategoryList:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

+(void)Categorydatastore :(NSString *) json ExtTask:(NSString *) extTask;

+(NSDictionary *)iCMSArticalListWith_Category:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

+(void)iCMSArticalListWith_Categorydatastore :(NSString *) json ExtTask:(NSString *) extTask catinsert:(int)catflag articalinsert:(int)articalflag TaskdataDictionary :(NSMutableDictionary *) Taskdatadict;

///iCMSArchiveList
/*Archive list fetch and store in databas.
 
 extView : articles
 extTask : archive
 extName : icms
 Taskdatadict : Dictionary of Post Variables.
 */
+(NSDictionary *)iCMSArchiveList:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

+(void)iCMSArchiveListdatastore :(NSString *) json ExtTask:(NSString *) extTask;

//iCMSFeaturedList
/*Featured list fetch and store in database.
 
 
 extView : articles
 extTask : featured
 extName : icms
 Taskdatadict : Dictionary of Post Variables.
 */
+(NSDictionary *)iCMSFeaturedList:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

+(void)iCMSFeaturedListdatastore :(NSString *) json ExtTask:(NSString *) extTask;

//iCMSArticalDetailviewList
/*
 Artical detail fetch and store in database.
 
 extView : articles
 extTask : articleDetail
 extName : icms
 Taskdatadict : Dictionary of Post Variables.
 */

+(NSDictionary *)iCMSArticalDetailviewList:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata articalid:(NSString *) articalid;

+(void)iCMSArticalDetailListdatastore :(NSString *) json ExtTask:(NSString *) extTask articalid:(NSString *) articalid;

//JsonstringRemoveChar
/*
 JSON string opration.
 
 json : JSONString
 
 */
+(NSString *)JsonstringRemoveChar:(NSString *)json;

//JsonstringAddChar
/*
 JSON string opration.
 
 json : JSONString
 
 */
+(NSString *)JsonstringAddChar:(NSString *)json;


//ClintTestURlPingResponce
/*
 Check clint URL.
 extView : viewName
 extTask : TaskName
 extName : icms
 Taskdatadict : Dictionary of Post Variables.
 
 */
+(NSDictionary *)ClintTestURlPingResponce :(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

//DropAllTable
/*
 DropAllTable
 
 */
+(BOOL) DropAllTabl;

@end
