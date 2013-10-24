//
//  MREntitiesConverter.m
//  iJoomer
//
//  Created by Tailored Solutions on 24/06/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "MREntitiesConverter.h"


@implementation MREntitiesConverter
@synthesize resultString;

- (id)init
{
    if([super init]) {
        resultString = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)s {
	[self.resultString appendString:s];
}

- (NSString*)convertEntiesInString:(NSString*)s {
    if(s == nil) {
        DLog(@"ERROR : Parameter string is nil");
    }
    NSString* xmlStr = [NSString stringWithFormat:@"<d>%@</d>", s];
    NSData *data = [xmlStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSXMLParser* xmlParse = [[[NSXMLParser alloc] initWithData:data] autorelease];
    [xmlParse setDelegate:self];
    [xmlParse parse];
	 NSString* returnStr = [[NSString alloc] initWithFormat:@"%@",resultString];
    return [NSString stringWithFormat:@"%@",returnStr];
}

- (void)dealloc {
    [resultString release];
    [super dealloc];
}

@end
