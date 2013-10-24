//
//  iCMSGlobalObject.h
//  iJoomer
//
//  Created by Tailored Solutions on 4/9/13.
//
//

/*
 
  This class use for global function which are use in user interface view and data simplification.
 */

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonCryptor.h>
#import <sqlite3.h>
#import "iCMSCategory.h"
#import "iCMSArticle.h"
#import "iCMSApplicationData.h"

@interface iCMSGlobalObject : NSObject

/*
 Global Function for Simplify data of ICMS All Category List dictionary.
 
 This Function is use for Simplify data of ICMS All Category List.
 
 parameters detail.
 
 (NSDictionary  dict) This parameter use for pass response dictionary.
 
 (iCMSCategory category) This parameter use for pass Object to simplify articleDetail
 
 Return Type Detail.
 
 (BOOL Type) Return Yes after completion.
 */

+(BOOL) iCMSCategoryList :(NSDictionary *) dict cmsCategory:(iCMSCategory *)category;

/*
 Global Function for Simplify data of ICMS Featured Article List dictionary.
 
 This Function is use for Simplify data of ICMS Featured Article List.
 
 parameters detail.
 
 (NSDictionary  dict) This parameter use for pass response dictionary.
 
 Return Type Detail.
 
 (BOOL Type) Return Yes after completion.
 */
+(BOOL)iCMSFeaturedArticleList:(NSDictionary *)dict;

/*
 Global Function for Simplify data of ICMS Archived Article List dictionary.
 
 This Function is use for Simplify data of ICMS Article Article List.
 
 parameters detail.
 
 (NSDictionary  dict) This parameter use for pass response dictionary.
 
 Return Type Detail.
 
 (BOOL Type) Return Yes after completion.
 */
+(BOOL)iCMSArchivedArticleList:(NSDictionary *)dict;

/*
 Global Function for Simplify data of ICMS Archived Article List dictionary.
 
 This Function is use for Simplify data of ICMS Article Article List.
 
 parameters detail.
 
 (NSDictionary  dict) This parameter use for pass response dictionary.
 
 (iCMSArticle articleDetail) This parameter use for pass Object to simplify data
 
 Return Type Detail.
 
 (BOOL Type) Return Yes after completion.
 */
+(BOOL)iCMSArticleDetail:(NSDictionary *)dict Article : (iCMSArticle *) articleDetail;

/*
 This Function is use for replace @"\"" character to  @"~**~" character
 
 parameters detail.
 
 (NSString JSON)This parameter use for pass string which are have special character.
 
 Return Type Detail.
 (NSString Type) Return string
 */
+(NSString *)HTMLStringRemoveChar:(NSString *)json;

/*
 This Function is use for replace @"~**~" character to  @"\"" character
 
 parameters detail.
 
 (NSString JSON)This parameter use for pass string which are have special character.
 
 Return Type Detail.
 (NSString Type) Return string
 */
+(NSString *)HTMLStringAddChar:(NSString *)json;

@end
