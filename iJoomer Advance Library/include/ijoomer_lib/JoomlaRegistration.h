//
//  JoomlaRegistration.h
//  Core_joomer
//
//  Created by tailored on 11/7/12.
//  Copyright (c) 2013 tailored. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JoomlaRegistration : NSObject

//core Login.
+ (NSDictionary *)CreateDictionary :(NSString *) taskname TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

//JoomSocial or other Plugin.
+ (NSDictionary *)JoomSocialDictionary :(NSString *) Jsonstring Imagedata:(NSData *) imagedata;

//JoomSocial or other Plugin Video upload.
+ (NSDictionary *)JoomSocialDictionaryVideo :(NSString *) Jsonstring Videodata:(NSData *) videodata videoname:(NSString *) videoname;

//JoomSocial or other Plugin Voice upload.
+ (NSDictionary *)JoomSocialDictionaryVoice :(NSString *) Jsonstring Voicedata:(NSData *) voicedata Voicename:(NSString *) voicename;

@end
