//
//  Application_config.h
//  iJoomer
//
//  Created by tailored on 3/18/13.
//
//

#import <Foundation/Foundation.h>
#import "IconDownloader.h"

@interface Application_config : NSObject<IconRecord>
{
    
}
@property (nonatomic, retain) NSString *thumbURL;
@property (nonatomic, retain) UIImage *thumbImg;
@property (nonatomic, retain) NSString *user_thumURL;
@property (nonatomic, retain) NSString *Tabicon_thumURL;
@property (nonatomic, retain) UIImage *userIcon;
@property (nonatomic, retain) UIImage *TabIcon;
@property (nonatomic, retain) NSMutableArray *arrtheme;
@property (nonatomic, retain) NSMutableArray *arrmenu;
@end
