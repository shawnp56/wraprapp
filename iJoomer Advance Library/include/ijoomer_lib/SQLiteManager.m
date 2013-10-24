//
//  SQLiteManager.m
//  Elance
//
//  Created by Mac HDD on 7/27/09.
//  Copyright 2009 Tailored Solutions. All rights reserved.
//

#import "SQLiteManager.h"

#define DB_NAMEfave						@"JoomerLib_IOS2.0.sqlite"
@implementation SQLiteManager

@synthesize delegate; //, user_id, username, refName, email, location_id, sex, agegroup_id, weight_id;

- (id)initDatabase:(NSString *)databaseName{
	
	self = [super init];
	
	dbName = databaseName;
	
	[self createEditableCopyOfDatabaseIfNeeded];
	[self openDatabase];
	return self;
}

-(void)createEditableCopyOfDatabaseIfNeeded
{
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:dbName];
    
	success = [fileManager fileExistsAtPath:writableDBPath];
    
	if (success)
    {
		return;
	}
    
	// The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

- (void)openDatabase {
	// The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:dbName];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
    {
        // Get the primary key for all _scores.
		
	}
    else
    {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
		database = nil;
		DLog(@"DB Opening Error");
        // NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
}

- (void)readDatabase {
	if(database)
	{
		// Get the primary key for all _scores.
		const char *sql;
		if(delegate)
		{
			sql = [delegate getSelectQuery];
		}
		else
		{
			return;
		}
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.        
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
			[delegate readRecords:statement];
		}
		else
		{
			DLog(@"Error Opening Table");
		}
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
	}
}

- (void)readByQuery:(char *)sqlQuery {
	if(database)
	{
		// Get the primary key for all _scores.
		if(!delegate)
		{
			return;
		}
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.        
    
		if (sqlite3_prepare_v2(database, sqlQuery, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
			[delegate readRecords:statement];
		}
		else
		{
			DLog(@"Error Opening Table");
		}
      
		// "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
	}
}

-(NSArray *) fetchmenuitem:(char *)sqlQuery
{
    NSArray *arr = [[NSArray alloc] init];
    if(database)
	{
		// Get the primary key for all _scores.
		if(!delegate)
		{
			return  arr;
		}
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        
		if (sqlite3_prepare_v2(database, sqlQuery, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
			[delegate readRecords:statement];
		}
		else
		{
			DLog(@"Error Opening Table");
		}
        
		// "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
	}

    return arr;
}

- (bool)insertData {
	if(delegate)
	{
		return [delegate insertRecords:database];
	}
	return FALSE;
}

- (bool)updateData {
	if(delegate)
	{
		return [delegate updateRecords:database];
	}
	return FALSE;
}

- (bool)deleteData {
	if(delegate)
	{
		return [delegate deleteRecord:database];
	}
	return FALSE;
}

- (void)dealloc {
	sqlite3_close(database);
	database = nil;
	delegate = nil;
	[dbName release];	
	[super dealloc];
}

@end
