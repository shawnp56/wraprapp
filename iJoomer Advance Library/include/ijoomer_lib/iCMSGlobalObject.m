//
//  iCMSGlobalObject.m
//  iJoomer
//
//  Created by Tailored Solutions on 4/9/13.
//
//

#import "iCMSGlobalObject.h"
#import "iCMSCategory.h"
#import "iCMSArticle.h"


@implementation iCMSGlobalObject

+ (BOOL) iCMSCategoryList :(NSDictionary *) dict cmsCategory:(iCMSCategory *)category {
    
    if ([dict count] == 0 || [[dict allKeys] count] < 1) {
        return YES;
    }
    else {
        
        if ([[dict valueForKey:@"code"] intValue] == 200) {
            iCMSCategory *newCategory;
            iCMSArticle *newArticle;
            NSArray *categoryList = [dict objectForKey:@"categories"];
            if ([categoryList isKindOfClass:[NSArray class]]) {
                if ([categoryList count] > 0) {
                    for (int i = 0; i < [categoryList count]; i++) {
                        
                        newCategory = [[iCMSCategory alloc]init];
                        
                        //                tempUser.code = [[dict valueForKey:@"code"] intValue];
                        newCategory.category_id = [[[categoryList objectAtIndex:i] objectForKey:@"categoryid"] intValue];
                        newCategory.category_desc = [[categoryList objectAtIndex:i] objectForKey:@"description"];
                        newCategory.thumbURL = [[categoryList objectAtIndex:i] objectForKey:@"image"];
                        newCategory.parent_id = [[categoryList objectAtIndex:i] objectForKey:@"parent_id"];
                        newCategory.category_name = [[categoryList objectAtIndex:i] objectForKey:@"title"];
                        newCategory.totalArticles = [[[categoryList objectAtIndex:i] objectForKey:@"totalarticles"] intValue];
                        newCategory.totalCategories = [[[categoryList objectAtIndex:i] objectForKey:@"totalcategories"] intValue];
                        if (!category) {
                            [[iCMSApplicationData sharedInstance].iCMSCategoryList addObject:newCategory];
                        }
                        else {
                            [category.subCategories addObject:newCategory];
                        }
                        [newCategory release];
                    }
                }
            }
            [iCMSApplicationData sharedInstance].pageLimit = [[dict objectForKey:@"pageLimit"] intValue];
            [iCMSApplicationData sharedInstance].totalArticle = [[dict objectForKey:@"total"] intValue];
            NSArray *articleList = [dict objectForKey:@"articles"];
            if ([articleList isKindOfClass:[NSArray class]]) {
                if ([articleList count] > 0) {
                    for (int i = 0; i < [articleList count]; i++) {
                        
                        newArticle = [[iCMSArticle alloc]init];
                        newArticle.article_id = [[[articleList objectAtIndex:i] objectForKey:@"articleid"] intValue];
                        newArticle.author = [[articleList objectAtIndex:i] objectForKey:@"author"];
                        newArticle.article_title = [[articleList objectAtIndex:i] objectForKey:@"title"];
                        
                        newArticle.catid = [[[articleList objectAtIndex:i] objectForKey:@"catid"] intValue];
                        newArticle.created_date = [[articleList objectAtIndex:i] objectForKey:@"created"];
                        newArticle.created_by_id = [[[articleList objectAtIndex:i] objectForKey:@"created_by_id"] intValue];
                        newArticle.thumbURL = [[articleList objectAtIndex:i] objectForKey:@"image"];
                        newArticle.introtext = [[articleList objectAtIndex:i] objectForKey:@"introtext"];
                        newArticle.parent_title = [[articleList objectAtIndex:i] objectForKey:@"parent_title"];
                        newArticle.parent_id = [[[articleList objectAtIndex:i] objectForKey:@"parent_id"] intValue];
                        
                        newArticle.shareLink = [[articleList objectAtIndex:i] objectForKey:@"shareLink"];
                        [category.articles addObject:newArticle];
                        
                        [newArticle release];
                    }
                }
            }
        }
        else{
            
            [iCMSApplicationData sharedInstance].errorCode = [[dict valueForKey:@"code"]intValue];
            return NO;
        }
    }
    return YES;
}

+(BOOL)iCMSFeaturedArticleList:(NSDictionary *)dict {
    
    NSArray *articleList = [dict objectForKey:@"articles"];

    if ([articleList isKindOfClass:[NSArray class]]) {
        if ([articleList count] > 0) {
            for (int i = 0; i < [articleList count]; i++) {
                
                iCMSArticle *newArticle = [[iCMSArticle alloc]init];
                newArticle.article_id = [[[articleList objectAtIndex:i] objectForKey:@"articleid"] intValue];
                newArticle.author = [[articleList objectAtIndex:i] objectForKey:@"author"];
                newArticle.article_title = [[articleList objectAtIndex:i] objectForKey:@"title"];
                
                newArticle.catid = [[[articleList objectAtIndex:i] objectForKey:@"catid"] intValue];
                newArticle.created_date = [[articleList objectAtIndex:i] objectForKey:@"created"];
                newArticle.created_by_id = [[[articleList objectAtIndex:i] objectForKey:@"created_by_id"] intValue];
                newArticle.thumbURL = [[articleList objectAtIndex:i] objectForKey:@"image"];
                newArticle.introtext = [[articleList objectAtIndex:i] objectForKey:@"introtext"];
                newArticle.parent_title = [[articleList objectAtIndex:i] objectForKey:@"parent_title"];
                newArticle.parent_id = [[[articleList objectAtIndex:i] objectForKey:@"parent_id"] intValue];
                
                newArticle.shareLink = [[articleList objectAtIndex:i] objectForKey:@"shareLink"];
                
                [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList addObject:newArticle];
                [newArticle release];
            }
            
        }
        return NO;
    }
    return YES;
}

+(BOOL)iCMSArchivedArticleList:(NSDictionary *)dict {
    
    NSArray *articleList = [dict objectForKey:@"articles"];

    if ([articleList isKindOfClass:[NSArray class]]) {
        if ([articleList count] > 0) {
            for (int i = 0; i < [articleList count]; i++) {
                
                iCMSArticle *newArticle = [[iCMSArticle alloc]init];
                newArticle.article_id = [[[articleList objectAtIndex:i] objectForKey:@"articleid"] intValue];
                newArticle.author = [[articleList objectAtIndex:i] objectForKey:@"author"];
                newArticle.article_title = [[articleList objectAtIndex:i] objectForKey:@"title"];
                
                newArticle.catid = [[[articleList objectAtIndex:i] objectForKey:@"catid"] intValue];
                newArticle.created_date = [[articleList objectAtIndex:i] objectForKey:@"created"];
                newArticle.created_by_id = [[[articleList objectAtIndex:i] objectForKey:@"created_by_id"] intValue];
                newArticle.thumbURL = [[articleList objectAtIndex:i] objectForKey:@"image"];
                newArticle.introtext = [[articleList objectAtIndex:i] objectForKey:@"introtext"];
                newArticle.parent_title = [[articleList objectAtIndex:i] objectForKey:@"parent_title"];
                newArticle.parent_id = [[[articleList objectAtIndex:i] objectForKey:@"parent_id"] intValue];
                
                newArticle.shareLink = [[articleList objectAtIndex:i] objectForKey:@"shareLink"];
                
                [[iCMSApplicationData sharedInstance].iCMSArchivedArticleList addObject:newArticle];
                [newArticle release];
            }
        }
        return NO;
    }
    return YES;
}

+(BOOL)iCMSArticleDetail:(NSDictionary *)dict Article : (iCMSArticle *) articleDetail {
    if (![dict count] == 0) {
        
        if ([[dict valueForKey:@"code"] intValue] == 200) {
            
            NSDictionary *dictionary = [dict objectForKey:@"article"];
            [iCMSApplicationData sharedInstance].errorCode = [[dict valueForKey:@"code"] intValue];
            articleDetail.alias = [dictionary objectForKey:@"alias"];
            articleDetail.article_desc = [self HTMLStringAddChar:[dictionary objectForKey:@"fulltext"]];
            articleDetail.category_title = [dictionary objectForKey:@"category_title"];
            articleDetail.created_date = [dictionary objectForKey:@"created"];
            articleDetail.author = [dictionary objectForKey:@"author"];
            articleDetail.category_alias = [dictionary objectForKey:@"category_alias"];
            articleDetail.image_fulltext = [dictionary objectForKey:@"image_fulltext"];
            articleDetail.created_by_alias = [dictionary objectForKey:@"created_by_alias"];
            articleDetail.publish_down = [dictionary objectForKey:@"publish_down"];
            articleDetail.publish_up = [dictionary objectForKey:@"publish_up"];
            articleDetail.parent_title = [dictionary objectForKey:@"parent_title"];
            articleDetail.parent_id = [[dictionary objectForKey:@"parent_id"] intValue];
            articleDetail.article_title = [dictionary objectForKey:@"title"];
            articleDetail.shareLink = [dictionary objectForKey:@"shareLink"];
            
            return YES;
        }
        else
        {
            [iCMSApplicationData sharedInstance].errorCode = [[dict valueForKey:@"code"]intValue];
        }
    }
    return NO;
}

//string replace double quets with singal.
+(NSString *)HTMLStringRemoveChar:(NSString *)json
{
    NSString *strtmp1 = [json stringByReplacingOccurrencesOfString: @"\"" withString:@"~**~"];
    return strtmp1;
}

//string replace singal quets with double.
+(NSString *)HTMLStringAddChar:(NSString *)json
{
    NSString *strtmp1 = [json stringByReplacingOccurrencesOfString:@"~**~" withString:@"\""];
    return strtmp1;
}

@end
