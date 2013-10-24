//
//  MapItemAnnotation.m
//  MM4MP
//
//  Created by Tailored Solutions on 19/04/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "MapItemAnnotation.h"


@implementation MapItemAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize mapUser;
@synthesize articlemap;
@synthesize mapRecord;
@synthesize mapEntry;

- (id) initWithCoordinate:(CLLocationCoordinate2D)_coordinate AnnotationTitle:(NSString *)_title {
	
	self = [super init];
	if (self != nil) {
		
		coordinate = _coordinate;
		title = _title;
		
	}
	
	return self;
}


- (void)changeDetail:(CLLocationCoordinate2D)_coordinate AnnotationTitle:(NSString *)_title {
	coordinate = _coordinate;
	title = _title;
}

@end
