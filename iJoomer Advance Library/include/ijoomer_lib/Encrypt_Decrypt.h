//
//  Encrypt_Decrypt.h
//  ijoomer_lib
//
//  Created by tailored on 10/11/12.
//  Copyright (c) 2013 tailored. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonCryptor.h>

#define statik_key @""

@interface Encrypt_Decrypt : NSObject

+ (NSData *)AES128EncryptWithKey:(NSData *)plain;
+ (NSData *)AES128DecryptWithKey:(NSData *)plain;
@end
