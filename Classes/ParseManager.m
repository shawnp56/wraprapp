//
//  ParseManager.m
//  iJoomer
//
//  Created by Ankit on 13/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ParseManager.h"
//#import "XMLManualParser.h"
#import "ApplicationData.h"
#import "User.h"
#import "iJoomerAppDelegate.h"

@implementation ParseManager

+(bool)parseFacebookResponse:(NSDictionary *)dict {
    
    /* [{"uid":100002375179569,"name":"Ankit Dhimmar","pic":"http:\/\/m.ak.fbcdn.net\/profile.ak\/hprofile-ak-snc4\/186209_100002375179569_1655722_s.jpg","email":"ankit.d\u0040tasolglobal.com"}] */
    ApplicationData *appdata = [ApplicationData sharedInstance];
    if (!appdata.userDetail) {
        appdata.userDetail = [[User alloc] init];
    }
    appdata.userDetail.facebookId = [NSString stringWithFormat:@"%@", [dict valueForKey:@"uid"]];
    if(appdata.userDetail.facebookId.length > 0) {
        appdata.userDetail.email = [dict valueForKey:@"email"];
        appdata.userDetail.passwordtoken = [NSString stringWithFormat:@"%@", [dict valueForKey:@"uid"]];
        appdata.userDetail.userName = [dict valueForKey:@"name"];
        appdata.userDetail.avatarURL = [dict valueForKey:@"pic"];
        //appdata.userDetail.fbuserName = [dict valueForKey:@"username"];
    }
    
    return NO;
}
@end
