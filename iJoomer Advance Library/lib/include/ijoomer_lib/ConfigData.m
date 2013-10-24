//
//  ConfigData.m
//  iJoomer
//
//  Created by tailored on 3/22/13.
//
//

#import "ConfigData.h"
#import "AllMenudetail.h"
#import "ApplicationMenuItem.h"
#import "AppconfigThemedetail.h"
#import "JSONKit.h"
#import "GlobalObjects.h"

#define DB_NAME						@"JoomerLib_IOS2.0.sqlite"

@implementation ConfigData

-(NSMutableArray *) gettheme: (NSString *)sqlQuery
{
    NSMutableArray *productArray =[[NSMutableArray alloc] init];
	@try
    {
		
		NSFileManager *fileManager =[NSFileManager defaultManager];
		
		BOOL success;
		
        NSString * theDBPath = [ConfigData getDBPath];
		
		success = [fileManager fileExistsAtPath:theDBPath];
		if(!success) {
			DLog(@"failed to find the file");
		}
		if(!(sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK)) {
			DLog(@"Error opening database");
		}
        
        sqlQuery = [sqlQuery stringByReplacingOccurrencesOfString:@"#" withString:@"%"];
        const char *sql = [sqlQuery UTF8String];
		static sqlite3_stmt *statement;
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) !=SQLITE_OK)
        {
			
			DLog(@"failed to prepare statement");
		}
		
		while (sqlite3_step(statement)== SQLITE_ROW)
        {
			
            AppconfigThemedetail *apptheme = [[AppconfigThemedetail alloc] init];
            
            apptheme.viewname = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)];
            apptheme.tab_URL = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)];
            apptheme.tab_active_URL = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)];
            apptheme.icon_URL = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)];
            
            [[ApplicationData sharedInstance].arr_Themeglobal_List addObject:apptheme];
            
            
            [productArray addObject:apptheme];
		}
        sqlite3_finalize(statement);
	}
	@catch (NSException *e)
    {
		DLog(@"An Exception occured at %@", [e reason]);
	}
    
    sqlite3_close(database);
	return productArray;
}

-(NSMutableArray *) getData: (NSString *)sqlQuery
{
    NSMutableArray *productArray =[[NSMutableArray alloc] init];
	@try
    {
		
		NSFileManager *fileManager =[NSFileManager defaultManager];
		
		BOOL success;
		
        NSString * theDBPath = [ConfigData getDBPath];
		
		success = [fileManager fileExistsAtPath:theDBPath];
		if(!success)
		{
			DLog(@"failed to find the file");
		}
		if(!(sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK))
		{
			DLog(@"Error opening database");
		}
        
        sqlQuery = [sqlQuery stringByReplacingOccurrencesOfString:@"#" withString:@"%"];
        const char *sql = [sqlQuery UTF8String];
        
        
		static sqlite3_stmt *statement;
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) !=SQLITE_OK)
        {
			
			DLog(@"failed to prepare statement");
		}
		
        
        
		while (sqlite3_step(statement)== SQLITE_ROW)
        {
			
            NSMutableArray *arrColumns = [[NSMutableArray alloc] init];
            for (int i=0; i<sqlite3_column_count(statement); i++)
            {
                const char *st = sqlite3_column_name(statement,i);
                [arrColumns addObject:[NSString stringWithCString:st encoding:NSUTF8StringEncoding]];
            }
            
            AllMenudetail *allmenude = [[AllMenudetail alloc] init];
            
            allmenude.menuid = sqlite3_column_int(statement, 0);
            allmenude.menuposition = sqlite3_column_int(statement, 1);
            allmenude.menuname = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)];
            NSString* dictscreen = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)];
            NSDictionary *resultsscreen = [dictscreen objectFromJSONString];
            
            allmenude.arrMenuscreens = [resultsscreen objectForKey:@"screens"];
           
            NSString* dictmenuitem = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 4)];
            NSDictionary *resultsmenuitem = [dictmenuitem objectFromJSONString];
            
            allmenude.arrmenuitem = [resultsmenuitem objectForKey:@"menuitem"];

            [productArray addObject:allmenude];
		}
        sqlite3_finalize(statement);
	}
	@catch (NSException *e)
    {
		DLog(@"An Exception occured at %@", [e reason]);
	}
    sqlite3_close(database);
	return productArray;
}

-(void) insertCOnfigmenuData: (NSString *)menuid: (NSString *)menuposition: (NSString *)menuname: (NSMutableArray *)arrscreen: (NSMutableArray *)arrmenuitem
{
    [ConfigData moveDatabase];
    NSString *databasePath = [ConfigData getDBPath];
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        const char *sqlStatement = "INSERT INTO Menus (menuid, menuposition, menuname, screens, menuitem) VALUES (?, ?, ?, ?, ?);";
        sqlite3_stmt *insert_statement = nil;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &insert_statement, NULL) == SQLITE_OK)
        {
           
            sqlite3_bind_int(insert_statement, 0, [menuid intValue]);
            sqlite3_bind_int(insert_statement, 1, [menuposition intValue]);
            sqlite3_bind_text(insert_statement, 2, [menuname UTF8String], -1, SQLITE_TRANSIENT);
            
            NSData *dataFromArrscreen = [[NSData alloc] init];
            dataFromArrscreen = [NSKeyedArchiver archivedDataWithRootObject:arrscreen];
            sqlite3_bind_blob(insert_statement, 3, [dataFromArrscreen bytes], [dataFromArrscreen length], SQLITE_TRANSIENT);
            
            NSData *dataFromArrmenuitem = [[NSData alloc] init];
            dataFromArrmenuitem = [NSKeyedArchiver archivedDataWithRootObject:arrmenuitem];
            sqlite3_bind_blob(insert_statement, 4, [dataFromArrmenuitem bytes], [dataFromArrmenuitem length], SQLITE_TRANSIENT);
            
            if(sqlite3_step(insert_statement) == SQLITE_DONE)
            {
                DLog(@"DATABASE: Adding: Success");
            }
            else
            {
                DLog(@"DATABASE: Adding: Failed");
            }
        }
        else
        {
            DLog(@"Error. Could not add Waypoint.");
        }
        sqlite3_finalize(insert_statement);
    }
    sqlite3_close(database);
}

-(void) insertData: (NSString *)sqlQuery
{
    
    NSString *databasePath = [ConfigData getDBPath];
    
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
        else
            DLog(@"Error. Could not add Waypoint.");
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(database);
}

-(void) deleteData : (NSString *)sqlQuery
{
	
    NSString *path = [ConfigData getDBPath];
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


-(void) updateData: (Category *)category
{
    
	sqlite3_stmt *updateStmt = nil;
	if(updateStmt == nil) {
        //const char *sql = "delete from Cart where product_id = ?";
		const char *sql = "update favourite set quantity = ? where id = ?";
        if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while  update statement. '%s'", sqlite3_errmsg(database));
    
        sqlite3_bind_int(updateStmt, 1, category.itemId);
	}
	if (SQLITE_DONE != sqlite3_step(updateStmt))
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	
	sqlite3_reset(updateStmt);
}

+ (void) copyDatabaseIfNeeded
{
    
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [ConfigData getDBPath];
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
    DLog(@"DB Moved");
    if (!success)
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

-(void)CreateTable :(NSString *)compname tablename:(NSString *)tablename datadict:(NSDictionary *)datadict
{
    
    NSString *databasePath = [ConfigData getDBPath];
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        NSArray *arrallkey = [datadict allKeys];
        
        for (int i = 0; i < [arrallkey count]; i++)
        {
            
            if ([[datadict objectForKey:[arrallkey objectAtIndex:i]] isKindOfClass:[NSArray class]])
            {
                DLog(@"nsarray : %@",[datadict objectForKey:[arrallkey objectAtIndex:i]]);
            }
            else if ([[datadict objectForKey:[arrallkey objectAtIndex:i]] isKindOfClass:[NSDictionary class]])
            {
            
                DLog(@"nsdictionary : %@",[datadict objectForKey:[arrallkey objectAtIndex:i]]);
            }
            else
            {
                // do somthing
                DLog(@"string : %@",[datadict objectForKey:[arrallkey objectAtIndex:i]]);
            }
        }
    }
    sqlite3_close(database);
}



-(int) CheckDataExist: (NSString *)sqlQuery
{
    int rows = 0;
    @try
    {
		NSFileManager *fileManager =[NSFileManager defaultManager];
		
		BOOL success;
		
        NSString * theDBPath = [ConfigData getDBPath];
		
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
                //                rows = sqlite3_column_int(statement, 0);
                DLog(@"SQLite Rows: %i", rows);
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

-(void)CreateTable:(NSString *)Query
{
    NSString *databasePath = [ConfigData getDBPath];
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
		
        NSString * theDBPath = [ConfigData getDBPath];
		
		success = [fileManager fileExistsAtPath:theDBPath];
		if(!success)
		{
			DLog(@"failed to find the file");
		}
		if(!(sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK))
		{
			DLog(@"Error opening database");
		}
        
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

-(int)DropTable: (NSString *)tablename
{
    int flag = 1;
    
    @try
    {
		
		NSFileManager *fileManager =[NSFileManager defaultManager];
		
		BOOL success;
		
        NSString * theDBPath = [ConfigData getDBPath];
		
		success = [fileManager fileExistsAtPath:theDBPath];
		if(!success)
		{
			DLog(@"failed to find the file");
		}
		if(!(sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK))
		{
			DLog(@"Error opening database");
		}
        
        const char *sql = [[NSString stringWithFormat:@"drop table if exists '%@'",tablename] UTF8String];
        
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
    return flag;
}

@end
