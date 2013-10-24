//
//  AdsAppConstant.h
//  iJoomer
//
//  Created by Pratik Mehta on 16/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


// ADVERTISEMENT

#define TAG_CODE					@"code"
#define TAG_ADSID					@"id"
#define	TAG_ADSTITLE				@"title"
#define	TAG_ADSPOSITION				@"position"
#define	TAG_ADSIMG					@"advertise"
#define TAG_ADSURL				    @"url"

// Response Code
#define RESPONSE_SUCCESS			@"1"

// General Constants
#define NULL_STRING					@""


typedef enum {
	adsBottomNew = 0,
	adsBottom,
	adsTop,
	adsRight,
	adsLeft
} AdsPositionCode;

typedef enum {
	ErroronServer = 0,
	SessionError
} adsErrorCode;

typedef enum {
	adsNetworkError =0,
	adsSuccess,
}adsCode;

typedef enum {
	AdsQuery = 0
} adsHTTPRequest;
