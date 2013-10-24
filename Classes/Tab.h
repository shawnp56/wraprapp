//
//  Tab.h
//  iJoomer
//
//  Created by Tailored Solutions on 19/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IconDownloader.h"

@interface Tab : NSObject<IconRecord>  {
    
    int itemid;
    int itemdata_id;
    NSString *title;
    NSString *classname;
    UIImage *tabimg;
    NSString *tabimgUrl;
    NSString *thumbURL;
	UIImage *thumbImg;
    
    UIImage *smallimg;
    NSString *smallimgUrl;
    
    BOOL *showicon;
    BOOL *showtab;
    
    NSString *tabimgpath;
    NSString *tabactiveimgpath;
    NSDictionary *dict_itemdata;
    
}
@property (nonatomic, retain)NSDictionary *dict_itemdata;

@property(assign)int itemid;
@property(assign)int itemdata_id;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain)NSString *classname;
@property (nonatomic,retain) UIImage *tabimg;
@property (nonatomic,retain) NSString *tabimgUrl;
@property (nonatomic,retain) NSString *thumbURL;
@property (nonatomic,retain) UIImage *thumbImg;
@property (nonatomic,retain) NSString *smallURL;
@property (nonatomic,retain) UIImage *smallImg;
@property (assign) BOOL *showicon;
@property (assign) BOOL *showtab;

@property (nonatomic,retain) NSString *tabimgpath;
@property (nonatomic,retain) NSString *tabactiveimgpath;



@end
