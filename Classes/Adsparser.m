//
//  Adsparser.m
//  iJoomer
//
//  Created by Pratik Mehta on 12/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Adsparser.h"
#import "BannerList.h"
#import "Banner.h"
#import "XMLManualParser.h"
#import "AdsAppConstant.h"
@implementation Adsparser

+(bool)parseAdvertisementContent:(NSString *)xmlContent{
	/*
	 <data>
	 <code>1</code>
	 <id>4</id>
	 <title>fourth ads</title>
	 <position>2</position>
	 <advertise>http://192.168.5.188/advertisement/administrator/components/com_helloworld03/advertisement_image/top_bottom/top_botom_sleeptime.jpg</advertise>
	 <url>http://www.tasolglobal.com</url>
	 </data>
	 */
	Banner *Bannerdata = [Banner sharedInstance];
	
	NSString *tagValue = [XMLManualParser getTagValue:TAG_CODE XMLContent:xmlContent];
	
	if([tagValue length] == 0) {
		Bannerdata.errorCode = ErroronServer;
		return FALSE;
	}
	if([tagValue length] == 3){
		Bannerdata.errorCode = SessionError;
		return FALSE;
	}
	Bannerdata.errorCode = [tagValue intValue];
	
	if([tagValue compare:RESPONSE_SUCCESS] == NSOrderedSame) {
		
		if([tagValue length] > 0) {
			
			Bannerdata.bannersobj = [[BannerList alloc] init];
			Bannerdata.bannersobj.adsID = [[XMLManualParser getTagValue:TAG_ADSID XMLContent:xmlContent] intValue];
			Bannerdata.bannersobj.adstitle = [XMLManualParser getTagValue:TAG_ADSTITLE XMLContent:xmlContent];
			Bannerdata.bannersobj.adsposition = [[XMLManualParser getTagValue:TAG_ADSPOSITION XMLContent:xmlContent] intValue];
			Bannerdata.bannersobj.adsImgURl = [XMLManualParser getTagValue:TAG_ADSIMG XMLContent:xmlContent];
			Bannerdata.bannersobj.adsUrl = [XMLManualParser getTagValue:TAG_ADSURL XMLContent:xmlContent];
		}
		return TRUE;
	}
	
	return FALSE;
	
}

@end
