//
//  iCMSCategory.h
//  iJoomer
//
//  Created by Tailored Solutions on 3/20/13.
//
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"

@interface iCMSCategory : NSObject <IconRecord> {
    
    int category_id;
    int hits;
    int totalArticles;
    int totalCategories;
    
    NSString *category_name;
    NSString *category_desc;
    NSString *parent_id;

    NSString *thumbURL;
    UIImage *thumbImg;

    NSMutableArray *articles;
    NSMutableArray *subCategories;
}

@property (nonatomic,assign) int category_id;
@property (nonatomic,assign) int totalArticles;
@property (nonatomic,assign) int hits;
@property (nonatomic,assign) int totalCategories;
@property (nonatomic,retain) NSString *category_name;
@property (nonatomic,retain) NSString *category_desc;
@property (nonatomic,retain) NSString *parent_id;
@property (nonatomic,retain) NSString *thumbURL;
@property (nonatomic,retain) UIImage *thumbImg;

@property (nonatomic,retain) NSMutableArray *articles;
@property (nonatomic,retain) NSMutableArray *subCategories;
@end
