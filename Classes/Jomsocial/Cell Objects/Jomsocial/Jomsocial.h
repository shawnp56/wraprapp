//
//  Jomsocial.h
//  ijoomer_lib
//
//  Created by tailored on 11/7/12.
//  Copyright (c) 2012 tailored. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jomsocial : NSObject

//joomsocial.

/*
 
 Global Function for creating dictionary.
 
 extView : viewname
 extTask : taskname
 Taskdatadict : Dictionary of Post Variables.
 Imagedata : imagedata
 */
+ (NSString *)CreateDictionary_joomsocial :(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

////////////////////////////////////////////////////////////////////////////
/////////////////// AlbumsViewController //////////////////
////////////////////////////////////////////////////////////////////////////
/*
 
 Global Function for JomsocialAllAlbums.
 
 extView : viewname
 extTask : taskname
 Taskdatadict : Dictionary of Post Variables.
 Imagedata : NSData of image.
 */
+(NSDictionary *)JomsocialAllAlbums:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

/*
 
 Global Function for JomsocialMyAlbums.
 
 extView : viewname
 extTask : taskname
 Taskdatadict : Dictionary of Post Variables.
 Imagedata : NSData of image.
 */
+(NSDictionary *)JomsocialMyAlbums:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

/*
 
 Global Function for JomsocialAddAlbum.
 
 extView : viewname
 extTask : taskname
 Taskdatadict : Dictionary of Post Variables.
 Imagedata : NSData of image.
 */
+(NSDictionary *)JomsocialAddAlbum:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

////////////////////////////////////////////////////////////////////////////
/////////////////// AlbumsViewController END //////////////////
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
/////////////////// BulletinDetailViewController //////////////////
////////////////////////////////////////////////////////////////////////////

+(NSDictionary *)JomsocialAddAnnouncement:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

+(NSDictionary *)JomsocialUploadFile:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

+(NSDictionary *)JomsocialDeleteAnnouncement:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

////////////////////////////////////////////////////////////////////////////
/////////////////// BulletinDetailViewController END //////////////////
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
/////////////////// CommentViewController //////////////////
////////////////////////////////////////////////////////////////////////////

+(NSDictionary *)JomsocialGetLikes:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

+(NSDictionary *)JomsocialGetComments:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

+(NSDictionary *)JomsocialRemovewall:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

+(NSDictionary *)JomsocialAddWall:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

+(NSDictionary *)JomsocialAdd:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

////////////////////////////////////////////////////////////////////////////
/////////////////// CommentViewController END //////////////////
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
/////////////////// Commonfunction for fetch Dictionary //////////////////
////////////////////////////////////////////////////////////////////////////

+(NSDictionary *)JomsocialCommonDictfunction:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;

+(NSDictionary *)JomsocialCommonDictfunctionVideo:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Videodata:(NSData *) videodata videoname:(NSString *) videoname;
////////////////////////////////////////////////////////////////////////////
/////////////////// Commonfunction for fetch Dictionary END //////////////////
////////////////////////////////////////////////////////////////////////////


@end
