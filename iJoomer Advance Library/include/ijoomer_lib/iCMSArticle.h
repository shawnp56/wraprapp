//
//  iCMSArticle.h
//  iJoomer
//
//  Created by Tailored Solutions on 3/20/13.
//
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"

@interface iCMSArticle : NSObject <IconRecord> {
    
    int article_id;
    int catid;
    int created_by_id;
    int parent_id;
    
    NSString *article_title;
    NSString *author;
    NSString *article_desc;
    NSString *introtext;
    NSString *created_date;
    NSString *shareLink;
    NSString *parent_title;
    NSString *publish_down;
    NSString *publish_up;
    
    NSString *alias;
    NSString *category_alias;
    NSString *category_title;
    NSString *created_by_alias;
    
    NSString *thumbURL;
    UIImage *thumbImg;
    
    NSString *image_fulltext;
    UIImage *full_img;
    
    BOOL isDownloaded;

}

@property BOOL isDownloaded;

@property (nonatomic,assign) int article_id;
@property (nonatomic,assign) int catid;
@property (nonatomic,assign) int created_by_id;
@property (nonatomic,assign) int parent_id;

@property (nonatomic,retain) NSString *article_title;
@property (nonatomic,retain) NSString *author;
@property (nonatomic,retain) NSString *article_desc;
@property (nonatomic,retain) NSString *introtext;
@property (nonatomic,retain) NSString *created_date;
@property (nonatomic,retain) NSString *shareLink;
@property (nonatomic,retain) NSString *parent_title;
@property (nonatomic,retain) NSString *alias;
@property (nonatomic,retain) NSString *category_alias;
@property (nonatomic,retain) NSString *category_title;
@property (nonatomic,retain) NSString *created_by_alias;
@property (nonatomic,retain) NSString *publish_down;
@property (nonatomic,retain) NSString *publish_up;


@property (nonatomic,retain) NSString *thumbURL;
@property (nonatomic,retain) UIImage *thumbImg;
@property (nonatomic,retain) NSString *image_fulltext;
@property (nonatomic,retain) UIImage *full_img;


@end
