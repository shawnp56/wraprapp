//
//  Core_joomer.h
//  Core_joomer
//
//  Created by tailored on 11/6/12.
//  Copyright (c) 2013 tailored. All rights reserved.
//

#import <Foundation/Foundation.h>

#define sever_static_URL        @"http://192.168.5.156/development/ijoomer2.0/index.php?option=com_ijoomer"

#define JSON_MAIN           @"{\"task\":\"%@\",\"taskData\":%@}"

#define static_Logcashing_flag YES


@interface Core_joomer : NSObject


//Get dectionary from URL.
+ (NSDictionary *) dict:(NSString *) jsonstring static_URL :(NSString *)URL;

//Get dectionary from URL with image.
+ (NSDictionary *) dict_withimage:(NSString *) jsonstring Imaagedata :(NSData *)imagedata static_URL :(NSString *)URL;

//VideoUploading...
+ (NSDictionary *) dict_withVideo:(NSString *) jsonstring Videodata :(NSData *)Videodata static_URL :(NSString *)URL videoname:(NSString *) videoname;

// return Request time log values.
+(NSArray *) RequestTimeLog;

//Voice Uploading....
+ (NSDictionary *) dict_withVoice:(NSString *) jsonstring Voicedata :(NSData *)voicedata static_URL :(NSString *)URL Voicename:(NSString *) voicename;

///***********************************Database coding*************************

+(void) CheckDatabaseExist;
///*********************************End Database coding***********************

@end
