//
//  ConfigData.h
//  iJoomer
//
//  Created by tailored on 3/22/13.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import"ApplicationData.h"
#import "Category.h"
#import "AllMenudetail.h"
#import "ApplicationMenuItem.h"

@interface ConfigData : NSObject
{
    sqlite3 *database;
}

-(void) insertCOnfigmenuData: (NSString *)menuid: (NSString *)menuposition: (NSString *)menuname: (NSMutableArray *)arrscreen: (NSMutableArray *)arrmenuitem;

+(void) moveDatabase;
+ (void) copyDatabaseIfNeeded;
+ (NSString *) getDBPath;
-(void) deleteData: (NSString *)sqlQuery;
-(void) insertData: (NSString *)sqlQuery;
-(void) updateData: (Category *)category;
-(NSMutableArray *) getData: (NSString *)sqlQuery;
-(NSMutableArray *) gettheme: (NSString *)sqlQuery;



-(void)CreateTable:(NSString *)Query;
-(int)CheckTableExist:(NSString *)tablename;
-(int) CheckDataExist: (NSString *)sqlQuery;
-(int)DropTable: (NSString *)tablename;
@end
