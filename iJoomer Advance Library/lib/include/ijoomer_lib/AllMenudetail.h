//
//  AllMenudetail.h
//  iJoomer
//
//  Created by tailored on 3/20/13.
//
//

#import <Foundation/Foundation.h>

@interface AllMenudetail : NSObject

@property(assign)int menuid;
@property(assign)int menuposition;
@property (nonatomic, retain)NSString *menuname;
@property (nonatomic, retain) NSMutableArray *arrMenuscreens;
@property (nonatomic, retain) NSMutableArray *arrmenuitem;

@end
