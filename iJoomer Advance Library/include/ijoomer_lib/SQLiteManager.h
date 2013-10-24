//
//  SQLiteManager.h
//  Elance
//
//  Created by Mac HDD on 7/27/09.
//  Copyright 2009 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@protocol SQLiteManagerDelegate;


@interface SQLiteManager : NSObject {
	id<SQLiteManagerDelegate> delegate;
	sqlite3 *database;
	NSString *dbName;
}

@property(nonatomic, assign) id<SQLiteManagerDelegate> delegate;

- (id)initDatabase:(NSString *)databaseName;
- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)openDatabase;
- (void)readDatabase;
- (void)readByQuery:(char *)sqlQuery;
- (bool)insertData;
- (bool)deleteData;
- (bool)updateData;

@end

@protocol SQLiteManagerDelegate

-(void)readRecords:(sqlite3_stmt *)statement;
-(char *)getSelectQuery;
-(bool)insertRecords:(sqlite3 *)database;
-(bool)updateRecords:(sqlite3 *)database;
-(bool)deleteRecord:(sqlite3 *)database;
//-(NSArray *) fetchmenuitem:(char *)sqlQuery;
@end
