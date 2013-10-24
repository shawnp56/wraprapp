//
//  MREntitiesConverter.h
//  iJoomer
//
//  Created by Tailored Solutions on 24/06/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MREntitiesConverter : NSObject <NSXMLParserDelegate> {
	NSMutableString* resultString;
}

@property (nonatomic, retain) NSMutableString* resultString;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)s;
- (NSString*)convertEntiesInString:(NSString*)s;

@end
