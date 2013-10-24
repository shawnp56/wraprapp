//
//  GlobalObjects.m
//  ijoomer_lib
//
//  Created by tailored on 10/12/12.
//  Copyright (c) 2013 tailored. All rights reserved.
//

#import "GlobalObjects.h"
#import "JSONKit.h"
#import "Encrypt_Decrypt.h"
#import "JSON_macros.h"
#import "Category.h"
#import "iJoomerAppDelegate.h"
#import "UserInfo.h"
#import "Option.h"
#import "Wall.h"
#import "Data.h"
#import "Like.h"
#import "Image.h"
#import "ApplicationData.h"
#import "Comment.h"
#import "Category.h"
#import "Photo.h"
#import "videocategories.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Video.h"
#import "AppconfigThemedetail.h"
#import "AllMenudetail.h"
#import "ApplicationMenuItem.h"
#import "ConfigData.h"
#import "Messages.h"
#import "Announcement.h"
#import "Event.h"

@implementation GlobalObjects

//ProfileDetail.
+ (User *) ProfileDetail:(NSDictionary *) dict
{
    User *userobj = [[User alloc] init];
    if ([dict count] == 0 || [[dict allKeys] count] < 1) {
        
        userobj.code = 500;
        userobj.Error_msg = [dict valueForKey:@"Error message"];
    }
    else
    {
        
        if ([[dict valueForKey:@"code"] intValue] == 200) {
            
            [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
            [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
            [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
            iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
            if ([ApplicationData sharedInstance].frndCount > 0) {
                [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
                appDelegate.btnFriendCount.hidden = NO;
            }else {
                appDelegate.btnFriendCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].msgCount > 0) {
                [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
                appDelegate.btnMsgCount.hidden = NO;
            }else {
                appDelegate.btnMsgCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].groupCount > 0) {
                [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
                appDelegate.btnGroupCount.hidden = NO;
            }else {
                appDelegate.btnGroupCount.hidden = YES;
            }
            userobj.TotalFriends = [[dict valueForKey:@"totalfriends"] intValue];
            userobj.TotalGroup = [[dict valueForKey:@"totalgroup"] intValue];
            userobj.TotalPhotos = [[dict valueForKey:@"totalphotos"] intValue];
            userobj.viewCount = [[dict valueForKey:@"viewcount"] intValue];
            userobj.totalAlbum =  [[dict valueForKey:@"totalvideos"] intValue];
            DLog(@"friends:%d pics:%d album:%d",userobj.TotalFriends,userobj.TotalPhotos,userobj.totalAlbum);
            userobj.userName = [dict valueForKey:@"user_name"];
            userobj.userId = [[dict valueForKey:@"userid"] intValue];
            userobj.sessionid = [dict valueForKey:@"sessionid"];
            userobj.code = [[dict valueForKey:@"code"] intValue];
            userobj.avatarURL = [dict valueForKey:@"user_avatar"];
            userobj.coverpicURL = [dict valueForKey:@"coverpic"];
            userobj.viewCount = [[dict valueForKey:@"viewcount"] intValue];
            userobj.status = [dict valueForKey:@"user_status"];
            userobj.Liked = [[dict valueForKey:@"liked"] boolValue];
            userobj.Likes = [[dict valueForKey:@"likes"] intValue];
            userobj.isFriend = [[dict valueForKey:@"isfriend"] boolValue];
            userobj.Disliked = [[dict valueForKey:@"disliked"] boolValue];
            userobj.Dislikes = [[dict valueForKey:@"dislikes"] intValue];
            userobj.pending = [[dict valueForKey:@"isFriendReqTo"]boolValue];
          //  userobj.isLikeAllowed = [[dict valueForKey:@"isprofilelike"]boolValue];
            userobj.latitude = [[dict valueForKey:@"user_lat"] floatValue];
            userobj.longitude = [[dict valueForKey:@"user_long"] floatValue];
            userobj.profile_video = [dict valueForKey:@"profile_video"];
            
            //counts get
            [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
            [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
            [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
        }
        else{
            
            userobj.code = [[dict valueForKey:@"code"] intValue];
            userobj.Error_msg = [dict valueForKey:@"message"];
        }
    }
    [userobj autorelease];
    return userobj;
}

//registration stap 1.
+ (User *) Registration:(NSDictionary *) dict
{
    
    ////new user object.
    User *userobj = [[User alloc] init];
    
    if ([dict count] == 0 || [[dict allKeys] count] < 1) {
        
        userobj.code = 500;
        userobj.Error_msg = [dict valueForKey:@"Error message"];
    }
    else
    {
        
        if ([[dict valueForKey:@"code"] intValue] == 200)
        {
            
            userobj.code = [[dict valueForKey:@"code"] intValue];
            
            NSArray *arrGroup = [[dict objectForKey:@"fields"] objectForKey:@"group"]; //objectForKey:@"field"];
            //    NSArray *arrfields = [dicttemp objectForKey:@"field"];
            userobj.isFullProfileAvailable = YES;
            [userobj.groupList removeAllObjects];
            
            for (int i = 0; i < [arrGroup count]; i++)
            {
                
                UserInfo *userData = [[UserInfo alloc]init];
                userData.groupName = [[arrGroup objectAtIndex:i] objectForKey:@"group_name"];
                NSArray *arrFields = [[arrGroup objectAtIndex:i] objectForKey:@"field"];
                
                for (int j = 0; j < [arrFields count]; j++)
                {
                    UserInfo *userDetail = [[UserInfo alloc]init];
                    userDetail.fieldId = [[[arrFields objectAtIndex:j] objectForKey:@"id"] intValue];
                    userDetail.fieldName = [[arrFields objectAtIndex:j] objectForKey:@"caption"];
                    userDetail.fieldCaption = [[arrFields objectAtIndex:j] objectForKey:@"caption"];
                    userDetail.fieldValue = [[arrFields objectAtIndex:j] objectForKey:@"value"];
                    userDetail.fieldTempValue = [[arrFields objectAtIndex:j] objectForKey:@"value"];
                    userDetail.isRequired = [[[arrFields objectAtIndex:j] objectForKey:@"required"] boolValue];
                    userDetail.fieldType = [[arrFields objectAtIndex:j] objectForKey:@"type"];
                    NSArray *arrOptions = [[arrFields objectAtIndex:j] objectForKey:@"options"];
                    
                    for (int k = 0; k < [arrOptions count]; k++)
                    {
                        Option *optObj = [[Option alloc]init];
                        optObj.caption = [[arrOptions objectAtIndex:k] objectForKey:@"caption"];
                        optObj.value = [[arrOptions objectAtIndex:k] objectForKey:@"value"];
                        [userDetail.optionList addObject:optObj];
                    }
                    
//                    NSDictionary *dictprivacy = [[arrGroup objectAtIndex:i] objectForKey:@"privacy"];
//                    
//                    NSArray *arrPrivacyOptions = [dictprivacy objectForKey:@"options"];
//                    NSMutableArray *arroption = [[NSMutableArray alloc] init];
//                    for (int k = 0; k < [arrPrivacyOptions count]; k++)
//                    {
//                        Option *optObj = [[Option alloc]init];
//                        optObj.caption = [[arrPrivacyOptions objectAtIndex:k] objectForKey:@"caption"];
//                        optObj.value = [[arrPrivacyOptions objectAtIndex:k] objectForKey:@"value"];
//                        [arroption addObject:optObj];
//                    }
//                    [userDetail.dictprivacy setObject:arroption forKey:@"options"];
//                    [userDetail.dictprivacy setObject:[dictprivacy objectForKey:@"value"] forKey:@"value"];
                    
                    if ([userDetail.fieldType isEqualToString:@"map"]) {
                       // userDetail.fieldType = @"text";
                    }
                    [userData.fieldList addObject:userDetail];
                }
                [userobj.groupList addObject:userData];
            }
        }
        else{
            
            userobj.code = [[dict valueForKey:@"code"] intValue];
            userobj.Error_msg = [dict valueForKey:@"message"];
        }
        
    }
    
    [userobj autorelease];
    return userobj;
}

//View Userdetail.
+(User *) Userdetail :(NSDictionary *) dict
{
    User *userobj = [[User alloc] init];
    
    if ([dict count] == 0 || [[dict allKeys] count] < 1)
    {
        
        userobj.code = 500;
        userobj.Error_msg = [dict valueForKey:@"Error message"];
    }
    else
    {
        
        if ([[dict valueForKey:@"code"] intValue] == 200)
        {
           //counts get
            [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
            [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
            [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
            iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
            if ([ApplicationData sharedInstance].frndCount > 0) {
                [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
                appDelegate.btnFriendCount.hidden = NO;
            }else {
                appDelegate.btnFriendCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].msgCount > 0) {
                [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
                appDelegate.btnMsgCount.hidden = NO;
            }else {
                appDelegate.btnMsgCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].groupCount > 0) {
                [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
                appDelegate.btnGroupCount.hidden = NO;
            }else {
                appDelegate.btnGroupCount.hidden = YES;
            }
            
            
            userobj.code = [[dict valueForKey:@"code"] intValue];
            
            NSArray *arrGroup = [[dict objectForKey:@"fields"] objectForKey:@"group"]; //
            
            userobj.isFullProfileAvailable = YES;
            [userobj.groupList removeAllObjects];
            
            for (int i = 0; i < [arrGroup count]; i++)
            {
                UserInfo *userData = [[UserInfo alloc]init];
                userData.groupName = [[arrGroup objectAtIndex:i] objectForKey:@"group_name"];
                NSArray *arrFields = [[arrGroup objectAtIndex:i] objectForKey:@"field"];
                
                for (int j = 0; j < [arrFields count]; j++)
                {
                    UserInfo *userDetail = [[UserInfo alloc]init];
                    userDetail.fieldId = [[[arrFields objectAtIndex:j] objectForKey:@"id"] intValue];
                    userDetail.fieldName = [[arrFields objectAtIndex:j] objectForKey:@"caption"];
                    userDetail.fieldCaption = [[arrFields objectAtIndex:j] objectForKey:@"caption"];
                    userDetail.fieldValue = [[arrFields objectAtIndex:j] objectForKey:@"value"];
                    userDetail.fieldTempValue = [[arrFields objectAtIndex:j] objectForKey:@"value"];
                    userDetail.isRequired = [[[arrFields objectAtIndex:j] objectForKey:@"required"] boolValue];
                    userDetail.fieldType = [[arrFields objectAtIndex:j] objectForKey:@"type"];
                    NSArray *arrOptions = [[arrFields objectAtIndex:j] objectForKey:@"options"];
                    if ([userDetail.fieldName isEqualToString:@"State"] || [userDetail.fieldName isEqualToString:@"Country"]) {
                        DLog(@"Value:%@",userDetail.fieldValue);
                    }
                    for (int k = 0; k < [arrOptions count]; k++)
                    {
                        Option *optObj = [[Option alloc]init];
                        optObj.name = [[arrOptions objectAtIndex:k] objectForKey:@"caption"];
                        optObj.value = [[arrOptions objectAtIndex:k] objectForKey:@"value"];
                        [userDetail.optionList addObject:optObj];
                    }
                    if ([userDetail.fieldType isEqualToString:@"map"]) {
                       // userDetail.fieldType = @"text";
                    }
                    [userData.fieldList addObject:userDetail];
                }
                [userobj.groupList addObject:userData];
            }
        }
        else{
            
            userobj.code = [[dict valueForKey:@"code"] intValue];
            userobj.Error_msg = [dict valueForKey:@"message"];
        }
        
    }
    return userobj;
}

//all member list and friend list.
//+(NSMutableArray *) Memberlist :(NSDictionary *) dict Exttask :(NSString *)exttask
//{
//    
//    User *tempUser;
//    NSMutableArray *userList = [[NSMutableArray alloc] init];
//    
//    if ([dict count] == 0 || [[dict allKeys] count] < 1) {
//        
//        tempUser = [[User alloc]init];
//        tempUser.code = 500;
//        tempUser.Error_msg = [dict valueForKey:@"Error message"];
//        
//        [userList addObject:tempUser];
//        [tempUser release];
//    }
//    else
//    {
//        
//        if ([[dict valueForKey:@"code"] intValue] == 200)
//        {
//            
//            //counts get
//            [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
//            [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
//            [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
//            iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
//            if ([ApplicationData sharedInstance].frndCount > 0) {
//                [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
//                appDelegate.btnFriendCount.hidden = NO;
//            }else {
//                appDelegate.btnFriendCount.hidden = YES;
//            }
//            
//            if ([ApplicationData sharedInstance].msgCount > 0) {
//                [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
//                appDelegate.btnMsgCount.hidden = NO;
//            }else {
//                appDelegate.btnMsgCount.hidden = YES;
//            }
//            
//            if ([ApplicationData sharedInstance].groupCount > 0) {
//                [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
//                appDelegate.btnGroupCount.hidden = NO;
//            }else {
//                appDelegate.btnGroupCount.hidden = YES;
//            }
//            
//            NSArray *arr_memberlist = [dict objectForKey:@"member"];
//            User *newFriend;
//            for (int i = 0; i < [arr_memberlist count]; i++)
//            {
//                
//                tempUser = [[User alloc]init];
//                
//                if ([exttask isEqualToString:@"friends"])
//                {
//                    tempUser.friends_count = [[dict valueForKey:@"total"] intValue];
//                    [ApplicationData sharedInstance].totalFriends = [[dict valueForKey:@"total"] intValue];
//                }
//                else if([exttask isEqualToString:@"members"])
//                {
//                    tempUser.member_count = [[dict valueForKey:@"total"] intValue];
//                    [ApplicationData sharedInstance].memberListLimit = [[dict valueForKey:@"total"] intValue];
//                }
//                tempUser.code = [[dict valueForKey:@"code"] intValue];
//                tempUser.userId = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_id"] intValue];
//                tempUser.userName = [[arr_memberlist objectAtIndex:i] objectForKey:@"user_name"];
//                tempUser.thumbURL = [[arr_memberlist objectAtIndex:i] objectForKey:@"user_avatar"];
//                tempUser.avatarURL = [[arr_memberlist objectAtIndex:i] objectForKey:@"user_avatar"];
//                tempUser.status = [[arr_memberlist objectAtIndex:i] objectForKey:@"status"] ;
//                tempUser.viewCount = [[[arr_memberlist objectAtIndex:i] objectForKey:@"viewcount"] intValue];
//                tempUser.latitude = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_lat"] floatValue];
//                tempUser.longitude = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_long"] floatValue];
//                tempUser.online = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_online"] boolValue];
//                tempUser.pending = [[[arr_memberlist objectAtIndex:i] objectForKey:@"isFriendReqTo"] boolValue];
//                tempUser.profile =	[[[arr_memberlist objectAtIndex:i] objectForKey:@"profile"] intValue];
//                tempUser.photo = [[[arr_memberlist objectAtIndex:i] objectForKey:@"photo"] intValue];
//                tempUser.isFriend = [[[arr_memberlist objectAtIndex:i] objectForKey:@"friend"] boolValue];
//                
//                [userList addObject:tempUser];
//                [newFriend release];
//            }
//        }
//        else{
//            
//            tempUser = [[User alloc]init];
//            tempUser.code = [[dict valueForKey:@"code"] intValue];
//            tempUser.Error_msg = [dict valueForKey:@"message"];
//            [userList addObject:tempUser];
//            [tempUser release];
//        }
//    }
//    
//    [userList autorelease];
//    return userList;
//}
+(NSMutableArray *) Memberlist :(NSDictionary *) dict Exttask :(NSString *)exttask
{
    
    NSLog(@"json return ... %@",dict);
    NSLog(@"json return ... %d",[dict count]);
    NSLog(@"json return ... %@",[dict allKeys]);
    
    User *newFriend;// = [[User alloc]init];
    NSMutableArray *userList = [[NSMutableArray alloc] init];
    
    if ([dict count] == 0 || [[dict allKeys] count] < 1) {
        
        newFriend = [[User alloc]init];
        newFriend.code = 500;
        newFriend.Error_msg = [dict valueForKey:@"Error message"];
        
        [userList addObject:newFriend];
        [newFriend release];
    }
    else
    {
        
        if ([[dict valueForKey:@"code"] intValue] == 200)
        {
            [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
            [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
            [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
            iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
            if ([ApplicationData sharedInstance].frndCount > 0) {
                [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
                appDelegate.btnFriendCount.hidden = NO;
            }else {
                appDelegate.btnFriendCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].msgCount > 0) {
                [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
                appDelegate.btnMsgCount.hidden = NO;
            }else {
                appDelegate.btnMsgCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].groupCount > 0) {
                [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
                appDelegate.btnGroupCount.hidden = NO;
            }else {
                appDelegate.btnGroupCount.hidden = YES;
            }
            
            NSArray *arr_memberlist = [dict objectForKey:@"member"];
            NSLog(@"arr_memberlist : %@",arr_memberlist);
            if ([exttask isEqualToString:@"friends"])
            {
                [ApplicationData sharedInstance].totalFriends = [[dict valueForKey:@"total"] intValue];
            }
            else if([exttask isEqualToString:@"members"])
            {
                [ApplicationData sharedInstance].memberListLimit = [[dict valueForKey:@"total"] intValue];
            }
            for (int i = 0; i < [arr_memberlist count]; i++)
            {
                
                newFriend = [[User alloc]init];
                
                newFriend.member_count = [[dict valueForKey:@"total"] intValue];
                newFriend.code = [[dict valueForKey:@"code"] intValue];
                newFriend.userId = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_id"] intValue];
                newFriend.userName = [[arr_memberlist objectAtIndex:i] objectForKey:@"user_name"];
                newFriend.thumbURL = [[arr_memberlist objectAtIndex:i] objectForKey:@"user_avatar"];
                newFriend.avatarURL = [[arr_memberlist objectAtIndex:i] objectForKey:@"user_avatar"];
                newFriend.status = [[arr_memberlist objectAtIndex:i] objectForKey:@"status"] ;
                newFriend.viewCount = [[[arr_memberlist objectAtIndex:i] objectForKey:@"viewcount"] intValue];
                newFriend.latitude = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_lat"] floatValue];
                newFriend.longitude = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_long"] floatValue];
                newFriend.online = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_online"] boolValue];
                newFriend.pending = [[[arr_memberlist objectAtIndex:i] objectForKey:@"isFriendReqTo"] boolValue];
                newFriend.profile =	[[[arr_memberlist objectAtIndex:i] objectForKey:@"profile"] intValue];
                newFriend.photo = [[[arr_memberlist objectAtIndex:i] objectForKey:@"photo"] intValue];
                newFriend.isFriend = [[[arr_memberlist objectAtIndex:i] objectForKey:@"friend"] boolValue];
                
                [userList addObject:newFriend];
                [newFriend release];
            }
        }
        NSLog(@"userList : %@",userList);
    }
    return userList;
}
//notification member profile.
+(User *) Notification_member_profile :(NSDictionary *) dict;
{
  
    User *userobj = [[User alloc] init];
    
    if ([dict count] == 0 || [[dict allKeys] count] < 1) {
        
        userobj.code = 500;
        userobj.Error_msg = [dict objectForKey:@"Error message"];
    }
    else
    {
        
        if ([[dict valueForKey:@"code"] intValue] == 200) {
            
            //counts get
            [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
            [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
            [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
            iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
            if ([ApplicationData sharedInstance].frndCount > 0) {
                [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
                appDelegate.btnFriendCount.hidden = NO;
            }else {
                appDelegate.btnFriendCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].msgCount > 0) {
                [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
                appDelegate.btnMsgCount.hidden = NO;
            }else {
                appDelegate.btnMsgCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].groupCount > 0) {
                [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
                appDelegate.btnGroupCount.hidden = NO;
            }else {
                appDelegate.btnGroupCount.hidden = YES;
            }
            
            userobj.code = [[dict objectForKey:@"code"] intValue];
            userobj.userName = [[dict objectForKey:@"profile"] objectForKey:@"user"];
            userobj.status = [[dict objectForKey:@"profile"] objectForKey:@"message"];
            userobj.avatarURL = [[dict objectForKey:@"profile"] objectForKey:@"avatar"];
            userobj.viewCount = [[[dict objectForKey:@"profile"] objectForKey:@"viewcount"] intValue];
        }
        else{
            
            userobj.code = [[dict valueForKey:@"code"] intValue];
            userobj.Error_msg = [dict valueForKey:@"message"];
        }
    }
    [userobj autorelease];
    return userobj;
}

//member search.
+(NSMutableArray *) MemberSearch :(NSDictionary *) dict;
{
    User *tempUser;// = [[User alloc]init];
    NSMutableArray *userList = [[NSMutableArray alloc] init];
    
    if ([dict count] == 0 || [[dict allKeys] count] < 1) {
        
        tempUser = [[User alloc]init];
        tempUser.code = 500;
        tempUser.Error_msg = [dict valueForKey:@"Error message"];
        
        [userList addObject:tempUser];
        [tempUser release];
    }
    else
    {
        
        if ([[dict valueForKey:@"code"] intValue] == 200)
        {
            
            //counts get
            [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
            [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
            [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
            iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
            if ([ApplicationData sharedInstance].frndCount > 0) {
                [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
                appDelegate.btnFriendCount.hidden = NO;
            }else {
                appDelegate.btnFriendCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].msgCount > 0) {
                [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
                appDelegate.btnMsgCount.hidden = NO;
            }else {
                appDelegate.btnMsgCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].groupCount > 0) {
                [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
                appDelegate.btnGroupCount.hidden = NO;
            }else {
                appDelegate.btnGroupCount.hidden = YES;
            }
            
            NSArray *arr_memberlist = [dict objectForKey:@"member"];
            
            for (int i = 0; i < [arr_memberlist count]; i++) {
                tempUser = [[User alloc]init];
                tempUser.search_count = [[dict valueForKey:@"total"] intValue];
                tempUser.code = [[dict valueForKey:@"code"] intValue];
                tempUser.userId = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_id"] intValue];
                tempUser.userName = [[arr_memberlist objectAtIndex:i] objectForKey:@"user_name"];
                tempUser.thumbURL = [[arr_memberlist objectAtIndex:i] objectForKey:@"thumb"];
                tempUser.avatarURL = [[arr_memberlist objectAtIndex:i] objectForKey:@"user_avatar"];
                tempUser.status = [[arr_memberlist objectAtIndex:i] objectForKey:@"status"] ;
                tempUser.viewCount = [[[arr_memberlist objectAtIndex:i] objectForKey:@"viewcount"] intValue];
                tempUser.latitude = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_lat"] floatValue];
                tempUser.longitude = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_long"] floatValue];
                tempUser.online = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_online"] boolValue];
                tempUser.pending = [[[arr_memberlist objectAtIndex:i] objectForKey:@"pending"] boolValue];
                tempUser.profile =	[[[arr_memberlist objectAtIndex:i] objectForKey:@"user_profile"] intValue];
                tempUser.photo = [[[arr_memberlist objectAtIndex:i] objectForKey:@"photo"] intValue];
                tempUser.isFriend = [[[arr_memberlist objectAtIndex:i] objectForKey:@"friend"] boolValue];
                
                [userList addObject:tempUser];
                [tempUser release];
            }
        }
        else{
            
            tempUser = [[User alloc]init];
            tempUser.code = [[dict valueForKey:@"code"] intValue];
            tempUser.Error_msg = [dict valueForKey:@"message"];
            [userList addObject:tempUser];
            [tempUser release];
        }
    }
    
//    [userList autorelease];
    return userList;
}

//activities.

//profile Type
+(NSMutableArray *) ProfileType :(NSDictionary *) dict
{
    NSMutableArray *arrProfilelist = [[NSMutableArray alloc] init];
    if ([dict count] == 0 || [[dict allKeys] count] < 1) {
        Like *record = [[Like alloc] init];
        record.code = 500;
        record.Error_msg = @"Server Error";
        [arrProfilelist addObject:record];
        [record release];
    }
    else
    {
       if ([[dict valueForKey:@"code"] intValue] == 200)
       {

           
           NSArray *typeList = [dict objectForKey:@"profiletype"];
           
           for (int i = 0; i < [typeList count]; i++)
           {
               
               Like *record = [[Like alloc] init];
               record.likeId = [[[typeList objectAtIndex:i] objectForKey:@"id"] intValue];
               record.name = [[typeList objectAtIndex:i] objectForKey:@"name"];
               record.description = [[typeList objectAtIndex:i] objectForKey:@"description"];
               
               [arrProfilelist addObject:record];
               if (record) {
                   [record release];
               }
           }
       }
       else
       {
           Like *record = [[Like alloc] init];
           record.code = [[dict valueForKey:@"code"] intValue];
           record.Error_msg = [dict valueForKey:@"message"];
           [arrProfilelist addObject:record];
           [record release];
       }
    }
    [arrProfilelist autorelease];
    return arrProfilelist;
}

//User Privacy settings Type
+(NSMutableArray *) UserPrivacysettings :(NSDictionary *) dict
{
    
    //counts get
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    NSMutableArray *arrUserPrivacysettings = [[NSMutableArray alloc] init];
    
    UserInfo *userData;// = [[UserInfo alloc] init];
    int tempId = 1;
    
    NSArray *fieldList = [dict objectForKey:@"fields"];
    for (int i = 0; i < [fieldList count]; i++)
    {
        userData = [[UserInfo alloc] init];
        userData.code = [[dict objectForKey:@"code"] intValue];
        userData.groupName = [[fieldList objectAtIndex:i] objectForKey:@"group_name"];
        NSArray *field = [[fieldList objectAtIndex:i] objectForKey:@"field"];
        for (int j = 0; j<[field count]; j++) {
            UserInfo *userDetail = [[UserInfo alloc] init];
            userDetail.fieldName = [[field objectAtIndex:j] objectForKey:@"name"];
            userDetail.fieldId = tempId;
            if([[[field objectAtIndex:j] objectForKey:@"name"] isKindOfClass:[NSArray class]]){
                userDetail.nameArray = [(NSArray *) [[field objectAtIndex:j] objectForKey:@"name"]mutableCopy];
            }
            userDetail.fieldCaption = [[field objectAtIndex:j] objectForKey:@"title"];
            userDetail.fieldValue = [NSString stringWithFormat:@"%@",[[field objectAtIndex:j] objectForKey:@"value"]];
            if([[[field objectAtIndex:j] objectForKey:@"value"] isKindOfClass:[NSArray class]]){
                userDetail.valueArray = [(NSArray *) [[field objectAtIndex:j] objectForKey:@"value"]mutableCopy];
            }
            userDetail.fieldTempValue = [NSString stringWithFormat:@"%@",[[field objectAtIndex:j] objectForKey:@"value"]];
            
            if([[[field objectAtIndex:j] objectForKey:@"type"] isKindOfClass:[NSArray class]]){
                userDetail.typeArray = [(NSArray *) [[field objectAtIndex:j] objectForKey:@"type"]mutableCopy];
            }else {
                userDetail.fieldType = [[field objectAtIndex:j] objectForKey:@"type"];
            }
            NSArray *optionList = [[field objectAtIndex:j] objectForKey:@"options"];
            if (![optionList isKindOfClass:[NSNull class]]) {
                for(int k = 0; k < [optionList count]; k++) {
                    Option *option = [[Option alloc] init];
                    option.name = [[optionList objectAtIndex:k] objectForKey:@"name"];
                    option.value = [NSString stringWithFormat:@"%@",[[optionList objectAtIndex:k] objectForKey:@"value"]];
                    [userDetail.optionList addObject:option];
                    [option release];
                }
            }
            [userData.fieldList addObject:userDetail];
            [userDetail release];
            ++ tempId;
        }
        [arrUserPrivacysettings addObject:userData];
        [userData release];
    }
    
    
    NSLog(@"%@",arrUserPrivacysettings);
    NSLog(@"%d",[arrUserPrivacysettings count]);
    
    
    return arrUserPrivacysettings;
}

+(NSMutableArray *) Activities :(NSDictionary *) dict
{
    
    NSMutableArray *arrWalllist = [[NSMutableArray alloc] init];
    arrWalllist = [[NSMutableArray alloc] init];
    Wall *wallRecord;
    if ([dict count] == 0 || [[dict allKeys] count] < 1) {
        wallRecord = [[Wall alloc] init];
        wallRecord.code = 500;
        wallRecord.Error_msg = @"Server Error";
        [arrWalllist addObject:wallRecord];
        [wallRecord release];
    }
    else
    {
        
        if ([[dict valueForKey:@"code"] intValue] == 200)
        {
            //counts get
            [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
            [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
            [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
            iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
            if ([ApplicationData sharedInstance].frndCount > 0) {
                [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
                appDelegate.btnFriendCount.hidden = NO;
            }else {
                appDelegate.btnFriendCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].msgCount > 0) {
                [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
                appDelegate.btnMsgCount.hidden = NO;
            }else {
                appDelegate.btnMsgCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].groupCount > 0) {
                [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
                appDelegate.btnGroupCount.hidden = NO;
            }else {
                appDelegate.btnGroupCount.hidden = YES;
            }
            
            NSArray *arr_wallUpdates = [dict objectForKey:@"update"];
            for (int i = 0; i < [arr_wallUpdates count]; i++) {
                
                wallRecord = [[Wall alloc] init];
                wallRecord.code = [[dict valueForKey:@"code"] intValue];
                wallRecord.total_updates = [[dict valueForKey:@"total"] intValue];
                
                wallRecord.isCommentAllowed = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"commentAllowed"] boolValue];
                wallRecord.isLikeAllowed = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"likeAllowed"] boolValue];
                wallRecord.content = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"content"];
                wallRecord.content = [wallRecord.content stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                wallRecord.date = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"date"];
                wallRecord.Id = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"id"] intValue];
                wallRecord.time = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"time"];
                wallRecord.type = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"type"];
                wallRecord.liketype = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"liketype"];
                wallRecord.title = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"titletag"];
                wallRecord.thumbURL = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"] objectForKey:@"thumb"];
                //user object store.
                wallRecord.userdetail.userId = [[[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"user_id"] intValue];
                wallRecord.userdetail.userName = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail" ] objectForKey:@"name"];
                wallRecord.userdetail.thumbURL = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"avatar"];
                wallRecord.userdetail.avatarURL = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"avatar"];
                
                wallRecord.userdetail.status = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"status"];
                
                wallRecord.userdetail.viewCount = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"viewcount"] intValue];
                
                wallRecord.userdetail.latitude = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"latitude"] floatValue];
                
                wallRecord.userdetail.longitude = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"longitude"] floatValue];
                
                wallRecord.userdetail.online = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"online"] boolValue];
                
                wallRecord.userdetail.pending = [[[arr_wallUpdates objectAtIndex:i]  objectForKey:@"pending"] boolValue];
                
                wallRecord.userdetail.profile =	[[[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"profile"] intValue];
                
                wallRecord.userdetail.photo = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"photo"] intValue];
                
                wallRecord.userdetail.isFriend = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"friend"] boolValue];
                wallRecord.type = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"type"];
                NSDictionary *contentDict = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"content_data"];
                
                if ([contentDict count] > 0 && [wallRecord.type isEqualToString:@"group"]) {
                    DLog(@"group yes");
                    wallRecord.groupDetail.Id = [[contentDict objectForKey:@"id"] intValue];
                    wallRecord.groupDetail.creatorid = [[contentDict objectForKey:@"owner_id"]intValue];
                    wallRecord.groupDetail.creator = [contentDict objectForKey:@"owner_name"];
                    wallRecord.groupDetail.catId = [[contentDict objectForKey:@"cat_id"]intValue];
                    wallRecord.groupDetail.catName = [contentDict objectForKey:@"cat_name"];
                    
                    wallRecord.groupDetail.isjoin = [[contentDict objectForKey:@"isJoin"] boolValue];
                    
                    wallRecord.groupDetail.name = [contentDict objectForKey:@"group_name"];
                    wallRecord.groupDetail.description = [contentDict objectForKey:@"description"];
                    wallRecord.groupDetail.date = [contentDict objectForKey:@"created"];
                    //                    wallRecord.groupDetail.avatarURL = [groupDict objectForKey:@"owner_id"];
                    wallRecord.groupDetail.thumbURL = [contentDict objectForKey:@"thumb"];
                    //                    wallRecord.groupDetail.photopermission = [[groupDict objectForKey:@"owner_id"]intValue];
                    //                    wallRecord.groupDetail.videopermission = [[groupDict objectForKey:@"owner_id"]intValue];
                    //                    wallRecord.groupDetail.grouprecentphotos = [[groupDict objectForKey:@"owner_id"]intValue];
                    //                    wallRecord.groupDetail.grouprecentvideos = [[groupDict objectForKey:@"owner_id"]intValue];
                }
                
                if ([contentDict count] > 0 && [wallRecord.type isEqualToString:@"videos"]) {
                    wallRecord.videoURL = [contentDict objectForKey:@"video_path"];
                    wallRecord.videoThumbUrl = [contentDict objectForKey:@"video_icon"];
                }
                if ([contentDict count] > 0 && [wallRecord.type isEqualToString:@"friends"]) {
                    wallRecord.tempUser.avatarURL = [contentDict objectForKey:@"avatar"];
                    wallRecord.tempUser.avatarURL = [contentDict objectForKey:@"name"];
                    wallRecord.tempUser.profile = [[contentDict objectForKey:@"profile"] intValue];
                    wallRecord.tempUser.userId = [[contentDict objectForKey:@"user_id"] intValue];
                }
                [arrWalllist addObject:wallRecord];
                [wallRecord release];
            }
            
        }
        else
        {
            wallRecord = [[Wall alloc] init];
            wallRecord.code = [[dict valueForKey:@"code"] intValue];
            wallRecord.Error_msg = [dict valueForKey:@"message"];
            [arrWalllist addObject:wallRecord];
            [wallRecord release];
        }
    }
    
    [arrWalllist autorelease];
    return arrWalllist;
}

//+(NSMutableArray *)Wall:(NSDictionary *)dict {
//
//    User *userObj = [[User alloc]init];
//    NSMutableArray *arrWalllist = [[NSMutableArray alloc] init];
//    arrWalllist = [[NSMutableArray alloc] init];
//    Wall *wallRecord;
//    if ([dict count] == 0 || [[dict allKeys] count] < 1) {
//        wallRecord = [[Wall alloc] init];
//        wallRecord.code = 500;
//        wallRecord.Error_msg = @"Server Error";
//        [arrWalllist addObject:wallRecord];
//        [wallRecord release];
//    }
//    else
//    {
//        if ([[dict valueForKey:@"code"] intValue] == 200)
//        {
//            //counts get
//            [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
//            [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
//            [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
//            iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
//            if ([ApplicationData sharedInstance].frndCount > 0) {
//                [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
//                appDelegate.btnFriendCount.hidden = NO;
//            }else {
//                appDelegate.btnFriendCount.hidden = YES;
//            }
//            
//            if ([ApplicationData sharedInstance].msgCount > 0) {
//                [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
//                appDelegate.btnMsgCount.hidden = NO;
//            }else {
//                appDelegate.btnMsgCount.hidden = YES;
//            }
//            
//            if ([ApplicationData sharedInstance].groupCount > 0) {
//                [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
//                appDelegate.btnGroupCount.hidden = NO;
//            }else {
//                appDelegate.btnGroupCount.hidden = YES;
//            }
//            
//            Wall *wallRecord;// = [[Wall alloc] init];
//            NSArray *arr_wallUpdates = [dict objectForKey:@"update"];
//            for (int i = 0; i < [arr_wallUpdates count]; i++) {
//                wallRecord = [[Wall alloc] init];
//                wallRecord.Id = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"id"] intValue];
//                wallRecord.wallId = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"id"] intValue];
//                wallRecord.date = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"date"];
//                wallRecord.time = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"time"];
//                wallRecord.thumbURL = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"avatar"];
//                wallRecord.videoURL = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"video_path"];
//                wallRecord.videoThumbUrl = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"video_icon"];
//                wallRecord.title = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"titletag"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//                wallRecord.isDeleteAllowed = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
//                wallRecord.content = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"content"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//                wallRecord.isLikeAllowed = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"likeAllowed"] boolValue];
//                wallRecord.isCommentAllowed = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"commentAllowed"] boolValue];
//                wallRecord.userdetail.userId = [[[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"user_id"] intValue];
//                wallRecord.userdetail.userName = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail" ] objectForKey:@"user_name"];
//                wallRecord.userdetail.thumbURL = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"user_avatar"];
//                wallRecord.userdetail.avatarURL = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"user_avatar"];
//                wallRecord.userdetail.status = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"status"];
//                wallRecord.userdetail.viewCount = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"viewcount"] intValue];
//                wallRecord.userdetail.latitude = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"latitude"] floatValue];
//                wallRecord.userdetail.longitude = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"longitude"] floatValue];
//                wallRecord.userdetail.online = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"online"] boolValue];
//                wallRecord.userdetail.pending = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"pending"] boolValue];
//                wallRecord.userdetail.profile =	[[[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"user_profile"] intValue];
//                wallRecord.userdetail.photo = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"photo"] intValue];
//                wallRecord.userdetail.isFriend = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"friend"] boolValue];
//                wallRecord.type = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"type"];
//                wallRecord.liked = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"liked"] boolValue];
//                wallRecord.likes = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"likeCount"] intValue];
//                wallRecord.comments = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"commentCount"] intValue];
//                wallRecord.liketype = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"liketype"];
//                wallRecord.commenttype = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"commenttype"];
//                
//                NSDictionary *contentDict = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"content_data"];
//                wallRecord.isDeleteAllowed = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
//                if (![contentDict isKindOfClass:[NSNull class]]) {
//                    if ([contentDict count] > 0 && [wallRecord.type isEqualToString:@"group"] ) {
//                        DLog(@"group yes");
//                        wallRecord.groupDetail.Id = [[contentDict objectForKey:@"id"] intValue];
//                        wallRecord.groupDetail.creatorid = [[contentDict objectForKey:@"owner_id"]intValue];
//                        wallRecord.groupDetail.creator = [contentDict objectForKey:@"owner_name"];
//                        wallRecord.groupDetail.catId = [[contentDict objectForKey:@"cat_id"]intValue];
//                        wallRecord.groupDetail.catName = [contentDict objectForKey:@"cat_name"];
//                        
//                        wallRecord.groupDetail.isjoin = [[contentDict objectForKey:@"isJoin"] boolValue];
//                        
//                        wallRecord.groupDetail.name = [contentDict objectForKey:@"group_name"];
//                        wallRecord.groupDetail.description = [contentDict objectForKey:@"description"];
//                        wallRecord.groupDetail.date = [contentDict objectForKey:@"created"];
//                        //                    wallRecord.groupDetail.avatarURL = [groupDict objectForKey:@"owner_id"];
//                        wallRecord.groupDetail.thumbURL = [contentDict objectForKey:@"thumb"];
//                        //                    wallRecord.groupDetail.photopermission = [[groupDict objectForKey:@"owner_id"]intValue];
//                        //                    wallRecord.groupDetail.videopermission = [[groupDict objectForKey:@"owner_id"]intValue];
//                        //                    wallRecord.groupDetail.grouprecentphotos = [[groupDict objectForKey:@"owner_id"]intValue];
//                        //                    wallRecord.groupDetail.grouprecentvideos = [[groupDict objectForKey:@"owner_id"]intValue];
//                    }
//                    
//                    if ([contentDict count] > 0 && [wallRecord.type isEqualToString:@"videos"]) {
//                        wallRecord.videoURL = [contentDict objectForKey:@"video_path"];
//                        wallRecord.videoThumbUrl = [contentDict objectForKey:@"video_icon"];
//                    }
//                    
//                    if ([contentDict count] > 0 && [wallRecord.type isEqualToString:@"friends"]) {
//                        wallRecord.tempUser.avatarURL = [contentDict objectForKey:@"avatar"];
//                        wallRecord.tempUser.userName = [contentDict objectForKey:@"name"];
//                        wallRecord.tempUser.profile = [[contentDict objectForKey:@"profile"] intValue];
//                        wallRecord.tempUser.userId = [[contentDict objectForKey:@"user_id"] intValue];
//                    }
//                }
//                
////                if (wallRecord.content.length > 0) {
////                    NSArray *imageList = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"content"] objectForKey:@"img"];
////                    NSArray *bigImageList = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"content"] objectForKey:@"bigimg"];
////                    
////                    if ([imageList count] > 0 && [bigImageList count] > 0) {
////                        //DLog(@"Wall Record : %@", wallRecord.title);
////                        for (NSString *imageContent in bigImageList) {
////                            Image *imgRecord =[[Image alloc] init];
////                            imgRecord.imgURL = imageContent;
////                            //DLog(@"Image : %@", imgRecord.imgURL);
////                            [wallRecord.imageList addObject:imgRecord];
////                            [imgRecord release];
////                        }
////                        //                wallRecord.content = [[XMLManualParser getTagValue:TAG_TEXT XMLContent:wallRecord.content] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
////                        wallRecord.content = [wallRecord.content lastPathComponent];
////                        wallRecord.content = [wallRecord.content stringByReplacingOccurrencesOfString:@"bigimg" withString:@""];
////                    }
////                    NSArray *likeList = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"content"] objectForKey:@"like"];
////                    [wallRecord.likeList removeAllObjects];
////    //                for (NSString *likeContent in likeList) {
////                    for (int j = 0 ; j < [likeList count]; j++) {
////                        
////                    
////                        Like *likeRecord = [[Like alloc] init];
////                        likeRecord.likeId = [[[likeList objectAtIndex:j] objectForKey:@"id"] intValue];
////                        likeRecord.userId = [[[likeList objectAtIndex:j] objectForKey:@"userid"] intValue];
////                        likeRecord.name = [[[likeList objectAtIndex:j] objectForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
////                        [wallRecord.likeList addObject:likeRecord];
////                        [likeRecord release];
////                    }
////                    NSArray *commentList = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"content"] objectForKey:@"comment"];
////                    [wallRecord.commentList removeAllObjects];
////                    for (int j = 0 ; j < [commentList count]; j++) {
////                        Comment *commentRecord = [[Comment alloc] init];
////                        commentRecord.commentId = [[[commentList objectAtIndex:j] objectForKey:@"comment_id"] intValue];
////                        commentRecord.commentText = [[[commentList objectAtIndex:j] objectForKey:@"comment_text"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
////                        commentRecord.dateTime = [[commentList objectAtIndex:j] objectForKey:@"date_time"];
////                        commentRecord.thumbURL = [[commentList objectAtIndex:j] objectForKey:@"thumb"];
////                        
////                        [wallRecord.commentList addObject:commentRecord];
////                        [commentRecord release];
////                    }
////                }
//                [userObj.wallList addObject:wallRecord];
//                [wallRecord release];
//            }
//            
//        }else {
//            
//        }
//        
//    }
//    return userObj.wallList;
//}

+(NSMutableArray *)Wall:(NSDictionary *)dict {
    NSLog(@"json return ... %@",dict);
    NSLog(@"json return ... %d",[dict count]);
    NSLog(@"json return ... %@",[dict allKeys]);
    User *userObj = [[User alloc]init];
    NSMutableArray *arrWalllist = [[NSMutableArray alloc] init];
    arrWalllist = [[NSMutableArray alloc] init];
    Wall *wallRecord;
    if ([dict count] == 0 || [[dict allKeys] count] < 1) {
        wallRecord = [[Wall alloc] init];
        wallRecord.code = 500;
        wallRecord.Error_msg = @"Server Error";
        [arrWalllist addObject:wallRecord];
        [wallRecord release];
    }
    else
    {
        if ([[dict valueForKey:@"code"] intValue] == 200)
        {
            //counts get
            [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
            [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
            [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
            iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
            if ([ApplicationData sharedInstance].frndCount > 0) {
                [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
                appDelegate.btnFriendCount.hidden = NO;
            }else {
                appDelegate.btnFriendCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].msgCount > 0) {
                [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
                appDelegate.btnMsgCount.hidden = NO;
            }else {
                appDelegate.btnMsgCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].groupCount > 0) {
                [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
                appDelegate.btnGroupCount.hidden = NO;
            }else {
                appDelegate.btnGroupCount.hidden = YES;
            }
            
            Wall *wallRecord;// = [[Wall alloc] init];
            NSArray *arr_wallUpdates = [dict objectForKey:@"update"];
            for (int i = 0; i < [arr_wallUpdates count]; i++) {
                wallRecord = [[Wall alloc] init];
                wallRecord.Id = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"id"] intValue];
                wallRecord.wallId = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"id"] intValue];
                wallRecord.date = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"date"];
                wallRecord.time = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"time"];
                wallRecord.thumbURL = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"user_avatar"];
                wallRecord.videoURL = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"video_path"];
                wallRecord.videoThumbUrl = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"video_icon"];
                wallRecord.title = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"titletag"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                wallRecord.isDeleteAllowed = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
                wallRecord.content = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"content"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                wallRecord.content = [wallRecord.content stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                wallRecord.isLikeAllowed = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"likeAllowed"] boolValue];
                wallRecord.isCommentAllowed = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"commentAllowed"] boolValue];
                wallRecord.userdetail.userId = [[[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"user_id"] intValue];
                wallRecord.userdetail.userName = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail" ] objectForKey:@"user_name"];
                wallRecord.userdetail.thumbURL = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"user_avatar"];
                wallRecord.userdetail.avatarURL = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"user_avatar"];
                wallRecord.userdetail.status = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"status"];
                wallRecord.userdetail.viewCount = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"viewcount"] intValue];
                wallRecord.userdetail.latitude = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"latitude"] floatValue];
                wallRecord.userdetail.longitude = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"longitude"] floatValue];
                wallRecord.userdetail.online = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"online"] boolValue];
                wallRecord.userdetail.pending = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"pending"] boolValue];
                wallRecord.userdetail.profile =	[[[[arr_wallUpdates objectAtIndex:i] objectForKey:@"user_detail"]objectForKey:@"user_profile"] intValue];
                wallRecord.userdetail.photo = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"photo"] intValue];
                wallRecord.userdetail.isFriend = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"friend"] boolValue];
                wallRecord.type = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"type"];
                wallRecord.liked = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"liked"] boolValue];
                wallRecord.likes = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"likeCount"] intValue];
                wallRecord.comments = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"commentCount"] intValue];
                wallRecord.liketype = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"liketype"];
                wallRecord.commenttype = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"commenttype"];
                NSDictionary *contentDict = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"content_data"];
                wallRecord.isDeleteAllowed = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
                if (![contentDict isKindOfClass:[NSNull class]]) {
                    if ([contentDict count] > 0 && [wallRecord.type isEqualToString:@"group"] ) {
                        DLog(@"group yes");
                        wallRecord.groupDetail.Id = [[contentDict objectForKey:@"id"] intValue];
                        wallRecord.groupDetail.creatorid = [[contentDict objectForKey:@"owner_id"]intValue];
                        wallRecord.groupDetail.creator = [contentDict objectForKey:@"owner_name"];
                        wallRecord.groupDetail.catId = [[contentDict objectForKey:@"cat_id"]intValue];
                        wallRecord.groupDetail.catName = [contentDict objectForKey:@"cat_name"];
                        
                        wallRecord.groupDetail.isjoin = [[contentDict objectForKey:@"isJoin"] boolValue];
                        
                        wallRecord.groupDetail.name = [contentDict objectForKey:@"group_name"];
                        wallRecord.groupDetail.description = [contentDict objectForKey:@"description"];
                        wallRecord.groupDetail.date = [contentDict objectForKey:@"created"];
                        //                    wallRecord.groupDetail.avatarURL = [groupDict objectForKey:@"owner_id"];
                        wallRecord.groupDetail.thumbURL = [contentDict objectForKey:@"thumb"];
                        //                    wallRecord.groupDetail.photopermission = [[groupDict objectForKey:@"owner_id"]intValue];
                        //                    wallRecord.groupDetail.videopermission = [[groupDict objectForKey:@"owner_id"]intValue];
                        //                    wallRecord.groupDetail.grouprecentphotos = [[groupDict objectForKey:@"owner_id"]intValue];
                        //                    wallRecord.groupDetail.grouprecentvideos = [[groupDict objectForKey:@"owner_id"]intValue];
                    }
                    
                    if ([contentDict count] > 0 && [wallRecord.type isEqualToString:@"videos"]) {
                        wallRecord.videoURL = [contentDict objectForKey:@"url"];
                        wallRecord.videoThumbUrl = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"thumb"];
                        Video *newVideo = [[Video alloc]init];
                        newVideo.videoID = [[contentDict objectForKey:@"id"] intValue];
                        newVideo.videoTitle = [contentDict objectForKey:@"caption"];
                        newVideo.videoDesc = [contentDict objectForKey:@"description"];
                        newVideo.videoThumbUrl = [contentDict objectForKey:@"thumb"];
                        newVideo.videoURL = [contentDict objectForKey:@"url"];
                        newVideo.userId = [[contentDict objectForKey:@"user_id"] intValue];
                        newVideo.userName = [contentDict objectForKey:@"user_name"];
                        newVideo.isLiked = [[contentDict objectForKey:@"liked"] boolValue];
                        newVideo.isDisliked = [[contentDict objectForKey:@"disliked"] boolValue];
                        newVideo.isDeleteAllowed = [[contentDict objectForKey:@"deleteAllowed"] boolValue];
                        newVideo.isProfileView = [[contentDict objectForKey:@"profile"] boolValue];
                        newVideo.likes = [[contentDict objectForKey:@"likes"] intValue];
                        newVideo.disllikes = [[contentDict objectForKey:@"dislikes"] intValue];
                        newVideo.comments = [[contentDict objectForKey:@"commentCount"] intValue];
                        newVideo.shareLink = [contentDict objectForKey:@"shareLink"];
                        newVideo.date = [contentDict objectForKey:@"date"];
                        newVideo.location = [contentDict objectForKey:@"location"];
                        newVideo.tags = [[contentDict objectForKey:@"tags"] intValue];
                        newVideo.categoryId = [[contentDict objectForKey:@"categoryId"] intValue];
                        newVideo.permissions = [[contentDict objectForKey:@"permissions"] intValue];
                        wallRecord.videoObj = newVideo;
                        [newVideo release];
                    }
                    
                    if ([contentDict count] > 0 && [wallRecord.type isEqualToString:@"friends"]) {
                        wallRecord.tempUser.avatarURL = [contentDict objectForKey:@"avatar"];
                        wallRecord.tempUser.userName = [contentDict objectForKey:@"name"];
                        wallRecord.tempUser.profile = [[contentDict objectForKey:@"profile"] intValue];
                        wallRecord.tempUser.userId = [[contentDict objectForKey:@"user_id"] intValue];
                    }
                    
                    if ([contentDict count] > 0 && [wallRecord.type isEqualToString:@"photos"]) {
                        NSArray *imgArray = [[arr_wallUpdates objectAtIndex:i] objectForKey:@"image_data"];
                        for (int i = 0; i < [imgArray count]; i++) {
                            Photo *newPhoto = [[Photo alloc] init];
                            newPhoto.photoID = [[[imgArray objectAtIndex:i] objectForKey:@"id"] intValue];
                            newPhoto.thumbURL = [[imgArray objectAtIndex:i] objectForKey:@"thumb"];
                            newPhoto.photoURL = [[imgArray objectAtIndex:i] objectForKey:@"url"];
                            newPhoto.name = [[imgArray objectAtIndex:i] objectForKey:@"caption"];
                            newPhoto.shareLink = [[imgArray objectAtIndex:i] objectForKey:@"shareLink"];
                            newPhoto.likeCount = [[[imgArray objectAtIndex:i]objectForKey:@"likes"] intValue];
                            newPhoto.dislikeCount = [[[imgArray objectAtIndex:i]objectForKey:@"dislikes"] intValue];
                            newPhoto.commentCount = [[[imgArray objectAtIndex:i]objectForKey:@"commentCount"] intValue];
                            newPhoto.isLiked = [[[imgArray objectAtIndex:i]objectForKey:@"liked"] boolValue];
                            newPhoto.isDisliked = [[[imgArray objectAtIndex:i]objectForKey:@"disliked"] boolValue];
                
                            [wallRecord.imageList addObject:newPhoto];
                            [newPhoto release];
                        }
                    }
                    
                }
                
                //                if (wallRecord.content.length > 0) {
                //                    NSArray *imageList = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"content"] objectForKey:@"img"];
                //                    NSArray *bigImageList = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"content"] objectForKey:@"bigimg"];
                //
                //                    if ([imageList count] > 0 && [bigImageList count] > 0) {
                //                        //DLog(@"Wall Record : %@", wallRecord.title);
                //                        for (NSString *imageContent in bigImageList) {
                //                            Image *imgRecord =[[Image alloc] init];
                //                            imgRecord.imgURL = imageContent;
                //                            //DLog(@"Image : %@", imgRecord.imgURL);
                //                            [wallRecord.imageList addObject:imgRecord];
                //                            [imgRecord release];
                //                        }
                //                        //                wallRecord.content = [[XMLManualParser getTagValue:TAG_TEXT XMLContent:wallRecord.content] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                //                        wallRecord.content = [wallRecord.content lastPathComponent];
                //                        wallRecord.content = [wallRecord.content stringByReplacingOccurrencesOfString:@"bigimg" withString:@""];
                //                    }
                //                    NSArray *likeList = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"content"] objectForKey:@"like"];
                //                    [wallRecord.likeList removeAllObjects];
                //    //                for (NSString *likeContent in likeList) {
                //                    for (int j = 0 ; j < [likeList count]; j++) {
                //
                //
                //                        Like *likeRecord = [[Like alloc] init];
                //                        likeRecord.likeId = [[[likeList objectAtIndex:j] objectForKey:@"id"] intValue];
                //                        likeRecord.userId = [[[likeList objectAtIndex:j] objectForKey:@"userid"] intValue];
                //                        likeRecord.name = [[[likeList objectAtIndex:j] objectForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                //                        [wallRecord.likeList addObject:likeRecord];
                //                        [likeRecord release];
                //                    }
                //                    NSArray *commentList = [[[arr_wallUpdates objectAtIndex:i] objectForKey:@"content"] objectForKey:@"comment"];
                //                    [wallRecord.commentList removeAllObjects];
                //                    for (int j = 0 ; j < [commentList count]; j++) {
                //                        Comment *commentRecord = [[Comment alloc] init];
                //                        commentRecord.commentId = [[[commentList objectAtIndex:j] objectForKey:@"comment_id"] intValue];
                //                        commentRecord.commentText = [[[commentList objectAtIndex:j] objectForKey:@"comment_text"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                //                        commentRecord.dateTime = [[commentList objectAtIndex:j] objectForKey:@"date_time"];
                //                        commentRecord.thumbURL = [[commentList objectAtIndex:j] objectForKey:@"thumb"];
                //                        
                //                        [wallRecord.commentList addObject:commentRecord];
                //                        [commentRecord release];
                //                    }
                //                }
                [userObj.wallList addObject:wallRecord];
                [wallRecord release];
            }
            
        }else {
            
        }
        
    }
    return userObj.wallList;
}

+(Wall *)Share:(NSDictionary *)dict {
    
    //counts get
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    Wall *wallRecord = [[Wall alloc]init];
    wallRecord.Id = [[dict objectForKey:@"id"] intValue];
    wallRecord.date = [dict objectForKey:@"date"];
    wallRecord.title = [[dict objectForKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return wallRecord;
}

+(NSMutableArray *)Like:(NSDictionary *)dict {
    
    //counts get
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    NSMutableArray *likeList;// = [[NSMutableArray alloc] init];
    
    if ([[dict valueForKey:@"code"] intValue] == 200) {
        likeList = [[NSMutableArray alloc] init];
        NSArray *arr_likelist = [dict objectForKey:@"likes"];
        for (int i = 0; i < [arr_likelist count]; i++) {
            Like *likeRecord = [[Like alloc] init];
            likeRecord.likeId = [[[arr_likelist objectAtIndex:i] objectForKey:@"id"] intValue];
            likeRecord.userId = [[[arr_likelist objectAtIndex:i] objectForKey:@"user_id"] intValue];
            likeRecord.name = [[arr_likelist objectAtIndex:i] objectForKey:@"user_name"];
            [likeList addObject:likeRecord];
            [likeRecord release];
        }
    }
    
    return likeList;
}

+(NSMutableArray *)Comments:(NSDictionary *)dict {
    
    NSMutableArray *commentList;// = [[NSMutableArray alloc] init];
    
        if ([[dict valueForKey:@"code"] intValue] == 200)
        {
            //counts get
            [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
            [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
            [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
            iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
            if ([ApplicationData sharedInstance].frndCount > 0) {
                [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
                appDelegate.btnFriendCount.hidden = NO;
            }else {
                appDelegate.btnFriendCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].msgCount > 0) {
                [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
                appDelegate.btnMsgCount.hidden = NO;
            }else {
                appDelegate.btnMsgCount.hidden = YES;
            }
            
            if ([ApplicationData sharedInstance].groupCount > 0) {
                [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
                appDelegate.btnGroupCount.hidden = NO;
            }else {
                appDelegate.btnGroupCount.hidden = YES;
            }
            
            commentList = [[NSMutableArray alloc] init];
            NSArray *arr_commentlist = [dict objectForKey:@"comments"];
                for (int i = 0; i < [arr_commentlist count]; i++) {
                   Comment *commentRecord = [[Comment alloc] init];
                    commentRecord.commentId = [[[arr_commentlist objectAtIndex:i] objectForKey:@"comment_id"] intValue];
                    commentRecord.commentText = [[[arr_commentlist objectAtIndex:i] objectForKey:@"comment_text"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    commentRecord.dateTime = [[arr_commentlist objectAtIndex:i] objectForKey:@"date_time"];
                    commentRecord.thumbURL = [[arr_commentlist objectAtIndex:i] objectForKey:@"user_avatar"];
                    commentRecord.creatorname = [[arr_commentlist objectAtIndex:i] objectForKey:@"user_name"];
                    commentRecord.userId = [[[arr_commentlist objectAtIndex:i] objectForKey:@"user_id"] intValue];
                    commentRecord.isProfileView = [[[arr_commentlist objectAtIndex:i] objectForKey:@"profile"] boolValue];
                    commentRecord.isDeleteAllowed = [[[arr_commentlist objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
                    [commentList addObject:commentRecord];
                    [commentRecord release];
                }
          }

    return commentList;
}

+(NSMutableArray *)Albums:(NSDictionary *)dict
{
    
    NSArray *arr = [dict allKeys];
    NSMutableArray *albumsArray;
    Category *newAlbum;
    if ([[dict valueForKey:@"code"] intValue] == 200) {
        
        //counts get
        [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
        [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
        [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
        iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
        if ([ApplicationData sharedInstance].frndCount > 0) {
            [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
            appDelegate.btnFriendCount.hidden = NO;
        }else {
            appDelegate.btnFriendCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].msgCount > 0) {
            [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
            appDelegate.btnMsgCount.hidden = NO;
        }else {
            appDelegate.btnMsgCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].groupCount > 0) {
            [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
            appDelegate.btnGroupCount.hidden = NO;
        }else {
            appDelegate.btnGroupCount.hidden = YES;
        }
        
        albumsArray = [[[NSMutableArray alloc]init] autorelease];
        NSArray *album_Array;
        if ([[arr objectAtIndex:1] isEqualToString:@"categories"])
        {
            album_Array = [dict objectForKey:@"categories"];
        }
        else if ([[arr objectAtIndex:3] isEqualToString:@"albums"])
        {
            album_Array = [dict objectForKey:@"albums"];
        }
        for (int i = 0; i < [album_Array count]; i++) {
            newAlbum = [[Category alloc] init];
            newAlbum.albumID = [[[album_Array objectAtIndex:i]objectForKey:@"id"] intValue];
            newAlbum.categoryId = [[[album_Array objectAtIndex:i]objectForKey:@"user_id"] intValue];
			newAlbum.albumName = [[album_Array objectAtIndex:i]objectForKey:@"name"];
			newAlbum.albumDesc = [[album_Array objectAtIndex:i]objectForKey:@"description"];
            if (newAlbum.albumDesc.length == 0) {
                newAlbum.albumDesc = [[album_Array objectAtIndex:i]objectForKey:@"desc"];
            }
            newAlbum.createdOn = [[album_Array objectAtIndex:i]objectForKey:@"date"];
            newAlbum.thumbURL = [[album_Array objectAtIndex:i]objectForKey:@"thumb"];
            newAlbum.Country = [[album_Array objectAtIndex:i]objectForKey:@"location"];
            newAlbum.categoryName = [[album_Array objectAtIndex:i]objectForKey:@"user_name"];
            newAlbum.itemCount = [[[album_Array objectAtIndex:i]objectForKey:@"count"] intValue];
            newAlbum.likeCount = [[[album_Array objectAtIndex:i]objectForKey:@"likes"] intValue];
            newAlbum.dislikeCount = [[[album_Array objectAtIndex:i]objectForKey:@"dislikes"] intValue];
            newAlbum.commentCount = [[[album_Array objectAtIndex:i]objectForKey:@"commentCount"] intValue];
            newAlbum.isLiked = [[[album_Array objectAtIndex:i]objectForKey:@"liked"] boolValue];
            newAlbum.isDisliked = [[[album_Array objectAtIndex:i]objectForKey:@"disliked"] boolValue];
            newAlbum.websiteUrl = [[album_Array objectAtIndex:i]objectForKey:@"shareLink"];
            newAlbum.isDeleteAllowed = [[[album_Array objectAtIndex:i]objectForKey:@"deleteAllowed"] boolValue];
            
            newAlbum.date = [[album_Array objectAtIndex:i]objectForKey:@"date"];
            newAlbum.permission = [[[album_Array objectAtIndex:i]objectForKey:@"permission"] intValue];
            newAlbum.user_profile = [[[album_Array objectAtIndex:i]objectForKey:@"user_profile"] intValue];
            newAlbum.user_avatar = [[album_Array objectAtIndex:i]objectForKey:@"user_avatar"];
            
			[albumsArray addObject:newAlbum];
			[newAlbum release];
        }
    }
    return albumsArray;
}

+(Category *)Photos:(NSDictionary *)dict Album:(Category *)albumObj {
    
    Photo *newPhoto;
    if ([[dict valueForKey:@"code"] intValue] == 200)
    {
        //counts get
        [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
        [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
        [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
        iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
        if ([ApplicationData sharedInstance].frndCount > 0) {
            [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
            appDelegate.btnFriendCount.hidden = NO;
        }else {
            appDelegate.btnFriendCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].msgCount > 0) {
            [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
            appDelegate.btnMsgCount.hidden = NO;
        }else {
            appDelegate.btnMsgCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].groupCount > 0) {
            [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
            appDelegate.btnGroupCount.hidden = NO;
        }else {
            appDelegate.btnGroupCount.hidden = YES;
        }
        
        NSArray *photoList = [dict objectForKey:@"photos"];
        //albumObj.totalArticle = [[dict objectForKey:@"photocount"] intValue];
        albumObj.totalArticle = [[dict objectForKey:@"total"] intValue];
        for (int i = 0; i < [photoList count]; i++) {
            newPhoto = [[Photo alloc]init];
            newPhoto.photoID = [[[photoList objectAtIndex:i] objectForKey:@"id"] intValue];
            newPhoto.photoURL = [[photoList objectAtIndex:i] objectForKey:@"url"];
            newPhoto.thumbURL = [[photoList objectAtIndex:i] objectForKey:@"thumb"];
            newPhoto.name = [[photoList objectAtIndex:i] objectForKey:@"caption"];
            newPhoto.shareLink = [[photoList objectAtIndex:i] objectForKey:@"shareLink"];
            newPhoto.likeCount = [[[photoList objectAtIndex:i]objectForKey:@"likes"] intValue];
            newPhoto.dislikeCount = [[[photoList objectAtIndex:i]objectForKey:@"dislikes"] intValue];
            newPhoto.commentCount = [[[photoList objectAtIndex:i]objectForKey:@"commentCount"] intValue];
            newPhoto.isLiked = [[[photoList objectAtIndex:i]objectForKey:@"liked"] boolValue];
            newPhoto.isDisliked = [[[photoList objectAtIndex:i]objectForKey:@"disliked"] boolValue];
            [albumObj.photos addObject:newPhoto];
            [newPhoto release];
        }
    }
    
    return albumObj;
}

+(Category *)PhotoComments:(NSDictionary *)dict Comment:(Category *)albumObj {

    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    Comment *commentObj;
    NSArray *commentList = [dict objectForKey:@"comments"];
    for (int i = 0; i < [commentList count]; i++) {
        commentObj = [[Comment alloc]init ];
        commentObj.thumbURL = [[commentList objectAtIndex:i] objectForKey:@"user_avatar"];
        commentObj.commentId = [[[commentList objectAtIndex:i] objectForKey:@"id"] intValue];
        commentObj.commentText = [[commentList objectAtIndex:i] objectForKey:@"comment"];
        commentObj.dateTime = [[commentList objectAtIndex:i] objectForKey:@"date"];
        commentObj.isProfileView = [[[commentList objectAtIndex:i] objectForKey:@"profile"] boolValue];
        commentObj.userId = [[[commentList objectAtIndex:i] objectForKey:@"user_id"] intValue];
        commentObj.creatorname = [[commentList objectAtIndex:i] objectForKey:@"user_name"];
        commentObj.isDeleteAllowed = [[[commentList objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
        [albumObj.commentList addObject:commentObj];
        [commentObj release];
    }
    return albumObj;
}

+(Photo *)PhotoComment:(NSDictionary *)dict Comment:(Photo *)photoObj {

    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    Comment *commentObj;
    NSArray *commentList = [dict objectForKey:@"comments"];
    for (int i = 0; i < [commentList count]; i++) {
        commentObj = [[Comment alloc]init ];
        commentObj.thumbURL = [[commentList objectAtIndex:i] objectForKey:@"user_avatar"];
        commentObj.commentId = [[[commentList objectAtIndex:i] objectForKey:@"id"] intValue];
        commentObj.commentText = [[commentList objectAtIndex:i] objectForKey:@"comment"];
        commentObj.dateTime = [[commentList objectAtIndex:i] objectForKey:@"date"];
        commentObj.isProfileView = [[[commentList objectAtIndex:i] objectForKey:@"profile"] boolValue];
        commentObj.userId = [[[commentList objectAtIndex:i] objectForKey:@"user_id"] intValue];
        commentObj.creatorname = [[commentList objectAtIndex:i] objectForKey:@"user_name"];
        commentObj.isDeleteAllowed = [[[commentList objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
        [photoObj.commentList addObject:commentObj];
        [commentObj release];
    }
    return photoObj;
}

+(NSMutableArray *)getPhoneBook {
    ABAddressBookRef addressBook = ABAddressBookCreate(); // create address book reference object
    NSArray *abContactArray = (NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook); // get address book contact array
    [[ApplicationData sharedInstance].contactsArray removeAllObjects];
    NSInteger totalContacts =[abContactArray count];
    Option *optionObj;
    for(NSUInteger loop= 0 ; loop < totalContacts; loop++)
    {
        optionObj = [[Option alloc]init];
        ABRecordRef record = (ABRecordRef)[abContactArray objectAtIndex:loop]; // get address book record
        
        if(ABRecordGetRecordType(record) ==  kABPersonType) // this check execute if it is person group
        {
//            ABRecordID recordId = ABRecordGetRecordID(record); // get record id from address book record
            
//            NSString *recordIdString = [NSString stringWithFormat:@"%d",recordId]; // get record id string from record id
            
            NSString *firstNameString = (NSString*)ABRecordCopyValue(record,kABPersonFirstNameProperty); // fetch contact first name from address book
            NSString *lastNameString = (NSString*)ABRecordCopyValue(record,kABPersonLastNameProperty); // fetch contact last name from address book
            ABMultiValueRef emails = ABRecordCopyValue(record, kABPersonEmailProperty);
            CFStringRef email = ABMultiValueCopyValueAtIndex(emails, 0) ;
            optionObj.name = [NSString stringWithFormat:@"%@ %@",firstNameString,lastNameString];
            optionObj.value = (NSString *)email;//[NSString stringWithFormat:@"%@",(NSString*)ABRecordCopyValue(record,kABPersonEmailProperty)];
            [[ApplicationData sharedInstance].contactsArray addObject:optionObj];
            [optionObj release];
        }
    }
    return [ApplicationData sharedInstance].contactsArray;
}

+(User *)videoList:(NSDictionary *)dict Video:(User *)userObj {

    NSArray *videoList;
    Video *newVideo;
//    User *tempUser = [[User alloc]init];
    if ([[dict valueForKey:@"code"] intValue] == 200)
    {
        
        //counts get
        [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
        [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
        [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
        iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
        if ([ApplicationData sharedInstance].frndCount > 0) {
            [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
            appDelegate.btnFriendCount.hidden = NO;
        }else {
            appDelegate.btnFriendCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].msgCount > 0) {
            [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
            appDelegate.btnMsgCount.hidden = NO;
        }else {
            appDelegate.btnMsgCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].groupCount > 0) {
            [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
            appDelegate.btnGroupCount.hidden = NO;
        }else {
            appDelegate.btnGroupCount.hidden = YES;
        }
        
        videoList = [dict objectForKey:@"videos"];
        NSLog(@"%@",[videoList objectAtIndex:0]);
        for (int i = 0; i < [videoList count]; i++) {
            newVideo = [[Video alloc]init];
            newVideo.videoID = [[[videoList objectAtIndex:i] objectForKey:@"id"] intValue];
            newVideo.videoTitle = [[videoList objectAtIndex:i] objectForKey:@"caption"];
            newVideo.videoDesc = [[videoList objectAtIndex:i] objectForKey:@"description"];
            newVideo.videoThumbUrl = [[videoList objectAtIndex:i] objectForKey:@"thumb"];
            newVideo.videoURL = [[videoList objectAtIndex:i] objectForKey:@"url"];
            newVideo.userId = [[[videoList objectAtIndex:i] objectForKey:@"user_id"] intValue];
            newVideo.userName = [[videoList objectAtIndex:i] objectForKey:@"user_name"];
            newVideo.isLiked = [[[videoList objectAtIndex:i] objectForKey:@"liked"] boolValue];
            newVideo.isDisliked = [[[videoList objectAtIndex:i] objectForKey:@"disliked"] boolValue];
            newVideo.isDeleteAllowed = [[[videoList objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
            newVideo.isProfileView = [[[videoList objectAtIndex:i] objectForKey:@"profile"] boolValue];
            newVideo.likes = [[[videoList objectAtIndex:i] objectForKey:@"likes"] intValue];
            newVideo.disllikes = [[[videoList objectAtIndex:i] objectForKey:@"dislikes"] intValue];
            newVideo.comments = [[[videoList objectAtIndex:i] objectForKey:@"commentCount"] intValue];
            newVideo.shareLink = [[videoList objectAtIndex:i] objectForKey:@"shareLink"];
            newVideo.date = [[videoList objectAtIndex:i] objectForKey:@"date"];
            newVideo.location = [[videoList objectAtIndex:i] objectForKey:@"location"];
            
            newVideo.tags = [[[videoList objectAtIndex:i] objectForKey:@"tags"] intValue];
            newVideo.user_profile = [[[videoList objectAtIndex:i] objectForKey:@"user_profile"] intValue];
            newVideo.categoryId = [[[videoList objectAtIndex:i] objectForKey:@"categoryId"] intValue];
            newVideo.user_avatar = [[videoList objectAtIndex:i] objectForKey:@"user_avatar"];
            newVideo.permissions = [[[videoList objectAtIndex:i] objectForKey:@"permissions"] intValue];
            
            [userObj.videoListarray addObject:newVideo];
            [newVideo release];
        }
    }
    return userObj;
}
/*+(User *)videoList:(NSDictionary *)dict Video:(User *)userObj {
    NSArray *videoList;
    Video *newVideo;
    if ([[dict valueForKey:@"code"] intValue] == 200)
    {
        
        //counts get
        [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
        [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
        [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
        iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
        if ([ApplicationData sharedInstance].frndCount > 0) {
            [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
            appDelegate.btnFriendCount.hidden = NO;
        }else {
            appDelegate.btnFriendCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].msgCount > 0) {
            [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
            appDelegate.btnMsgCount.hidden = NO;
        }else {
            appDelegate.btnMsgCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].groupCount > 0) {
            [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
            appDelegate.btnGroupCount.hidden = NO;
        }else {
            appDelegate.btnGroupCount.hidden = YES;
        }
        
        videoList = [dict objectForKey:@"videos"];

        for (int i = 0; i < [videoList count]; i++) {
            newVideo = [[Video alloc]init];
            newVideo.videoID = [[[videoList objectAtIndex:i] objectForKey:@"id"] intValue];
            newVideo.videoTitle = [[videoList objectAtIndex:i] objectForKey:@"caption"];
            newVideo.videoDesc = [[videoList objectAtIndex:i] objectForKey:@"description"];
            newVideo.videoThumbUrl = [[videoList objectAtIndex:i] objectForKey:@"thumb"];
            newVideo.videoURL = [[videoList objectAtIndex:i] objectForKey:@"url"];
            newVideo.userId = [[[videoList objectAtIndex:i] objectForKey:@"user_id"] intValue];
            newVideo.userName = [[videoList objectAtIndex:i] objectForKey:@"user_name"];
            newVideo.isLiked = [[[videoList objectAtIndex:i] objectForKey:@"liked"] boolValue];
            newVideo.isDisliked = [[[videoList objectAtIndex:i] objectForKey:@"disliked"] boolValue];
            newVideo.isDeleteAllowed = [[[videoList objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
            newVideo.isProfileView = [[[videoList objectAtIndex:i] objectForKey:@"profile"] boolValue];
            newVideo.likes = [[[videoList objectAtIndex:i] objectForKey:@"likes"] intValue];
            newVideo.disllikes = [[[videoList objectAtIndex:i] objectForKey:@"dislikes"] intValue];
            newVideo.comments = [[[videoList objectAtIndex:i] objectForKey:@"commentCount"] intValue];
            newVideo.shareLink = [[videoList objectAtIndex:i] objectForKey:@"shareLink"];
            newVideo.date = [[videoList objectAtIndex:i] objectForKey:@"date"];
            newVideo.location = [[videoList objectAtIndex:i] objectForKey:@"location"];
            
            newVideo.tags = [[[videoList objectAtIndex:i] objectForKey:@"tags"] intValue];
            newVideo.user_profile = [[[videoList objectAtIndex:i] objectForKey:@"user_profile"] intValue];
            newVideo.categoryId = [[[videoList objectAtIndex:i] objectForKey:@"categoryId"] intValue];
            newVideo.user_avatar = [[videoList objectAtIndex:i] objectForKey:@"user_avatar"];
            newVideo.permissions = [[[videoList objectAtIndex:i] objectForKey:@"permissions"] intValue];
            
            [userObj.videoListarray addObject:newVideo];
            [newVideo release];
        }
    }
    return userObj;
}*/

+(int)AllvideoListFinal:(NSDictionary *)dict
{
    NSArray *videoList;
    Video *newVideo;
    if ([[dict valueForKey:@"code"] intValue] == 200)
    {
        
        //counts get
        [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
        [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
        [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
        iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
        if ([ApplicationData sharedInstance].frndCount > 0) {
            [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
            appDelegate.btnFriendCount.hidden = NO;
        }else {
            appDelegate.btnFriendCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].msgCount > 0) {
            [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
            appDelegate.btnMsgCount.hidden = NO;
        }else {
            appDelegate.btnMsgCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].groupCount > 0) {
            [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
            appDelegate.btnGroupCount.hidden = NO;
        }else {
            appDelegate.btnGroupCount.hidden = YES;
        }
        
        videoList = [dict objectForKey:@"videos"];

        for (int i = 0; i < [videoList count]; i++)
        {
            newVideo = [[Video alloc]init];
            newVideo.videoID = [[[videoList objectAtIndex:i] objectForKey:@"id"] intValue];
            newVideo.videoTitle = [[videoList objectAtIndex:i] objectForKey:@"caption"];
            newVideo.videoDesc = [[videoList objectAtIndex:i] objectForKey:@"description"];
            newVideo.videoThumbUrl = [[videoList objectAtIndex:i] objectForKey:@"thumb"];
            newVideo.videoURL = [[videoList objectAtIndex:i] objectForKey:@"url"];
            newVideo.userId = [[[videoList objectAtIndex:i] objectForKey:@"user_id"] intValue];
            newVideo.userName = [[videoList objectAtIndex:i] objectForKey:@"user_name"];
            newVideo.isLiked = [[[videoList objectAtIndex:i] objectForKey:@"liked"] boolValue];
            newVideo.isDisliked = [[[videoList objectAtIndex:i] objectForKey:@"disliked"] boolValue];
            newVideo.isDeleteAllowed = [[[videoList objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
            newVideo.isProfileView = [[[videoList objectAtIndex:i] objectForKey:@"profile"] boolValue];
            newVideo.likes = [[[videoList objectAtIndex:i] objectForKey:@"likes"] intValue];
            newVideo.disllikes = [[[videoList objectAtIndex:i] objectForKey:@"dislikes"] intValue];
            newVideo.comments = [[[videoList objectAtIndex:i] objectForKey:@"commentCount"] intValue];
            newVideo.shareLink = [[videoList objectAtIndex:i] objectForKey:@"shareLink"];
            newVideo.date = [[videoList objectAtIndex:i] objectForKey:@"date"];
            newVideo.location = [[videoList objectAtIndex:i] objectForKey:@"location"];
            
            newVideo.tags = [[[videoList objectAtIndex:i] objectForKey:@"tags"] intValue];
            newVideo.user_profile = [[[videoList objectAtIndex:i] objectForKey:@"user_profile"] intValue];
            newVideo.categoryId = [[[videoList objectAtIndex:i] objectForKey:@"categoryId"] intValue];
            newVideo.user_avatar = [[videoList objectAtIndex:i] objectForKey:@"user_avatar"];
            newVideo.permissions = [[[videoList objectAtIndex:i] objectForKey:@"permissions"] intValue];
            
            [[ApplicationData sharedInstance].AllVideos addObject:newVideo];
            [newVideo release];
        }
    }
    return [[ApplicationData sharedInstance].AllVideos count];
}

+(Category *)AllvideoList:(NSDictionary *)dict Video:(Category *)videoObj {

    NSArray *videoList;
    Video *newVideo;
    if ([[dict valueForKey:@"code"] intValue] == 200)
    {
        //counts get
        [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
        [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
        [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
        iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
        if ([ApplicationData sharedInstance].frndCount > 0) {
            [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
            appDelegate.btnFriendCount.hidden = NO;
        }else {
            appDelegate.btnFriendCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].msgCount > 0) {
            [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
            appDelegate.btnMsgCount.hidden = NO;
        }else {
            appDelegate.btnMsgCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].groupCount > 0) {
            [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
            appDelegate.btnGroupCount.hidden = NO;
        }else {
            appDelegate.btnGroupCount.hidden = YES;
        }
        
        videoList = [dict objectForKey:@"videos"];
        for (int i = 0; i < [videoList count]; i++) {
            newVideo = [[Video alloc]init];
            newVideo.videoID = [[[videoList objectAtIndex:i] objectForKey:@"id"] intValue];
            newVideo.videoTitle = [[videoList objectAtIndex:i] objectForKey:@"caption"];
            newVideo.videoDesc = [[videoList objectAtIndex:i] objectForKey:@"desc"];
            newVideo.videoThumbUrl = [[videoList objectAtIndex:i] objectForKey:@"thumb"];
            newVideo.videoURL = [[videoList objectAtIndex:i] objectForKey:@"url"];
            newVideo.userId = [[[videoList objectAtIndex:i] objectForKey:@"user_id"] intValue];
            newVideo.userName = [[videoList objectAtIndex:i] objectForKey:@"user_name"];
            newVideo.isLiked = [[[videoList objectAtIndex:i] objectForKey:@"liked"] boolValue];
            newVideo.isDisliked = [[[videoList objectAtIndex:i] objectForKey:@"disliked"] boolValue];
            newVideo.isDeleteAllowed = [[[videoList objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
            newVideo.isProfileView = [[[videoList objectAtIndex:i] objectForKey:@"profile"] boolValue];
            newVideo.likes = [[[videoList objectAtIndex:i] objectForKey:@"likes"] intValue];
            newVideo.disllikes = [[[videoList objectAtIndex:i] objectForKey:@"dislikes"] intValue];
            newVideo.comments = [[[videoList objectAtIndex:i] objectForKey:@"commentCount"] intValue];
            newVideo.shareLink = [[videoList objectAtIndex:i] objectForKey:@"share_link"];
            newVideo.date = [[videoList objectAtIndex:i] objectForKey:@"date"];
            newVideo.location = [[videoList objectAtIndex:i] objectForKey:@"location"];
            [videoObj.photos addObject:newVideo];
            [newVideo release];
        }
    }
    return videoObj;
}

+(Video *)videoComments:(NSDictionary *)dict Comment:(Video *)videoObj
{
    
    //counts get
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;         
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    Comment *commentObj;
    //    [photoObj.commentList removeAllObjects];
    NSArray *commentList = [dict objectForKey:@"comments"];
    for (int i = 0; i < [commentList count]; i++) {
        commentObj = [[Comment alloc]init ];
        commentObj.thumbURL = [[commentList objectAtIndex:i] objectForKey:@"user_avatar"];
        commentObj.commentId = [[[commentList objectAtIndex:i] objectForKey:@"id"] intValue];
        commentObj.commentText = [[commentList objectAtIndex:i] objectForKey:@"comment"];
        commentObj.dateTime = [[commentList objectAtIndex:i] objectForKey:@"date"];
        commentObj.isProfileView = [[[commentList objectAtIndex:i] objectForKey:@"profile"] boolValue];
        commentObj.userId = [[[commentList objectAtIndex:i] objectForKey:@"user_id"] intValue];
        commentObj.creatorname = [[commentList objectAtIndex:i] objectForKey:@"user_name"];
        commentObj.isDeleteAllowed = [[[commentList objectAtIndex:i] objectForKey:@"deleteAllowed"] boolValue];
        [videoObj.commentList addObject:commentObj];
        [commentObj release];
    }
    return videoObj;
}

+(NSMutableArray *)videocategories:(NSDictionary *)dict
{
    //counts get
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
   //video category function.
    NSArray *arrvideocat = [[NSArray alloc] initWithArray:[dict objectForKey:@"categories"]];
   
    NSMutableArray *arrcat = [[NSMutableArray alloc]init];
    for (int i = 0; i < [arrvideocat count]; i++)
    {
        videocategories *Videocat = [[videocategories alloc] init];
        
        Videocat.code = [[dict objectForKey:@"code"] intValue];
        Videocat.count = [[[arrvideocat objectAtIndex:i] objectForKey:@"count"] intValue];
        Videocat.Id = [[[arrvideocat objectAtIndex:i] objectForKey:@"id"] intValue];
        Videocat.strdesc = [[arrvideocat objectAtIndex:i] objectForKey:@"desc"];
        Videocat.strname = [[arrvideocat objectAtIndex:i] objectForKey:@"name"];
        
        [arrcat addObject:Videocat];
        [Videocat release];
    }
    return arrcat;
}

+(BOOL)Applicationconfigration:(NSDictionary *)dict
{

    NSDictionary *configuration = [dict objectForKey:@"configuration"];

    ConfigData *config = [[ConfigData alloc] init];
    
    int kl = [config CheckTableExist:[NSString stringWithFormat:@"GlobalCon_Theme"]];
    if (kl == 1) {
        
        kl = [config DropTable:@"GlobalCon_Theme"];
    }
//    else
//    {
        NSString *Query ;//= [iCMS Createtablestring:arrallkey allvalues:values];
        Query = [NSString stringWithFormat:@"CREATE TABLE GlobalCon_Theme (Viewname TEXT, Tab_URL TEXT, Tabactive_URL TEXT, Icon_URL TEXT, TabPath TEXT, TabactivePath TEXT, iconpath TEXT)"];
        
        [config CreateTable:Query];
    //}
    
    //NSDictionary *globalconfig = [configuration objectForKey:@"globalconfig"];
    [ApplicationData sharedInstance].dictGlobalConfig = [configuration objectForKey:@"globalconfig"];
    [ApplicationData sharedInstance].dictextentionconfig = [configuration objectForKey:@"extentionconfig"];
    
    NSLog(@"dict %@",[[[ApplicationData sharedInstance].dictextentionconfig objectForKey:@"jomsocial"] objectForKey:@"isEnableVoice"]);
    
        
    NSArray *arrmenu = [[NSArray alloc] initWithArray:[configuration objectForKey:@"menus"]];
    NSArray *arrtheme = [[NSArray alloc] initWithArray:[configuration objectForKey:@"theme"]];

    [config deleteData:@"delete from GlobalCon_Theme"];
    [[ApplicationData sharedInstance].arr_Themeglobal_List removeAllObjects];
    for (int i = 0; i< [arrtheme count]; i++)
    {
        NSDictionary *dicttheme = [arrtheme objectAtIndex:i];
        AppconfigThemedetail *apptheme = [[AppconfigThemedetail alloc] init];
        
        apptheme.viewname = [dicttheme objectForKey:@"viewname"];
        apptheme.tab_URL = [dicttheme objectForKey:@"tab"];
        
        NSArray *tabpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *tabdocuments = [tabpaths objectAtIndex:0];
        NSString *tabfinalPath = [tabdocuments stringByAppendingPathComponent:[NSString stringWithFormat:@"%@tab.png",apptheme.viewname]];
        apptheme.tab_imgpath = tabfinalPath;
        dispatch_queue_t tabimageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
        
//         NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:apptheme.tab_URL]];
//        [data writeToFile:tabfinalPath atomically:YES];
        dispatch_async(tabimageQueue, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:apptheme.tab_URL]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [data writeToFile:tabfinalPath atomically:YES];
            });
        });
        
        apptheme.tab_active_URL = [dicttheme objectForKey:@"tab_active"];
        
        NSArray *tab_activepaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *tab_activedocuments = [tab_activepaths objectAtIndex:0];
        NSString *tab_activefinalPath = [tab_activedocuments stringByAppendingPathComponent:[NSString stringWithFormat:@"%@tab_active.png",apptheme.viewname]];
        apptheme.tab_active_imgpath = tab_activefinalPath;
        dispatch_queue_t tab_activeimageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
//        NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:apptheme.tab_active_URL]];
//        [data1 writeToFile:tab_activefinalPath atomically:YES];
        dispatch_async(tab_activeimageQueue, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:apptheme.tab_active_URL]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [data writeToFile:tab_activefinalPath atomically:YES];
            });
            
        });
        
        apptheme.icon_URL = [dicttheme objectForKey:@"icon"];
        NSArray *iconpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *icondocuments = [iconpaths objectAtIndex:0];
        NSString *iconfinalPath = [icondocuments stringByAppendingPathComponent:[NSString stringWithFormat:@"%@icon.png",apptheme.viewname]];
        apptheme.icon_imgpath = iconfinalPath;
        dispatch_queue_t iconimageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
//        NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:apptheme.icon_URL]];
//        [data2 writeToFile:iconfinalPath atomically:YES];
        
        dispatch_async(iconimageQueue, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:apptheme.icon_URL]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [data writeToFile:iconfinalPath atomically:YES];
            });
            
        });
        
        NSString *str1 = [NSString stringWithFormat:@"INSERT INTO GlobalCon_Theme (Viewname, Tab_URL, Tabactive_URL, Icon_URL, TabPath, TabactivePath, iconpath) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@');",apptheme.viewname, apptheme.tab_URL, apptheme.tab_active_URL, apptheme.icon_URL, apptheme.tab_imgpath, apptheme.tab_active_imgpath, apptheme.icon_imgpath];
        
        [config insertData:str1];
        [[ApplicationData sharedInstance].arr_Themeglobal_List addObject:apptheme];
        [apptheme release];
    }
    
    
    kl = [config CheckTableExist:[NSString stringWithFormat:@"Menus"]];
    if (kl == 1) {
        
        kl = [config DropTable:@"Menus"];
        //        NSString *Query ;//= [iCMS Createtablestring:arrallkey allvalues:values];
        //        Query = [NSString stringWithFormat:@"DELETE FROM GlobalCon_Theme"];
        //        [config deleteData:Query];
    }
    //    else
    //    {
    NSString *Query1 ;//= [iCMS Createtablestring:arrallkey allvalues:values];
    Query1 = [NSString stringWithFormat:@"CREATE TABLE Menus (menuid INTEGER, menuposition INTEGER, menuname TEXT, screens TEXT, menuitem TEXT)"];
    
    [config CreateTable:Query1];
    
    
    [config deleteData:@"delete from Menus"];
    for (int i = 0; i < [arrmenu count]; i++)
    {
        NSDictionary *dicmenuitem = [arrmenu objectAtIndex:i];
        AllMenudetail *allmenude = [[AllMenudetail alloc] init];
        
        allmenude.menuid = [[dicmenuitem objectForKey:@"menuid"] intValue];
        allmenude.menuposition = [[dicmenuitem objectForKey:@"menuposition"] integerValue];
        allmenude.menuname = [dicmenuitem objectForKey:@"menuname"];
//        NSMutableArray *arrscreentmp = [[NSMutableArray alloc] initWithArray:[dicmenuitem objectForKey:@"screens"]];
        NSDictionary *dictscreen = [[NSDictionary alloc] initWithObjectsAndKeys:[dicmenuitem objectForKey:@"screens"],@"screens", nil];
        NSString* jsonStringscreen = [dictscreen JSONString];
       // allmenude.arrMenuscreens = arrscreentmp;
        
       // NSMutableArray *arritem = [[NSMutableArray alloc] initWithArray:[dicmenuitem objectForKey:@"menuitem"]];//get all menu item in local aaray.
        NSDictionary *dictmenuitem = [[NSDictionary alloc] initWithObjectsAndKeys:[dicmenuitem objectForKey:@"menuitem"],@"menuitem", nil];
        NSString* jsonStringmenu = [dictmenuitem JSONString];
        
        NSString *str1 = [NSString stringWithFormat:@"INSERT INTO Menus (menuid, menuposition, menuname, screens, menuitem) VALUES ('%d', '%d', '%@', '%@', '%@');",allmenude.menuid, allmenude.menuposition, allmenude.menuname, jsonStringscreen, jsonStringmenu];
      
        [config insertData:str1];
    }
        
    //application configration function.
    return YES;
}

- (void)applicationconfigImagesdownloadfromURL
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *finalPath = [documents stringByAppendingPathComponent:@"myImageName.png"];
    
    dispatch_queue_t imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
    
    dispatch_async(imageQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com/images/srpr/logo3w.png"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [data writeToFile:finalPath atomically:YES];
        });
        
    });

}


//get menu list.
+(NSMutableArray *)ApplicationMenulist:(NSString *)screenname menuposition:(int)menupos
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSString *str;
    if (menupos == 1)
    {
        
        str = [NSString stringWithFormat:@"SELECT * FROM Menus where menuposition = %d;", menupos];
    }
    else
    {
        str = [NSString stringWithFormat:@"SELECT * FROM Menus where menuposition = %d and screens like '#%@#';", menupos, screenname];
    }

    ConfigData *config = [[ConfigData alloc] init];
    arr = [config getData:str];
    
    return arr;
}

+(NSMutableArray *)Applicationtheme //get theme.
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSString *str = [NSString stringWithFormat:@"SELECT * FROM GlobalCon_Theme;"];
    [[ApplicationData sharedInstance].arr_Themeglobal_List removeAllObjects];
    ConfigData *config = [[ConfigData alloc] init];
    arr = [config gettheme:str];
    
    return arr;
}

+(int)MessagesConversationList:(NSDictionary *)dict
{
    //counts get
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    NSArray *arr = [[NSArray alloc] initWithArray:[dict objectForKey:@"messages"]];
    for (int i = 0; i < [arr count]; i++)
    {
        
        Messages *messageobj = [[Messages alloc] init];
        
        messageobj.ID = [[[arr objectAtIndex:i] objectForKey:@"id"] intValue];
        messageobj.outgoing = [[[arr objectAtIndex:i] objectForKey:@"outgoing"] intValue];
        messageobj.user_id = [[[arr objectAtIndex:i] objectForKey:@"user_id"] intValue];
        messageobj.user_profile = [[[arr objectAtIndex:i] objectForKey:@"user_profile"] intValue];
        
        messageobj.msgRead = [[[arr objectAtIndex:i] objectForKey:@"read"] boolValue];
        
        messageobj.msgDate = [[arr objectAtIndex:i] objectForKey:@"date"];
        messageobj.subject = [[arr objectAtIndex:i] objectForKey:@"subject"];
        messageobj.user_avatar = [[arr objectAtIndex:i] objectForKey:@"user_avatar"];
        messageobj.user_name = [[arr objectAtIndex:i] objectForKey:@"user_name"];
        
        [[ApplicationData sharedInstance].inboxList addObject:messageobj];
        [messageobj release];
    }
    return [[ApplicationData sharedInstance].inboxList count];
}

+(NSMutableArray *)MessagesDetailList:(NSDictionary *)dict
{
    //counts get
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    NSArray *arr = [[NSArray alloc] initWithArray:[dict objectForKey:@"messages"]];
    NSMutableArray *arrreplaylist = [[NSMutableArray alloc] init];
    for (int i = 0; i < [arr count]; i++)
    {
        Messages *messageobj = [[Messages alloc] init];
        
        messageobj.ID = [[[arr objectAtIndex:i] objectForKey:@"id"] intValue];
        messageobj.outgoing = [[[arr objectAtIndex:i] objectForKey:@"outgoing"] intValue];
        messageobj.user_id = [[[arr objectAtIndex:i] objectForKey:@"user_id"] intValue];
        messageobj.user_profile = [[[arr objectAtIndex:i] objectForKey:@"user_profile"] intValue];
        
        messageobj.msgRead = [[[arr objectAtIndex:i] objectForKey:@"read"] boolValue];
        
        messageobj.msgDate = [[arr objectAtIndex:i] objectForKey:@"date"];
        messageobj.body = [[arr objectAtIndex:i] objectForKey:@"body"];
        messageobj.user_avatar = [[arr objectAtIndex:i] objectForKey:@"user_avatar"];
        messageobj.user_name = [[arr objectAtIndex:i] objectForKey:@"user_name"];
        
        [arrreplaylist addObject:messageobj];
        [messageobj release];
    }
    return arrreplaylist;
}

/////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////Joomsocial Group///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

+(int)GroupcategoriesList:(NSDictionary *)dict
{
    //counts get
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    NSArray *arrcatlist = [[NSArray alloc] initWithArray:[dict objectForKey:@"categories"]];
    for (int i = 0; i < [arrcatlist count]; i++)
    {
        
        Category *newCategory = [[Category alloc] init];
        
        newCategory.categories = [[[arrcatlist objectAtIndex:i] objectForKey:@"categories"] intValue];
        newCategory.groups = [[[arrcatlist objectAtIndex:i] objectForKey:@"groups"] intValue];
        newCategory.Id = [[[arrcatlist objectAtIndex:i] objectForKey:@"id"] intValue];
        newCategory.parent = [[[arrcatlist objectAtIndex:i] objectForKey:@"parent"] intValue];
        newCategory.name = [[arrcatlist objectAtIndex:i] objectForKey:@"name"];
        newCategory.description = [[arrcatlist objectAtIndex:i] objectForKey:@"description"];
        newCategory.subCategoryList = (NSMutableArray *)[[arrcatlist objectAtIndex:i] objectForKey:@"subCategory"];

        [[ApplicationData sharedInstance].groupCategoryList addObject:newCategory];
        [newCategory release];

    }
    return [[ApplicationData sharedInstance].groupCategoryList count];
}

+(NSMutableArray *)GroupList:(NSDictionary *)dict {

    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    NSArray *arrcatlist = [[NSArray alloc] initWithArray:[dict objectForKey:@"groups"]];
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [arrcatlist count]; i++)
    {
        Group *newCategory = [[Group alloc] init];
        newCategory.thumbURL = [[arrcatlist objectAtIndex:i] objectForKey:@"avatar"];
        newCategory.totalDiscussions = [[[arrcatlist objectAtIndex:i] objectForKey:@"discussions"] intValue];
        newCategory.Id = [[[arrcatlist objectAtIndex:i] objectForKey:@"id"] intValue];
        newCategory.totalMembers = [[[arrcatlist objectAtIndex:i] objectForKey:@"members"] intValue];
        newCategory.totalWall = [[[arrcatlist objectAtIndex:i] objectForKey:@"walls"] intValue];
        newCategory.name = [[arrcatlist objectAtIndex:i] objectForKey:@"title"];
        newCategory.description = [[arrcatlist objectAtIndex:i] objectForKey:@"description"];
        [tempArray addObject:newCategory];
        [newCategory release];
    }
    return tempArray;
}


+(void)GroupFieldsList:(NSDictionary *)dict {
    //    NSMutableArray *fieldList = [[NSMutableArray alloc]init];
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    [[ApplicationData sharedInstance].groupFieldsArray removeAllObjects];
  
    [[ApplicationData sharedInstance].eventFieldsArray removeAllObjects];
     NSArray *tempArray = [dict objectForKey:@"fields"];
    int i = 1;
    for (NSDictionary *tempDict in tempArray) {
        UserInfo *fieldObj = [[UserInfo alloc]init];
        fieldObj.fieldId = i;//[NSString stringWithFormat:@"%d",i];
        fieldObj.fieldName = [tempDict objectForKey:@"caption"];
        fieldObj.fieldType = [tempDict objectForKey:@"type"];
        fieldObj.isRequired = [[tempDict objectForKey:@"required"] boolValue];
        fieldObj.fieldValue = [tempDict objectForKey:@"value"];
        fieldObj.fieldTempValue = [tempDict objectForKey:@"value"];
        if ([fieldObj.fieldValue isKindOfClass:[NSNumber class]]) {
            fieldObj.fieldValue = [[tempDict objectForKey:@"value"] stringValue];
            fieldObj.fieldTempValue = [[tempDict objectForKey:@"value"] stringValue];
        }
        fieldObj.fieldCaption = [tempDict objectForKey:@"name"];
        NSArray *optionsArray = [tempDict objectForKey:@"options"];
        for (NSDictionary *optDict in optionsArray) {
            Option *optionObj = [[Option alloc]init];
            optionObj.name = [optDict valueForKey:@"name"];
            optionObj.value = [optDict valueForKey:@"value"];
            
            if ([optionObj.value isKindOfClass:[NSNumber class]]) {
                optionObj.value = [[optDict objectForKey:@"value"] stringValue];
            }
            if ([optionObj.name isEqualToString:@"None"]) {
                optionObj.value = @"none";
            }
            [fieldObj.optionList addObject:optionObj];
            [optionObj release];
        }
        if ([fieldObj.fieldType isEqualToString:@"checkbox"]) {
            fieldObj.fieldType = @"select";
            NSArray *arrName = [[NSArray alloc]initWithObjects:@"Yes", @"No", nil];
            NSArray *arrValue = [[NSArray alloc]initWithObjects:@"1", @"0", nil];
            for (int j = 0; j < [arrName count]; j++) {
                Option *optionObj = [[Option alloc]init];
                optionObj.name = [arrName objectAtIndex:j];
                optionObj.value = [arrValue objectAtIndex:j];
                [fieldObj.optionList addObject:optionObj];
                [optionObj release];
            }
        }
        if ([fieldObj.fieldType isEqualToString:@"map"]) {
           // fieldObj.fieldType = @"text";
        }
        if ([fieldObj.fieldType isEqualToString:@"dataetime"]) {
            fieldObj.fieldType = @"datetime";
        }
        
        [[ApplicationData sharedInstance].groupFieldsArray addObject:fieldObj];
        [fieldObj release];
        i++;
    }
    //    return fieldList;
}

+(NSMutableArray *)DiscussionList:(NSDictionary *)dict {
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    NSMutableArray *discussionArray = [[NSMutableArray alloc]init];
    NSArray *tempArray;
    if ([dict objectForKey:@"announcements"]) {
        tempArray = [dict objectForKey:@"announcements"];
    }else if ([dict objectForKey:@"replys"]) {
        tempArray = [dict objectForKey:@"replys"];
    }else {
        tempArray = [dict objectForKey:@"discussions"];
    }
    for (NSDictionary *discDict in tempArray) {
        Announcement *announcementObj = [[Announcement alloc]init];
        announcementObj.Id = [[discDict objectForKey:@"id"] intValue];
        announcementObj.title = [discDict objectForKey:@"title"];
        announcementObj.msg = [discDict objectForKey:@"message"];
        announcementObj.creator = [[discDict objectForKey:@"user_id"] intValue];
        announcementObj.name = [discDict objectForKey:@"user_name"];
        announcementObj.thumbUrl = [discDict objectForKey:@"user_avatar"];
        announcementObj.isProfileView = [[discDict objectForKey:@"user_profile"] boolValue];
        announcementObj.date = [discDict objectForKey:@"date"];
        announcementObj.isLocked = [[discDict objectForKey:@"isLocked"] boolValue];
        announcementObj.replies = [[discDict objectForKey:@"topics"] intValue];
        announcementObj.isFilePermission = [[discDict objectForKey:@"filePermission" ]boolValue];
        announcementObj.shareLink = [discDict objectForKey:@"shareLink"];
        announcementObj.files = [[discDict objectForKey:@"files"] intValue];
        [discussionArray addObject:announcementObj];
        [announcementObj release];
    }
    return discussionArray;
}

+(NSMutableArray *) GroupMemberlist :(NSDictionary *) dict {
    User *newFriend;
    NSMutableArray *userList = [[NSMutableArray alloc] init];
    if ([[dict valueForKey:@"code"] intValue] == 200) {
        [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
        [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
        [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
        iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
        if ([ApplicationData sharedInstance].frndCount > 0) {
            [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
            appDelegate.btnFriendCount.hidden = NO;
        }else {
            appDelegate.btnFriendCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].msgCount > 0) {
            [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
            appDelegate.btnMsgCount.hidden = NO;
        }else {
            appDelegate.btnMsgCount.hidden = YES;
        }
        
        if ([ApplicationData sharedInstance].groupCount > 0) {
            [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
            appDelegate.btnGroupCount.hidden = NO;
        }else {
            appDelegate.btnGroupCount.hidden = YES;
        }
        NSArray *arr_memberlist;
        if ([dict objectForKey:@"members"]) {
            arr_memberlist = [dict objectForKey:@"members"];
        }else if ([dict objectForKey:@"member"]) {
            arr_memberlist = [dict objectForKey:@"member"];
        }
        
        NSLog(@"arr_memberlist : %@",arr_memberlist);
        for (int i = 0; i < [arr_memberlist count]; i++)
        {
            newFriend = [[User alloc]init];
            newFriend.userId = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_id"] intValue];
            newFriend.userName = [[arr_memberlist objectAtIndex:i] objectForKey:@"user_name"];
            newFriend.thumbURL = [[arr_memberlist objectAtIndex:i] objectForKey:@"user_avatar"];
            newFriend.avatarURL = [[arr_memberlist objectAtIndex:i] objectForKey:@"user_avatar"];
            newFriend.status = [[arr_memberlist objectAtIndex:i] objectForKey:@"status"] ;
            newFriend.latitude = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_lat"] floatValue];
            newFriend.longitude = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_long"] floatValue];
            newFriend.online = [[[arr_memberlist objectAtIndex:i] objectForKey:@"user_online"] boolValue];
            if ([[arr_memberlist objectAtIndex:i] objectForKey:@"profile"]) {
                newFriend.profile =	[[[arr_memberlist objectAtIndex:i] objectForKey:@"profile"] boolValue];
            }else {
                newFriend.profile =	[[[arr_memberlist objectAtIndex:i] objectForKey:@"user_profile"] boolValue];
            }
            newFriend.canRemove = [[[arr_memberlist objectAtIndex:i] objectForKey:@"canRemove"] boolValue];
            newFriend.canUser = [[[arr_memberlist objectAtIndex:i] objectForKey:@"canMember"] boolValue];
            newFriend.canAdmin = [[[arr_memberlist objectAtIndex:i] objectForKey:@"canAdmin"] boolValue];
            newFriend.canBan = [[[arr_memberlist objectAtIndex:i] objectForKey:@"canBan"] boolValue];
            [userList addObject:newFriend];
            [newFriend release];
        }
    }
    NSLog(@"userList : %@",userList);
    return userList;
}

+(Group *)GroupDetail:(NSDictionary *)dict {
    NSLog(@"dict: %@",dict);
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    NSDictionary *fullDict = [dict objectForKey:@"group"];
    NSDictionary *adminMenuDict = [fullDict objectForKey:@"adminMenu"];
    NSDictionary *optionsDict = [fullDict objectForKey:@"option"];
    NSDictionary *MenuDict = [fullDict objectForKey:@"menu"];
    Group *groupObj = [[Group alloc]init];
    groupObj.catId = [[fullDict objectForKey:@"category_id"] intValue];
    groupObj.catName = [fullDict objectForKey:@"category_name"];
    groupObj.creatorid = [[fullDict objectForKey:@"user_id"] intValue];
    groupObj.creator = [fullDict objectForKey:@"user_name"];
    groupObj.isProfileAllowed = [[fullDict objectForKey:@"user_profile"] boolValue];
    groupObj.date = [fullDict objectForKey:@"date"];
    groupObj.no_like = [[fullDict objectForKey:@"likes"] intValue];
    groupObj.no_unlike = [[fullDict objectForKey:@"dislikes"] intValue];
    groupObj.isLike = [[fullDict objectForKey:@"liked"] boolValue];
    groupObj.isdisLike = [[fullDict objectForKey:@"disliked"] boolValue];
    groupObj.totalFiles = [[fullDict objectForKey:@"files"] intValue];
    groupObj.shareLink = [fullDict objectForKey:@"shareLink"];
    groupObj.isLikeAllowed = [[fullDict objectForKey:@"likeAllowed"] boolValue];
    groupObj.isinvite = [[fullDict objectForKey:@"isInvitation"] boolValue];
    groupObj.invitemsg = [fullDict objectForKey:@"invitationMessage"];
    groupObj.inviteurl = [fullDict objectForKey:@"invitationicon"];
    groupObj.isAdmin = [[fullDict objectForKey:@"isAdmin"] boolValue];
    groupObj.isCommunityAdmin = [[fullDict objectForKey:@"isCommunityAdmin"] boolValue];
    groupObj.isjoin = [[fullDict objectForKey:@"isJoin"] boolValue];
    groupObj.isBanned = [[fullDict objectForKey:@"isBanned"] boolValue];
    groupObj.isMember = [[fullDict objectForKey:@"isMember"] boolValue];
    groupObj.isPrivate = [[fullDict objectForKey:@"isPrivate"] boolValue];
    groupObj.isWaitingApproval = [[fullDict objectForKey:@"isWaitingApproval"] boolValue];
    groupObj.memberWaiting = [[fullDict objectForKey:@"memberWaiting"] intValue];
    
    //Menu flags Parsing
    groupObj.showShare = [[MenuDict objectForKey:@"shareGroup"] boolValue];
    groupObj.showReport = [[MenuDict objectForKey:@"reportGroup"] boolValue];
    groupObj.showCreateDiscussion = [[MenuDict objectForKey:@"createDiscussion"] boolValue];
    groupObj.showCreateEvent = [[MenuDict objectForKey:@"createEvent"] boolValue];
    groupObj.showUploadPhoto = [[MenuDict objectForKey:@"uploadPhoto"] boolValue];
    groupObj.showCreateAlbum = [[MenuDict objectForKey:@"createAlbum"] boolValue];
    groupObj.showAddVideo = [[MenuDict objectForKey:@"addVideo"] boolValue];
    groupObj.showJoinGroup = [[MenuDict objectForKey:@"joinGroup"] boolValue];
    groupObj.showInviteFrnd = [[MenuDict objectForKey:@"inviteFriend"] boolValue];
    groupObj.showLeaveGroup = [[MenuDict objectForKey:@"leaveGroup"] boolValue];
    
    groupObj.showEdit = [[adminMenuDict objectForKey:@"edit"] boolValue];
    groupObj.showEditAvatar = [[adminMenuDict objectForKey:@"editAvatar"] boolValue];
    groupObj.showSendMail = [[adminMenuDict objectForKey:@"sendMail"] boolValue];
    groupObj.showCreateAnnouncement = [[adminMenuDict objectForKey:@"createAnnouncement"] boolValue];
    groupObj.showUnpublishGroup = [[adminMenuDict objectForKey:@"unpublishGroup"] boolValue];
    groupObj.showDeleteGroup = [[adminMenuDict objectForKey:@"deleteGroup"] boolValue];
    
    groupObj.showMemberList = [[optionsDict objectForKey:@"memberList"] boolValue];
    groupObj.showalbumList = [[optionsDict objectForKey:@"albumList"] boolValue];
    groupObj.showvideoList = [[optionsDict objectForKey:@"videoList"] boolValue];
    groupObj.showeventList = [[optionsDict objectForKey:@"eventList"] boolValue];
    groupObj.showannouncementList = [[optionsDict objectForKey:@"announcementList"] boolValue];
    groupObj.showdiscussionList = [[optionsDict objectForKey:@"discussionList"] boolValue];
    groupObj.showwallList = [[optionsDict objectForKey:@"wallList"] boolValue];
    
    return groupObj;
}

+(NSMutableArray *)FileList:(NSDictionary *)dict {
    NSArray *tempArray;
    NSMutableArray *fileListArray = [[NSMutableArray alloc]init];
    [ApplicationData sharedInstance].errorCode = [[dict objectForKey:TAG_CODE] intValue];
    if ([ApplicationData sharedInstance].errorCode == 200) {
        tempArray = [dict objectForKey:@"files"];
        for (NSDictionary *fileDict in tempArray) {
            Wall *userObj = [[Wall alloc]init];
            userObj.wallId = [[fileDict objectForKey:@"id"] intValue];
            userObj.title  = [fileDict objectForKey:@"name"];
            userObj.thumbURL  = [fileDict objectForKey:@"url"];
            userObj.total_updates = [[fileDict objectForKey:@"size"] intValue];
            userObj.Likes = [[fileDict objectForKey:@"hits"] intValue];
            userObj.userdetail.userId = [[fileDict objectForKey:@"user_id"] intValue];
            userObj.userdetail.userName = [fileDict objectForKey:@"user_name"];
            userObj.liked = [[fileDict objectForKey:@"user_profile"] boolValue];
            userObj.date= [fileDict objectForKey:@"date"];
            userObj.isDeleteAllowed = [[fileDict objectForKey:@"deleteAllowed"] boolValue];
            [fileListArray addObject:userObj];
            [userObj release];
        }
    }
    return fileListArray;
}

/////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////Joomsocial Events///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

+(NSMutableArray *)EventList:(NSDictionary *)dict {
    NSLog(@"dict : %@",dict);
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    [ApplicationData sharedInstance].errorCode = [[dict objectForKey:TAG_CODE] intValue];
    NSArray *arrcatlist = [[NSArray alloc] initWithArray:[dict objectForKey:@"events"]];
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    [tempArray removeAllObjects];
    for (NSDictionary *eventDict in arrcatlist)
    {
        Event *newEvent = [[Event alloc] init];
        newEvent.Id = [[eventDict objectForKey:@"id"] intValue];
        newEvent.title = [eventDict objectForKey:@"title"];
        newEvent.locationName = [eventDict objectForKey:@"location"];
        newEvent.confirmedSeats = [[eventDict objectForKey:@"confirmed"] intValue];
        NSString *startDate = [eventDict objectForKey:@"startdate"];
        newEvent.time = [NSString stringWithFormat:@"%@ - %@",startDate,[eventDict objectForKey:@"enddate"]];
        newEvent.date = [eventDict objectForKey:@"date"];
        newEvent.thumbURL = [eventDict objectForKey:@"avatar"];
        [tempArray addObject:newEvent];
        [newEvent release];
    }
    return tempArray;
}

+(Event *)EventDetail:(NSDictionary *)dict {
    
    [ApplicationData sharedInstance].frndCount = [[[dict valueForKey:@"notification"] valueForKey:@"friendNotification"] intValue];
    [ApplicationData sharedInstance].msgCount = [[[dict valueForKey:@"notification"] valueForKey:@"messageNotification"] intValue];
    [ApplicationData sharedInstance].groupCount = [[[dict valueForKey:@"notification"] valueForKey:@"globalNotification"] intValue];
    iJoomerAppDelegate *appDelegate = (iJoomerAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([ApplicationData sharedInstance].frndCount > 0) {
        [appDelegate.btnFriendCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].frndCount] forState:UIControlStateNormal];
        appDelegate.btnFriendCount.hidden = NO;
    }else {
        appDelegate.btnFriendCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].msgCount > 0) {
        [appDelegate.btnMsgCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].msgCount] forState:UIControlStateNormal];
        appDelegate.btnMsgCount.hidden = NO;
    }else {
        appDelegate.btnMsgCount.hidden = YES;
    }
    
    if ([ApplicationData sharedInstance].groupCount > 0) {
        [appDelegate.btnGroupCount setTitle:[NSString stringWithFormat:@"%d",[ApplicationData sharedInstance].groupCount] forState:UIControlStateNormal];
        appDelegate.btnGroupCount.hidden = NO;
    }else {
        appDelegate.btnGroupCount.hidden = YES;
    }
    
    NSDictionary *fullDict = [dict objectForKey:@"event"];
    NSDictionary *MenuDict = [fullDict objectForKey:@"menu"];
    Event *eventObj = [[Event alloc]init];
    eventObj.showEditAvtar = [[MenuDict objectForKey:@"editAvatar"] boolValue];
    eventObj.showSendMail = [[MenuDict objectForKey:@"sendMail"] boolValue];
    eventObj.showEditEvent = [[MenuDict objectForKey:@"editEvent"] boolValue];
    eventObj.showInviteFriend = [[MenuDict objectForKey:@"inviteFriend"] boolValue];
    eventObj.showIgnoreEvent = [[MenuDict objectForKey:@"ignoreEvent"] boolValue];
    eventObj.showDeleteEvent = [[MenuDict objectForKey:@"deleteEvent"] boolValue];
    eventObj.showYourResponse = [[MenuDict objectForKey:@"yourResponse"] boolValue];
    eventObj.catName = [fullDict objectForKey:@"category"];
    eventObj.desc = [fullDict objectForKey:@"description"];
    eventObj.summary = [fullDict objectForKey:@"summary"];
    eventObj.eventCreatorId = [[fullDict objectForKey:@"user_id"] intValue];
    eventObj.createdBy = [fullDict objectForKey:@"user_name"];
    eventObj.latitude = [[fullDict objectForKey:@"lat"] floatValue];
    eventObj.longitude = [[fullDict objectForKey:@"long"] floatValue];
    eventObj.isOpen = [[fullDict objectForKey:@"isOpen"] boolValue];
    eventObj.isCommunityAdmin = [[fullDict objectForKey:@"isCommunityAdmin"] boolValue];
    eventObj.isMapDisplay = [[fullDict objectForKey:@"isMap"] boolValue];
    eventObj.isInvitation = [[fullDict objectForKey:@"isInvitation"] boolValue];
    eventObj.invitemsg = [fullDict objectForKey:@"invitationMessage"];
    eventObj.inviteurl = [fullDict objectForKey:@"invitationicon"];
    eventObj.wallCount = [[fullDict objectForKey:@"comments"] intValue];
    if ([[fullDict objectForKey:@"available_seats"] isKindOfClass:[NSString class]]|| [[fullDict objectForKey:@"total_seats"] isKindOfClass:[NSString class]]) {
        eventObj.availableSeats = 0;
        eventObj.totalSeats = 0;
    }else {
        eventObj.availableSeats = [[fullDict objectForKey:@"available_seats"] intValue];
        eventObj.totalSeats = [[fullDict objectForKey:@"total_seats"] intValue];
    }
    eventObj.userEventStatus = [[fullDict objectForKey:@"myStatus"] intValue];
    eventObj.eventLikeCount = [[fullDict objectForKey:@"likes"] intValue];
    eventObj.eventDisLikeCount = [[fullDict objectForKey:@"dislikes"] intValue];
    eventObj.isLiked = [[fullDict objectForKey:@"liked"] boolValue];
    eventObj.isDisLiked = [[fullDict objectForKey:@"disliked"] boolValue];
    eventObj.shareLink = [fullDict objectForKey:@"shareLink"];
    eventObj.jomTotalWaitingUser = [[fullDict objectForKey:@"memberWaiting"] intValue];
    eventObj.isWaitingApproval = [[fullDict objectForKey:@"isWaitingApproval"] boolValue];
    return eventObj;
}

/////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////Joomsocial Group///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////key fatching for data store///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

+(BOOL)KeyStoreAsString :(NSString *)keyname
{
    if ([static_Keysfordatastring rangeOfString:keyname].location == NSNotFound)
    {
        DLog(@"string does not contain bla");
        return NO;
    }
    else
    {
        DLog(@"string contains bla!");
        return YES;
    }
}

/////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////key fatching for data store///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

- (void)dealloc
{
    
    [super dealloc];
}
@end
