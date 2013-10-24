//
//  MapItemAnnotation.h
//  MM4MP
//
//  Created by Tailored Solutions on 19/04/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Category.h"
@class User,Article;

@interface MapItemAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
	User *mapUser;
    Article *articlemap;
	NSObject *mapRecord;
    Category *mapEntry;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) User *mapUser;
@property (nonatomic, assign)Article *articlemap;
@property (nonatomic, assign)Category *mapEntry;
@property (nonatomic, assign) NSObject *mapRecord;

- (id) initWithCoordinate:(CLLocationCoordinate2D)_coordinate AnnotationTitle:(NSString *)_title;
- (void)changeDetail:(CLLocationCoordinate2D)_coordinate AnnotationTitle:(NSString *)_title;

@end
