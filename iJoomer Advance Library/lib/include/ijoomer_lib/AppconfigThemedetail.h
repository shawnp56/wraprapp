//
//  AppconfigThemedetail.h
//  iJoomer
//
//  Created by tailored on 3/20/13.
//
//

#import <Foundation/Foundation.h>

@interface AppconfigThemedetail : NSObject


@property (nonatomic, retain)NSString *viewname;//theme view name
//menu theme icon image.
@property(nonatomic,retain) UIImage *thumb_icon;
@property(nonatomic,retain) NSString *icon_URL;
@property(nonatomic,retain) NSString *icon_imgpath;

//menu theme default tab image
@property(nonatomic,retain) UIImage *thumb_tab;
@property(nonatomic,retain) NSString *tab_URL;
@property(nonatomic,retain) NSString *tab_imgpath;

//menu theme active tab image.
@property(nonatomic,retain) UIImage *thumb_tab_active;
@property(nonatomic,retain) NSString *tab_active_URL;
@property(nonatomic,retain) NSString *tab_active_imgpath;

@end
