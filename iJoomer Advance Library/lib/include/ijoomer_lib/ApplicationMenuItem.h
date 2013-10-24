//
//  ApplicationMenuItem.h
//  iJoomer
//
//  Created by tailored on 3/21/13.
//
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"
@interface ApplicationMenuItem : NSObject <IconRecord>

@property(assign)int itemid;
@property(assign)int itemdata_id;
@property (nonatomic, retain)NSString *str_itemcaption;
@property (nonatomic, retain)NSString *str_itemview;
@property (nonatomic, retain)NSDictionary *dict_itemdata;

@property (nonatomic, retain)NSString *viewname;//theme view name
//menu theme icon image.
@property(nonatomic,retain) UIImage *thumb_icon;
@property(nonatomic,retain) NSString *icon_URL;
//menu theme default tab image
@property(nonatomic,retain) UIImage *thumb_tab;
@property(nonatomic,retain) NSString *tab_URL;
//menu theme active tab image.
@property(nonatomic,retain) UIImage *thumb_tab_active;
@property(nonatomic,retain) NSString *tab_active_URL;


@property(nonatomic,retain) NSString *iconpath;
@property(nonatomic,retain) NSString *tabpath;
@property(nonatomic,retain) NSString *tabActpath;

@end
