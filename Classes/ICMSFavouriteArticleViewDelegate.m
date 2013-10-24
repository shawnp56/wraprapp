//
//  FavouriteSongViewDelegate.m
//  Braille1
//
//  Created by Tailored Solutions on 03/12/12.
//  Copyright (c) 2013 Tailored Solutions. All rights reserved.
//

#import "ICMSFavouriteArticleViewDelegate.h"
#import "iCMSApplicationData.h"
#import "iCMSArticle.h"

char *sql_fav_article = "SELECT * FROM FavoriteArticleList";
char *deleteSql = "DELETE FROM FavoriteArticleList where article_id = ?";

@implementation ICMSFavouriteArticleViewDelegate

- (void)dealloc {
    [super dealloc];
}

- (void)readRecords:(sqlite3_stmt *)statement {
	
	iCMSArticle *record;
	
	while (sqlite3_step(statement) == SQLITE_ROW) {
		// The second parameter indicates the column index into the result set.
		
		record = [[iCMSArticle alloc] init];
		
		record.article_id = sqlite3_column_int(statement, 0);
		record.article_title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
        record.introtext = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
        record.thumbURL = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
        [[iCMSApplicationData sharedInstance].favoriteArticleList addObject:record];
	}
}

- (char *)getSelectQuery {
	return sql_fav_article;
}

- (bool)insertRecords:(sqlite3 *)database {
	const char *recordInsertQuery = "INSERT INTO FavoriteArticleList (article_id , article_title , intro_text , thumbUrl) values (?, ?, ?, ?)";
	
	static sqlite3_stmt *insert_statement;
	iCMSArticle *record = [iCMSApplicationData sharedInstance].article;
	bool isadded = FALSE;
	if(record)
	{
		if (insert_statement == nil) {
			if (sqlite3_prepare_v2(database, recordInsertQuery, -1, &insert_statement, NULL) != SQLITE_OK) {
				NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
				return isadded;
			}
		}
		
        sqlite3_bind_int(insert_statement, 1, record.article_id);
        sqlite3_bind_text(insert_statement, 2, [record.article_title UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insert_statement,3, [record.introtext UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insert_statement,4, [record.thumbURL UTF8String], -1, SQLITE_TRANSIENT);
        
		int success = sqlite3_step(insert_statement);
		if (success == SQLITE_ERROR) {
			//record.isStoredInDB = NO;
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
			return isadded;
		}
		
		if(success == SQLITE_DONE) {

			isadded = TRUE;
		}
		
		// Comment this line in device
		sqlite3_reset(insert_statement);
		
	}
	return isadded;
}

- (bool)updateRecords:(sqlite3 *)database {
//	const char *recordUpdateQuery = "UPDATE venues SET name = ?, category_id = ?, subcat_id = ?, budget = ?, review_count = ?, district_id = ?, latitude = ?, longitude = ?, avg_rate = ?, rating_count = ?, cuisine = ?, delivery = ?, time = ?, phoneNo = ?, webURL = ?,  imageURL = ?, thumbURL = ? where venue_id = ?";
//	
//	static sqlite3_stmt *update_statement;
//	Venue *record = nil; //appdata.newfavoritemall;
//	bool isadded = FALSE;
//	if(record)
//	{
//		if (update_statement == nil) {
//			if (sqlite3_prepare_v2(database, recordUpdateQuery, -1, &update_statement, NULL) != SQLITE_OK) {
//				//NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
//				return isadded;
//			}
//		}
//		
//		//DLog(@" Data Inserting: %d %@ %lf %lf",record.userId,record.userName,record.latitude,record.longitude);
//		
//		/*
//		 CREATE TABLE "venue" 
//		 ("venue_id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
//		 "name" VARCHAR(50), 
//		 "category_id" INTEGER, 
//		 "subcat_id" INTEGER, 
//		 "budget" VARCHAR(50), 
//		 "review_count" INTEGER, 
//		 "district_id" INTEGER, 
//		 "latitude" FLOAT, 
//		 "longitude" FLOAT, 
//		 "avg_rate" FLOAT, 
//		 "rating_count" INTEGER, 
//		 "cuisine" VARCHAR(50), 
//		 "delivery" INTEGER, 
//		 "time" VARCHAR(100), 
//		 "phoneNo" VARCHAR(50), 
//		 "webURL" VARCHAR(50))
//		 */
//		
//		sqlite3_bind_text(update_statement, 1, [record.name UTF8String], -1, SQLITE_TRANSIENT);
//		sqlite3_bind_int(update_statement, 2, record.category_id);
//		sqlite3_bind_int(update_statement, 3, record.subcat_id);
//		sqlite3_bind_text(update_statement, 4, [record.budget UTF8String], -1, SQLITE_TRANSIENT);
//		sqlite3_bind_int(update_statement, 5, record.review_count);
//		sqlite3_bind_int(update_statement, 6, record.district_id);
//		sqlite3_bind_double(update_statement, 7, record.latitude);
//		sqlite3_bind_double(update_statement, 8, record.longitude);
//		sqlite3_bind_double(update_statement, 9, record.avg_rate);
//		sqlite3_bind_int(update_statement, 10, record.ratingCount);
//		sqlite3_bind_text(update_statement, 11, [record.cuisine UTF8String], -1, SQLITE_TRANSIENT);
//		sqlite3_bind_text(update_statement, 12, [record.deliveryStatus UTF8String], -1, SQLITE_TRANSIENT);
//		//sqlite3_bind_int(update_statement, 12, (record.isDelivery) ? DeliveryOff:DeliveryOn);
//		sqlite3_bind_text(update_statement, 13, [record.time UTF8String], -1, SQLITE_TRANSIENT);
//		sqlite3_bind_text(update_statement, 14, [record.phoneNo UTF8String], -1, SQLITE_TRANSIENT);
//		sqlite3_bind_text(update_statement, 15, [record.webURL UTF8String], -1, SQLITE_TRANSIENT);
//		sqlite3_bind_text(update_statement, 16, [record.mainImageURL UTF8String], -1, SQLITE_TRANSIENT);
//		sqlite3_bind_int(update_statement, 17, record.venue_id);
//		sqlite3_bind_text(update_statement, 18, [record.thumbURL UTF8String], -1, SQLITE_TRANSIENT);
//        
//		int success = sqlite3_step(update_statement);
//		if (success == SQLITE_ERROR) {
//			//record.isStoredInDB = NO;
//			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
//			return isadded;
//		}
//		
//		if(success == SQLITE_DONE) {
//			//[appdata.favouriteMalls addObject:record];
//			isadded = TRUE;
//		}
//		
//		//DLog(@" Data Inserted: %d %@ %lf %lf",record.userId,record.userName,record.latitude,record.longitude);
//		
//		// Comment this line in device
//		sqlite3_reset(update_statement);
//		
//	}
//	return isadded;
    return NO;
}

- (bool)deleteRecord:(sqlite3 *)database {
	static sqlite3_stmt *deleteStmt;
	if(deleteStmt == nil) {
		if(sqlite3_prepare_v2(database, deleteSql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	//When binding parameters, index starts from 1 and not zero.
	sqlite3_bind_int(deleteStmt, 1,[[iCMSApplicationData sharedInstance].article article_id]);
    
	if (SQLITE_DONE != sqlite3_step(deleteStmt)) {
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	} 
	else {

		sqlite3_reset(deleteStmt);
		return YES;
	}
	
	sqlite3_reset(deleteStmt);
	return NO;
}

@end
