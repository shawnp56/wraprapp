//
//  videocategories.h
//  iJoomer
//
//  Created by tailored on 3/20/13.
//
//

#import <Foundation/Foundation.h>

@interface videocategories : NSObject
{
    NSMutableArray *arrvideos_categories;
    int code;
    int count;
    NSString *strdesc;
    int Id;
    NSString *strname;
}
@property (nonatomic, retain)NSMutableArray *arrvideos_categories;
@property(assign)int code;
@property(assign)int Id;
@property(assign)int count;
@property (nonatomic, retain)NSString *strname;
@property (nonatomic, retain)NSString *strdesc;
@end
