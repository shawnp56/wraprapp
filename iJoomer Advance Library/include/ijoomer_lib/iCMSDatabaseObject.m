//
//  iCMSDatabaseObject.m
//  iJoomer
//
//  Created by tailored on 4/10/13.
//
//

#import "iCMSDatabaseObject.h"
#import "JSONKit.h"

#define DB_NAME						@"JoomerLib_IOS2.0.sqlite"
@implementation iCMSDatabaseObject

+ (void) copyDatabaseIfNeeded
{
    
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [iCMSDatabaseObject getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if(!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

+ (NSString *) getDBPath
{
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:DB_NAME];
}

+(void) moveDatabase
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"NewDB"]) {
        [fileManager removeItemAtPath:writableDBPath error:nil];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"NewDB"];
    }
    
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    if (success)
    {
        return;
    }
    
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success)
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

-(void)CreateTable:(NSString *)Query
{
    NSString *databasePath = [iCMSDatabaseObject getDBPath];
    const char *sqlStr = [Query UTF8String];
    static sqlite3_stmt *statement;
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, sqlStr, -1, &statement, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
        }
        
        sqlite3_exec(database, sqlStr, NULL, NULL, NULL);
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
}


-(int)CheckTableExist:(NSString *)tablename
{
    int flag = 0;
    @try
    {
		
		NSFileManager *fileManager =[NSFileManager defaultManager];
		
		BOOL success;
		
        NSString * theDBPath = [iCMSDatabaseObject getDBPath];
		
		success = [fileManager fileExistsAtPath:theDBPath];
		if(!success)
		{
			DLog(@"failed to find the file");
		}
		if(!(sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK))
		{
			DLog(@"Error opening database");
		}
        
       // const char *sql = [[NSString stringWithFormat:@"SELECT count(*) FROM sqlite_master WHERE type='table' AND name='%@'",tablename] UTF8String];
        const char *sql = [[NSString stringWithFormat:@"SELECT name FROM sqlite_master WHERE type='table' AND name='%@'",tablename] UTF8String];
        
		static sqlite3_stmt *statement;
        
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) !=SQLITE_OK)
        {
			DLog(@"failed to prepare statement");
		}
		
		if (sqlite3_step(statement) == SQLITE_ROW)
        {
            flag = 1;
        }
        sqlite3_finalize(statement);
	}
	@catch (NSException *e)
    {
		DLog(@"An Exception occured at %@", [e reason]);
	}
    sqlite3_close(database);
    return flag;
}

-(NSArray *) getiCMSData: (NSString *)sqlQuery
{
	
    NSMutableArray *productArr =[[NSMutableArray alloc] init];
	@try
    {
		NSFileManager *fileManager =[NSFileManager defaultManager];
		
		BOOL success;
		
        NSString * theDBPath = [iCMSDatabaseObject getDBPath];
		
		success = [fileManager fileExistsAtPath:theDBPath];
		if(!success)
		{
			DLog(@"failed to find the file");
		}
		if((sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK))
		{
            //sqlQuery = [sqlQuery stringByReplacingOccurrencesOfString:@"#" withString:@"%"];
            const char *sql = [sqlQuery UTF8String];
            
            static sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) !=SQLITE_OK)
            {
                
                DLog(@"failed to prepare statement");
            }
            else
            {
                int p = 0;
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSMutableDictionary *dictitem = [[NSMutableDictionary alloc] init];
                    NSString *strval = [[NSString alloc] init];
                    for (int i=0; i<sqlite3_column_count(statement); i++)
                    {
                        
                        const char *st1 = sqlite3_column_decltype(statement,i);
                        
                        const char *st = sqlite3_column_name(statement,i);
                        
                        NSString *keyname = [NSString stringWithCString:st encoding:NSUTF8StringEncoding];
                        
                        if ([[[NSString stringWithCString:st1 encoding:NSUTF8StringEncoding] lowercaseString]isEqualToString:@"text"])
                        {
                            strval = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, i)];
                            
                            strval = [strval stringByReplacingOccurrencesOfString: @"\\'" withString:@"\""];
                            
                            strval = [strval objectFromJSONString];
                        }
                        else
                        {
                            strval = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, i)];
                            strval = [strval stringByReplacingOccurrencesOfString: @"\\'" withString:@"\""];
                        }
                        [dictitem setObject:strval forKey:keyname];
                    }
                    [productArr addObject:dictitem];
                    p++;
                }
            }
            sqlite3_finalize(statement);
		}
    }
	@catch (NSException *e)
    {
		DLog(@"An Exception occured at %@", [e reason]);
	}
    sqlite3_close(database);
   // NSDictionary *dictreturn = [NSDictionary dictionaryWithDictionary:productdict];
	return productArr;
}

-(int) CheckDataExist: (NSString *)sqlQuery
{
    
    int rows = 0;
    @try
    {
		NSFileManager *fileManager =[NSFileManager defaultManager];
		
		BOOL success;
		
        NSString * theDBPath = [iCMSDatabaseObject getDBPath];
		
		success = [fileManager fileExistsAtPath:theDBPath];
		if(!success)
		{
			DLog(@"failed to find the file");
		}
		if((sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK))
		{
            
            const char *sql = [sqlQuery UTF8String];
            
            static sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    rows ++;
                }
            }
            else
            {
                 DLog(@"failed to prepare statement");
            }
            sqlite3_finalize(statement);
        }
    }
    @catch (NSException *e)
    {
		DLog(@"An Exception occured at %@", [e reason]);
	}
    sqlite3_close(database);
    return rows;
}

-(void) insertData: (NSString *)sqlQuery
{
    NSString *databasePath = [iCMSDatabaseObject getDBPath];
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        const char *sqlStatement = [sqlQuery UTF8String];
        
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(compiledStatement) == SQLITE_DONE)
                DLog(@"DATABASE: Adding: Success");
            else
                DLog(@"DATABASE: Adding: Failed");
        }
        else{
            DLog(@"Error. Could not add Waypoint.");
        }
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(database);
}

-(void) deleteData : (NSString *)sqlQuery
{
	
    NSString *path = [iCMSDatabaseObject getDBPath];
    if (sqlite3_open([path UTF8String], &database) != SQLITE_OK)
    {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
	sqlite3_stmt *deleteStmt = nil;
	if(deleteStmt == nil)
    {
        const char *sql = [sqlQuery UTF8String];
		
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while  delete statement. '%s'", sqlite3_errmsg(database));
	}
	if (SQLITE_DONE != sqlite3_step(deleteStmt))
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	
    sqlite3_finalize(deleteStmt);
    sqlite3_close(database);
}

-(int)DropallTable
{
    int flag = 0;
    NSMutableArray *arrTblName = [[NSMutableArray alloc] init];
    @try
    {
		
		NSFileManager *fileManager =[NSFileManager defaultManager];
		
		BOOL success;
		
        NSString * theDBPath = [iCMSDatabaseObject getDBPath];
		
		success = [fileManager fileExistsAtPath:theDBPath];
		if(!success)
		{
			DLog(@"failed to find the file");
		}
		if(!(sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK))
		{
			DLog(@"Error opening database");
		}
        
        // const char *sql = [[NSString stringWithFormat:@"SELECT count(*) FROM sqlite_master WHERE type='table' AND name='%@'",tablename] UTF8String];
        const char *sql = [[NSString stringWithFormat:@"SELECT name FROM sqlite_master WHERE type='table'"] UTF8String];
        
		static sqlite3_stmt *statement;
        
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) !=SQLITE_OK)
        {
			DLog(@"failed to prepare statement");
		}
		else
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *str = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)];
                [arrTblName addObject:str];
                
            }
        }
        
        sqlite3_finalize(statement);
	}
	@catch (NSException *e)
    {
		DLog(@"An Exception occured at %@", [e reason]);
	}
    sqlite3_close(database);
    int k = [self DropTable:arrTblName];
    DLog(@"%d",k);
    [arrTblName autorelease];
    return flag;
}

-(int)DropTable: (NSMutableArray *)arrTableName
{
    int flag = 1;
    for (int k = 0; k < [arrTableName count]; k++)
    {
        @try
        {
            
            NSFileManager *fileManager =[NSFileManager defaultManager];
            
            BOOL success;
            
            NSString *path = [iCMSDatabaseObject getDBPath];
            
            success = [fileManager fileExistsAtPath:path];
            if(!success)
            {
                DLog(@"failed to find the file");
            }
            if(!(sqlite3_open([path UTF8String], &database)== SQLITE_OK))
            {
                DLog(@"Error opening database");
            }
            
            const char *sql = [[NSString stringWithFormat:@"drop table '%@'",[arrTableName objectAtIndex:k]] UTF8String];
            
            static sqlite3_stmt *statement;
            
            char *errorMsg = NULL;
            
            if(sqlite3_exec(database, sql, NULL, NULL, &errorMsg) != SQLITE_OK) {
                DLog(@"Error DROP TABLE IF EXISTS rows: %s", errorMsg);
                sqlite3_free(errorMsg);
            }
            sqlite3_finalize(statement);
        }
        @catch (NSException *e)
        {
            DLog(@"An Exception occured at %@", [e reason]);
        }
        sqlite3_close(database);
    }
    return flag;
}

@end
