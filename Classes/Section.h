//
//  DirectorySection.h
//  iJoomer
//
//  Created by Tailored Solutions on 07/10/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Section : NSObject {
	NSInteger sectionId;
	NSString *sectionName;
	NSMutableArray *categorys;
	int totalArticles;

}
@property (nonatomic, readwrite) NSInteger sectionId;
@property (nonatomic, retain) NSString *sectionName;
@property (nonatomic, retain) NSMutableArray *categorys;
@property(nonatomic, readwrite)int totalArticles;

@end
