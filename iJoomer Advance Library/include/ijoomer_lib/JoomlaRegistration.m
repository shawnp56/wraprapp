//
//  JoomlaRegistration.m
//  Core_joomer
//
//  Created by tailored on 11/7/12.
//  Copyright (c) 2013 tailored. All rights reserved.
//

#import "JoomlaRegistration.h"
#import "JSONKit.h"
#import "Core_joomer.h"

@implementation JoomlaRegistration

+ (NSDictionary *)CreateDictionary :(NSString *) taskname TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    //read pilist file.
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"ijoomerConfig.plist"]];
    
    NSDictionary *dict_task = [NSDictionary dictionaryWithObjectsAndKeys: taskname, @"task", Taskdatadict, @"taskData", nil];
    
    NSString* jsonString = [dict_task JSONString];
    
    
    NSDictionary *dict;
    if (imagedata)
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"] length] > 0) {
            
            dict = [Core_joomer dict_withimage:jsonString Imaagedata:imagedata static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]]];
            
            //dict = [Core_joomer dict_withimage:jsonString Imaagedata:imagedata static_URL:[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]];
        }
        else{
            
            dict = [Core_joomer dict_withimage:jsonString Imaagedata:imagedata static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[plistDict objectForKey:@"sever_static_URL"]]];
            
            //dict = [Core_joomer dict_withimage:jsonString Imaagedata:imagedata static_URL:[plistDict objectForKey:@"sever_static_URL"]];
        }
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"] length] > 0) {
            
            //dict = [Core_joomer dict:jsonString static_URL:[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]];
            dict = [Core_joomer dict:jsonString static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]]];
        }
        else{
            dict = [Core_joomer dict:jsonString static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[plistDict objectForKey:@"sever_static_URL"]]];
            //dict = [Core_joomer dict:jsonString static_URL:[plistDict objectForKey:@"sever_static_URL"]];
        }
    }
    return dict;
}
//JoomSocial or other Plugin.
+ (NSDictionary *)JoomSocialDictionary :(NSString *) Jsonstring Imagedata:(NSData *) imagedata
{
    //read pilist file.
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"ijoomerConfig.plist"]];
    
    NSDictionary *dict;
    if (imagedata)
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"] length] > 0) {
            
            dict = [Core_joomer dict_withimage:Jsonstring Imaagedata:imagedata static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]]];
            
            // dict = [Core_joomer dict_withimage:Jsonstring Imaagedata:imagedata static_URL:[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]];
        }
        else{
            
            dict = [Core_joomer dict_withimage:Jsonstring Imaagedata:imagedata static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[plistDict objectForKey:@"sever_static_URL"]]];
            //dict = [Core_joomer dict_withimage:Jsonstring Imaagedata:imagedata static_URL:[plistDict objectForKey:@"sever_static_URL"]];
        }
        
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"] length] > 0) {
            
            dict = [Core_joomer dict:Jsonstring static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]]];
            
            // dict = [Core_joomer dict:Jsonstring static_URL:[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]];
        }
        else{
            
            dict = [Core_joomer dict:Jsonstring static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[plistDict objectForKey:@"sever_static_URL"]]];
            
            //dict = [Core_joomer dict:Jsonstring static_URL:[plistDict objectForKey:@"sever_static_URL"]];
        }
    }
    return dict;
}

//JoomSocial or other Plugin Video upload.
+ (NSDictionary *)JoomSocialDictionaryVideo :(NSString *) Jsonstring Videodata:(NSData *) videodata videoname:(NSString *) videoname;
{
    //read pilist file.
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"ijoomerConfig.plist"]];
    
    NSDictionary *dict;
    if (videodata)
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"] length] > 0) {
            
            dict = [Core_joomer dict_withVideo:Jsonstring Videodata:videodata static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]] videoname:videoname];
            
            //dict = [Core_joomer dict_withVideo:Jsonstring Videodata:videodata static_URL:[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"] videoname:videoname];
        }
        else{
            
            dict = [Core_joomer dict_withVideo:Jsonstring Videodata:videodata static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[plistDict objectForKey:@"sever_static_URL"]] videoname:videoname];
            
            //dict = [Core_joomer dict_withVideo:Jsonstring Videodata:videodata static_URL:[plistDict objectForKey:@"sever_static_URL"] videoname:videoname];
        }
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"] length] > 0) {
            
            dict = [Core_joomer dict:Jsonstring static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]]];
            
            //dict = [Core_joomer dict:Jsonstring static_URL:[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]];
        }
        else{
            
            dict = [Core_joomer dict:Jsonstring static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[plistDict objectForKey:@"sever_static_URL"]]];
            //dict = [Core_joomer dict:Jsonstring static_URL:[plistDict objectForKey:@"sever_static_URL"]];
        }
        
    }
    
    return dict;
}

//JoomSocial or other Plugin Voice upload.
+ (NSDictionary *)JoomSocialDictionaryVoice :(NSString *) Jsonstring Voicedata:(NSData *) voicedata Voicename:(NSString *) voicename;
{
    //read pilist file.
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"ijoomerConfig.plist"]];
    
    NSDictionary *dict;
    if (voicedata)
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"] length] > 0) {
            
            dict = [Core_joomer dict_withVoice:Jsonstring Voicedata:voicedata static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"]] Voicename:voicename];
            
            //dict = [Core_joomer dict_withVideo:Jsonstring Videodata:videodata static_URL:[[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"] videoname:videoname];
        }
        else{
            
            dict = [Core_joomer dict_withVoice:Jsonstring Voicedata:voicedata static_URL:[NSString stringWithFormat:@"%@/index.php?option=com_ijoomeradv",[plistDict objectForKey:@"sever_static_URL"]] Voicename:voicename];
            
            //dict = [Core_joomer dict_withVideo:Jsonstring Videodata:videodata static_URL:[plistDict objectForKey:@"sever_static_URL"] videoname:videoname];
        }
    }
    return dict;
}
@end
