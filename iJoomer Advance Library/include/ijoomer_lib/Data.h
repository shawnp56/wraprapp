//
//  Data.h
//  iCMS
//
//  Created by Tailored Solutions on 04/04/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "User.h"


@interface Data : NSObject {

	sqlite3 *database;
    
}

+(void) moveDatabase;
- (BOOL) createDatabaseIfNotExist;
+(BOOL) CheckDatabaseExist;

@end
