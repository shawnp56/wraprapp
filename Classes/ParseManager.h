//
//  ParseManager.h
//  iJoomer
//
//  Created by Ankit on 13/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"





#import "Messages.h"

@interface ParseManager : NSObject {
    
}

+(bool)parseFacebookResponse:(NSDictionary *)dict;

@end

