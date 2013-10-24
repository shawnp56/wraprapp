//
//  JSON_macros.h
//  ijoomer_lib
//
//  Created by tailored on 10/12/12.
//  Copyright (c) 2013 tailored. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>


////////////////////////////  JSON URLs //////////////////////////////
//********************************* Main JSON  ***************************************

//main json.
//#define JSON_MAIN           @"reqObject={\"task\":\"%@\",\"taskData\":{%@}}"
#define JSON_MAIN           @"{\"task\":\"%@\",\"taskData\":{%@}}"
#define JSON_MAIN2           @"{\"task\":\"%@\",\"taskData\":%@}"


//main1 json.
//#define JSON_MAIN1           @"reqObject={\"extName\":\"%@\",\"extView\":\"%@\",\"extTask\":\"%@\",\"taskData\":{%@}}"
#define JSON_MAIN1           @"{\"extName\":\"%@\",\"extView\":\"%@\",\"extTask\":\"%@\",\"taskData\":{%@}}"

//************************************************************************

//##################################### Sub JSON ###############################################

//config.
#define JSON_CONFIG         @"\"device\":\"%@\",\"type\":\"%d\""

//Login.
#define JSON_LOGIN          @"\"username\":\"%@\",\"password\":\"%@\",\"devicetoken\":\"%@\",\"lat\":\"%f\",\"long\":\"%f\""

//Logout.
#define JSON_LOGOUT         @"\"userid\":\"%d\""

//FBLogin.
#define JSON_FBLOGIN        @"\"name\":\"%@\",\"username\":\"%@\",\"password\":\"%@\",\"email\":\"%@\",\"lat\":\"%f\",\"long\":\"%f\",\"bigpic\":\"%@\",\"devicetoken\":\"%@\",\"regopt\":\"%d\", \"fbid\":\"%@\""

//Registration.
#define JSON_REGISTER       @"\"name\":\"%@\",\"username\":\"%@\",\"password\":\"%@\",\"email\":\"%@\",\"full\":\"%d\",\"type\":\"%@\""

//password steps JSON.**************************************************
#define JSON_PASSWord_step1         @"\"step\":\"%d\",\"email\":\"%@\""

#define JSON_PASSWord_step2         @"\"step\":\"%d\",\"username\":\"%@\",\"token\":\"%@\""

#define JSON_PASSWord_step3         @"\"step\":\"%d\",\"crypt\":\"%@\",\"userid\":\"%d\",\"password\":\"%@\""
//password steps JSON end.**********************************************

//Username.
#define JSON_Username         @"\"email\":\"%@\""

//user detail.
#define JSON_Userdetail         @"\"sessionID\":\"%@\",\"userID\":\"%d\""

//all member list.
#define JSON_memberlist         @"\"sessionID\":\"%@\",\"pageNO\":\"%d\""

//add friends.
#define JSON_Addfriends         @"\"sessionID\":\"%@\",\"memberid\":\"%d\",\"message\":\"%@\""

//notification.
#define JSON_Notification       @"\"sessionID\":\"%@\""

//request accept and reject.
#define JSON_Accept_Request     @"\"sessionID\":\"%@\",\"connectionID\":\"%d\""

//notification member profile.
#define JSON_Notification_member_profile     @"\"sessionID\":\"%@\",\"friendID\":\"%d\",\"connectionID\":\"%d\""

//member search.
#define JSON_Member_Search     @"\"sessionID\":\"%@\",\"query\":\"%@\",\"pageNO\":\"%d\""

//Update profile.
#define JSON_Update_Profile     @"\"sessionID\":\"%@\",\"name\":\"%@\",\"status\":\"%@\""

//online users data.
#define JSON_Who_isOnline     @"\"sessionID\":\"%@\""

//activities.
#define JSON_activities      @"\"sessionID\":\"%@\",\"pageNO\":\"%d\""

//////////////////////////////////////////////////////////////////////

//##############################################################################################

@interface JSON_macros : NSObject <CLLocationManagerDelegate>{
    
}

//Login.
+ (NSString *) Login:(NSString *) username userpassword :(NSString *) password userdeviceid : (NSString *)devicetoken;

//FBLogin
+ (NSString *) FBLogin:(NSString *) name Username :(NSString *) username userpassword :(NSString *) password Useremail :(NSString *)emailid userbig_pic_url :(NSString *)big_pic_url userdeviceid : (NSString *)devicetoken registration_opt :(int)reg_opt FBID :(NSString *)fbid;

//Logout.
+ (NSString *) Logout:(int)userid;

//registration stap 1.
+ (NSString *) Registration:(NSString *)name Username :(NSString *) username userpassword :(NSString *) password Useremail :(NSString *) emailid Nextform :(int) full Profile_type :(NSString *) type;

//registration stap 2 Full.
+ (NSString *) RegistrationFull:(NSString *)datastring;

//Configration
+ (NSString *) configration :(NSString *) device Model_number:(int)model_no;

//password retrive start.
+ (NSString *) password_1 :(int) step Email_id :(NSString *)email;

+ (NSString *) password_2 :(int) step Username :(NSString *)username Token :(NSString *)token;

+ (NSString *) password_3 :(int) step Crypt :(NSString *)crypt User_id :(int)userid Password :(NSString *)password;
//password retrive end.

//username retrive.
+(NSString *) Username:(NSString *)email_id;

//Userdetail.
+(NSString *) Userdetail :(NSString *) extname Extview :(NSString *)extview Exttask :(NSString *)exttask Sessionid :(NSString *)sessionid Userid :(int)userid;

//all member list.
+(NSString *) Memberlist :(NSString *) extname Extview :(NSString *)extview Exttask :(NSString *)exttask Sessionid :(NSString *)sessionid Pageno :(int)pageno;

//Add friends.
+(NSString *) Addfriends :(NSString *) extname Extview :(NSString *)extview Exttask :(NSString *)exttask Sessionid :(NSString *)sessionid Memberid :(int)memberid Message :(NSString *)message;

//notification.
+(NSString *) Notification :(NSString *) extname Extview :(NSString *)extview Exttask :(NSString *)exttask Sessionid :(NSString *)sessionid;

//request accept and reject.
+(NSString *) Request_Accept :(NSString *) extname Extview :(NSString *)extview Exttask :(NSString *)exttask Sessionid :(NSString *)sessionid Connectionid :(int)connectionid;

//notification member profile.
+(NSString *) Notification_member_profile :(NSString *) extname Extview :(NSString *)extview Exttask :(NSString *)exttask Sessionid :(NSString *)sessionid FriendID :(int)friendID Connectionid :(int)connectionid;

//member search.
+(NSString *) MemberSearch :(NSString *) extname Extview :(NSString *)extview Exttask :(NSString *)exttask Sessionid :(NSString *)sessionid Query :(NSString *)query PageNO :(int)pageNO;

//Update profile.
+(NSString *) Update_Profile :(NSString *) extname Extview :(NSString *)extview Exttask :(NSString *)exttask Sessionid :(NSString *)sessionid Name :(NSString *)name Status :(NSString *)status;

//online users data.
+(NSString *) Who_isOnlinedata :(NSString *) extname Extview :(NSString *)extview Exttask :(NSString *)exttask Sessionid :(NSString *)sessionid;

//activities.
+(NSString *) Activities :(NSString *) extname Extview :(NSString *)extview Exttask :(NSString *)exttask Sessionid :(NSString *)sessionid PageNO :(int)pageNO;

@end
