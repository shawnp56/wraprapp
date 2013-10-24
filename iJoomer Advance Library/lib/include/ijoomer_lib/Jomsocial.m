//
//  Jomsocial.m
//  ijoomer_lib
//
//  Created by tailored on 11/7/12.
//  Copyright (c) 2013 tailored. All rights reserved.
//

#import "Jomsocial.h"
#import "JSONKit.h"
#import "JoomlaRegistration.h"
#import "Core_joomer.h"
#import "iCMSDatabaseObject.h"


@implementation Jomsocial

//joomsocial.
+ (NSString *)CreateDictionary_joomsocial :(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata1
{
    NSDictionary *dict_task = [NSDictionary dictionaryWithObjectsAndKeys:@"jomsocial", @"extName", extView, @"extView", extTask, @"extTask", Taskdatadict, @"taskData", nil];
    NSLog(@"dict : %@",dict_task);
    NSString* jsonString = [dict_task JSONString];
    NSLog(@" Request JSON : %@",jsonString);
    
    return jsonString;
}

////////////////////////////////////////////////////////////////////////////
/////////////////// AlbumsViewController //////////////////
////////////////////////////////////////////////////////////////////////////

+(NSDictionary *)JomsocialAllAlbums:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    
    NSDictionary *dict;
    
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
       
    return dict;
}

+(NSDictionary *)JomsocialMyAlbums:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    
    NSDictionary *dict;
    
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}

+(NSDictionary *)JomsocialAddAlbum:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    
    NSDictionary *dict;
    
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}

////////////////////////////////////////////////////////////////////////////
/////////////////// AlbumsViewController END //////////////////
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
/////////////////// BulletinDetailViewController //////////////////
////////////////////////////////////////////////////////////////////////////

+(NSDictionary *)JomsocialAddAnnouncement:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSDictionary *dict;
    
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}

+(NSDictionary *)JomsocialUploadFile:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSDictionary *dict;
    
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}
+(NSDictionary *)JomsocialDeleteAnnouncement:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSDictionary *dict;
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}

////////////////////////////////////////////////////////////////////////////
/////////////////// BulletinDetailViewController END //////////////////
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
/////////////////// CommentViewController //////////////////
////////////////////////////////////////////////////////////////////////////

+(NSDictionary *)JomsocialGetLikes:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSDictionary *dict;
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}

+(NSDictionary *)JomsocialGetComments:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSDictionary *dict;
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}

+(NSDictionary *)JomsocialRemovewall:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSDictionary *dict;
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}

+(NSDictionary *)JomsocialAddWall:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSDictionary *dict;
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}

+(NSDictionary *)JomsocialAdd:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSDictionary *dict;
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}

////////////////////////////////////////////////////////////////////////////
/////////////////// CommentViewController END //////////////////
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
/////////////////// Commonfunction for fetch Dictionary //////////////////
////////////////////////////////////////////////////////////////////////////

+(NSDictionary *)JomsocialCommonDictfunction:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSDictionary *dict;
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}

+(NSDictionary *)JomsocialCommonDictfunctionVideo:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Videodata:(NSData *) videodata videoname:(NSString *) videoname
{
    NSDictionary *dict;
    
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:videodata];
    
    dict = [JoomlaRegistration JoomSocialDictionaryVideo:jsonString Videodata:videodata videoname:videoname];
    
    return dict;
}


+(NSDictionary *)JomsocialCommonDictfunctionVoice:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Voicedata:(NSData *) voicedata voicename:(NSString *) voicename
{
    NSDictionary *dict;
    
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:voicedata];
    
   
    dict = [JoomlaRegistration JoomSocialDictionaryVoice:jsonString Voicedata:voicedata Voicename:voicename];
    
    return dict;
}
////////////////////////////////////////////////////////////////////////////
/////////////////// Commonfunction for fetch Dictionary END //////////////////
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
/////////////////// Friends fetch Dictionary //////////////////
////////////////////////////////////////////////////////////////////////////

+(NSDictionary *)JomsocialFriendFetch:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSDictionary *dict;
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:imagedata];
    
    return dict;
}

+(NSDictionary *)JomsocialFriendFetchVideo:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Videodata:(NSData *) videodata videoname:(NSString *) videoname
{
    NSDictionary *dict;
    
    NSString *jsonString = [self CreateDictionary_joomsocial:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:videodata];
    
    dict = [JoomlaRegistration JoomSocialDictionaryVideo:jsonString Videodata:videodata videoname:videoname];
    
    return dict;
}


////////////////////////////////////////////////////////////////////////////
/////////////////// Friends fetch Dictionary END //////////////////
////////////////////////////////////////////////////////////////////////////



@end
