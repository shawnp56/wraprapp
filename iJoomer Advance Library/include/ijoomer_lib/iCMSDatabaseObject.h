//
//  iCMSDatabaseObject.h
//  iJoomer
//
//  Created by tailored on 4/10/13.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
//#import"ApplicationData.h"
//#import "Category.h"

@interface iCMSDatabaseObject : NSObject
{
    sqlite3 *database;
}

+(void) moveDatabase;
+ (void) copyDatabaseIfNeeded;
+ (NSString *) getDBPath;

-(void)CreateTable:(NSString *)Query;
-(int)CheckTableExist:(NSString *)tablename;
-(NSArray *) getiCMSData: (NSString *)sqlQuery;
-(int) CheckDataExist: (NSString *)sqlQuery;
-(void) insertData: (NSString *)sqlQuery;
-(void) deleteData: (NSString *)sqlQuery;

-(int)DropallTable;
-(int)DropTable: (NSMutableArray *)arrTableName;
@end
