//
//  Core_joomer.m
//  Core_joomer
//
//  Created by tailored on 11/6/12.
//  Copyright (c) 2013 tailored. All rights reserved.
//

#import "Core_joomer.h"
#import "JSONKit.h"
#import "Encrypt_Decrypt.h"
#import "Data.h"



@implementation Core_joomer


//Get Dictionary from URL.
+ (NSDictionary *) dict:(NSString *) jsonstring static_URL :(NSString *)URL {
    
    //nsmutable data.
    NSMutableData *postBody = [NSMutableData data];
    NSString *stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    
    
    //string to data.
    NSData *requestData = [NSData dataWithBytes: [jsonstring UTF8String] length: [jsonstring length]];
    
    //encrypt data.
    //requestData = [Encrypt_Decrypt AES128EncryptWithKey:requestData];
    
    //request send code.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: URL]];
    
    // add body to post
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"reqObject\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding ]];
    
    [postBody appendData:requestData];
    //[postBody appendData:[comment dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // set Content-Type in HTTP header
    stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //post request and data.
    //    NSString *postLength = [NSString stringWithFormat:@"%d", [requestData length]];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postBody length]];
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPBody: requestData];
    [request setHTTPBody: postBody];
    [request setTimeoutInterval:600];
    
    NSError *e = nil;
    
    double starttime = [[NSDate date] timeIntervalSince1970];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&e];
    double endtime = [[NSDate date] timeIntervalSince1970];
    double timeDiffInSecs =  endtime - starttime;
    
    if (returnData != nil)
    {
        
        //connection done and get data.
        
        //decrypt data.
        //returnData = [Encrypt_Decrypt AES128EncryptWithKey:requestData];
        
//        NSString *returnPage = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        NSDictionary *resultsDictionary1 = [returnData objectFromJSONData];
        
        //log dictionary set.
        
        NSMutableDictionary *dict_log = [[NSMutableDictionary alloc] init];
        
        [dict_log setObject:jsonstring forKey:@"req_url_json_string"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",starttime] forKey:@"req_start_timestamp"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",endtime] forKey:@"req_end_timestamp"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",timeDiffInSecs] forKey:@"req_diff_timestamp"];
        
        NSString *strtmptest = [NSString stringWithFormat:@"%@",[resultsDictionary1 objectForKey:@"code"]];
        strtmptest = [strtmptest stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (strtmptest == (id)[NSNull null] || strtmptest.length < 1 || [strtmptest isEqualToString:@"(null)"])
        {
            
            [dict_log setObject:@"500" forKey:@"req_code"];
        }
        else{
            
            strtmptest = [strtmptest stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (strtmptest.length > 0) {
                
                [dict_log setObject:[resultsDictionary1 objectForKey:@"code"] forKey:@"req_code"];
            }
            else {
                
                [dict_log setObject:@"500" forKey:@"req_code"];
            }
        }
        
        //condition if flag yes.
        if (static_Logcashing_flag == YES) {
            
            NSArray *arrayObj = [[NSUserDefaults standardUserDefaults] objectForKey:@"log_array"];
            NSMutableArray *arrtemplog;
            if ([arrayObj count] > 0) {
                
                arrtemplog = [[NSMutableArray alloc] initWithArray:arrayObj];
                [arrtemplog addObject:dict_log];
                
            }
            else {
                
                arrtemplog = [[NSMutableArray alloc] init];
                [arrtemplog addObject:dict_log];
            }
            [[NSUserDefaults standardUserDefaults] setObject:arrtemplog forKey:@"log_array"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (arrtemplog) {
                [arrtemplog release];
            }
        } else {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"log_array"];
        }
        
        if (dict_log) {
            [dict_log release];
        }
        
        //log dictionary set end.
        
        return resultsDictionary1;
    }
    else {
        
        NSDictionary *resultsDictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Connection Error.\n Please check internet..",@"message",@"25",@"code",nil];
        return resultsDictionary1;
    }
    
    return nil;
}

//Get dectionary from URL with image.
+ (NSDictionary *) dict_withimage:(NSString *) jsonstring Imaagedata :(NSData *)imagedata static_URL :(NSString *)URL
{
    
    NSMutableData *postBody = [NSMutableData data];
    NSString *stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    
    //string to data.
    NSData *requestData = [NSData dataWithBytes: [jsonstring UTF8String] length: [jsonstring length]];
    
    // add body to post
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"reqObject\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding ]];
    
    [postBody appendData:requestData];
    //[postBody appendData:[comment dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    /////////////****************************image.
    
    //image
    
    stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"item.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Type: image/jpeg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // get the image data from main bundle directly into NSData object
    //    NSData *imgData = UIImageJPEGRepresentation(item, 1.0);
    // add it to body
    [postBody appendData:imagedata];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // final boundary
    [postBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    ////////////*******************************end image.
    
    
    //encrypt data.
    //requestData = [Encrypt_Decrypt AES128EncryptWithKey:requestData];
    
    //request send code.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: URL]];
    
    // set Content-Type in HTTP header
    stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    //post request and data.
    //NSString *postLength = [NSString stringWithFormat:@"%d", [requestData length]];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postBody length]];
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPBody: requestData];
    [request setHTTPBody: postBody];
    [request setTimeoutInterval:600];
    
    
    NSError *e = nil;
    
    double starttime = [[NSDate date] timeIntervalSince1970];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&e];
    double endtime = [[NSDate date] timeIntervalSince1970];
    
    double timeDiffInSecs =  endtime - starttime;
    
    if (returnData != nil) {
        
        //connection done and get data.
        DLog(@" request url : %@",URL);
        //decrypt data.
        //returnData = [Encrypt_Decrypt AES128EncryptWithKey:requestData];
        
        NSString *returnPage = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        DLog(@"returnData string : %@",returnPage);
        
        NSDictionary *resultsDictionary1 = [returnData objectFromJSONData];
        //log dictionary set.
        
        NSMutableDictionary *dict_log = [[NSMutableDictionary alloc] init];
        
        [dict_log setObject:@"test strig" forKey:@"req_url_json_string"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",starttime] forKey:@"req_start_timestamp"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",endtime] forKey:@"req_end_timestamp"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",timeDiffInSecs] forKey:@"req_diff_timestamp"];
        
        NSString *strtmptest = [NSString stringWithFormat:@"%@",[resultsDictionary1 objectForKey:@"code"]];
        strtmptest = [strtmptest stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (strtmptest == (id)[NSNull null] || strtmptest.length < 1 || [strtmptest isEqualToString:@"(null)"])
        {
            
            [dict_log setObject:@"500" forKey:@"req_code"];
        }
        else{
            
            strtmptest = [strtmptest stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (strtmptest.length > 0) {
                
                [dict_log setObject:[resultsDictionary1 objectForKey:@"code"] forKey:@"req_code"];
            }
            else {
                
                [dict_log setObject:@"500" forKey:@"req_code"];
            }
        }
        
        if (static_Logcashing_flag == YES) {
            
            NSArray *arrayObj = [[NSUserDefaults standardUserDefaults] objectForKey:@"log_array"];
            NSMutableArray *arrtemplog;
            if ([arrayObj count] > 0) {
                
                arrtemplog = [[NSMutableArray alloc] initWithArray:arrayObj];
                [arrtemplog addObject:dict_log];
                
            }
            else {
                
                arrtemplog = [[NSMutableArray alloc] init];
                [arrtemplog addObject:dict_log];
            }
            [[NSUserDefaults standardUserDefaults] setObject:arrtemplog forKey:@"log_array"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (arrtemplog) {
                [arrtemplog release];
            }
        } else {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"log_array"];
        }
        
        if (dict_log) {
            [dict_log release];
        }
        
        //log dictionary set end.
        
        return resultsDictionary1;
    }
    else {
        
        NSDictionary *resultsDictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Connection Error.\n Please check internet..",@"message",@"25",@"code",nil];
        return resultsDictionary1;
    }
    
    return nil;
}

//VideoUploading...
+ (NSDictionary *) dict_withVideo:(NSString *) jsonstring Videodata :(NSData *)Videodata static_URL :(NSString *)URL videoname:(NSString *) videoname
{
    
    NSMutableData *postBody = [NSMutableData data];
    NSString *stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    
    //string to data.
    NSData *requestData = [NSData dataWithBytes: [jsonstring UTF8String] length: [jsonstring length]];
    
    // add body to post
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"reqObject\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding ]];
    
    [postBody appendData:requestData];
    //[postBody appendData:[comment dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    /////////////****************************Video.
    
    //video
    
    stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"video\"; filename=\"%@.%@\"\r\n",videoname,@"mov"] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[@"Content-Type: video/quicktime\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // get the image data from main bundle directly into NSData object
    //    NSData *imgData = UIImageJPEGRepresentation(item, 1.0);
    // add it to body
    [postBody appendData:Videodata];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // final boundary
    [postBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    ////////////*******************************end Video.
    
    
    //encrypt data.
    //requestData = [Encrypt_Decrypt AES128EncryptWithKey:requestData];
    
    //request send code.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: URL]];
    
    DLog(@" request url : %@",URL);
    // set Content-Type in HTTP header
    stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    //post request and data.
    //NSString *postLength = [NSString stringWithFormat:@"%d", [requestData length]];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postBody length]];
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPBody: requestData];
    [request setHTTPBody: postBody];
    [request setTimeoutInterval:600];
    
    
    NSError *e = nil;
    
    double starttime = [[NSDate date] timeIntervalSince1970];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&e];
    double endtime = [[NSDate date] timeIntervalSince1970];
    
    double timeDiffInSecs =  endtime - starttime;
    
    if (returnData != nil) {
        
        //connection done and get data.
        
        //decrypt data.
        //returnData = [Encrypt_Decrypt AES128EncryptWithKey:requestData];
        
        NSString *returnPage = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        DLog(@"returnData string : %@",returnPage);
        
        NSDictionary *resultsDictionary1 = [returnData objectFromJSONData];
        //log dictionary set.
        
        NSMutableDictionary *dict_log = [[NSMutableDictionary alloc] init];
        
        [dict_log setObject:@"test strig" forKey:@"req_url_json_string"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",starttime] forKey:@"req_start_timestamp"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",endtime] forKey:@"req_end_timestamp"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",timeDiffInSecs] forKey:@"req_diff_timestamp"];
        
        NSString *strtmptest = [NSString stringWithFormat:@"%@",[resultsDictionary1 objectForKey:@"code"]];
        strtmptest = [strtmptest stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (strtmptest == (id)[NSNull null] || strtmptest.length < 1 || [strtmptest isEqualToString:@"(null)"])
        {
            
            [dict_log setObject:@"500" forKey:@"req_code"];
        }
        else{
            
            strtmptest = [strtmptest stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (strtmptest.length > 0) {
                
                [dict_log setObject:[resultsDictionary1 objectForKey:@"code"] forKey:@"req_code"];
            }
            else {
                
                [dict_log setObject:@"500" forKey:@"req_code"];
            }
        }
        
        if (static_Logcashing_flag == YES) {
            
            NSArray *arrayObj = [[NSUserDefaults standardUserDefaults] objectForKey:@"log_array"];
            NSMutableArray *arrtemplog;
            if ([arrayObj count] > 0) {
                
                arrtemplog = [[NSMutableArray alloc] initWithArray:arrayObj];
                [arrtemplog addObject:dict_log];
                
            }
            else {
                
                arrtemplog = [[NSMutableArray alloc] init];
                [arrtemplog addObject:dict_log];
            }
            [[NSUserDefaults standardUserDefaults] setObject:arrtemplog forKey:@"log_array"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (arrtemplog) {
                [arrtemplog release];
            }
        } else {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"log_array"];
        }
        
        if (dict_log) {
            [dict_log release];
        }
        
        //log dictionary set end.
        
        return resultsDictionary1;
    }
    else {
        
        NSDictionary *resultsDictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Connection Error.\n Please check internet..",@"message",@"25",@"code",nil];
        return resultsDictionary1;
    }
    
    return nil;
}

//Voice Uploading....
+ (NSDictionary *) dict_withVoice:(NSString *) jsonstring Voicedata :(NSData *)voicedata static_URL :(NSString *)URL Voicename:(NSString *) voicename
{
    NSMutableData *postBody = [NSMutableData data];
    NSString *stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    
    //string to data.
    NSData *requestData = [NSData dataWithBytes: [jsonstring UTF8String] length: [jsonstring length]];
    
    // add body to post
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"reqObject\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding ]];
    
    [postBody appendData:requestData];
    //[postBody appendData:[comment dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    /////////////****************************voice.
    
    //Voice
    
    stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"voice\"; filename=\"%@.%@\"\r\n",voicedata,@"aac"] dataUsingEncoding:NSUTF8StringEncoding]];
    //DLog(@"%@",[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"voice\"; filename=\"%@.%@\"\r\n",voicedata,@"aac"]);
	//[postBody appendData:[@"Content-Type: voice/quicktime\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Type: voice/aac\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // get the image data from main bundle directly into NSData object
    //    NSData *imgData = UIImageJPEGRepresentation(item, 1.0);
    // add it to body
    [postBody appendData:voicedata];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // final boundary
    [postBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    ////////////*******************************end voice.
    
    
    //encrypt data.
    //requestData = [Encrypt_Decrypt AES128EncryptWithKey:requestData];
    
    //request send code.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: URL]];
    
    
//    /////start
//    NSLog(@"SendingRecordedData");
//    NSString *urlString = [NSString stringWithFormat:@"http://your_server/fileupload.php"];
//    NSLog(@"Url:%@",urlString);
//    
//    [request setURL:[NSURL URLWithString:urlString]];
//    
//    //end
    
    DLog(@" request url : %@",URL);
    // set Content-Type in HTTP header
    stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    //post request and data.
    //NSString *postLength = [NSString stringWithFormat:@"%d", [requestData length]];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postBody length]];
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPBody: requestData];
    [request setHTTPBody: postBody];
    [request setTimeoutInterval:600];
    
    
    NSError *e = nil;
    
    double starttime = [[NSDate date] timeIntervalSince1970];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&e];
    double endtime = [[NSDate date] timeIntervalSince1970];
    
    double timeDiffInSecs =  endtime - starttime;
    
    if (returnData != nil) {
        
        //connection done and get data.
        
        //decrypt data.
        //returnData = [Encrypt_Decrypt AES128EncryptWithKey:requestData];
        
        NSString *returnPage = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        DLog(@"returnData string : %@",returnPage);
        
        NSDictionary *resultsDictionary1 = [returnData objectFromJSONData];
        //log dictionary set.
        
        NSMutableDictionary *dict_log = [[NSMutableDictionary alloc] init];
        
        [dict_log setObject:@"test strig" forKey:@"req_url_json_string"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",starttime] forKey:@"req_start_timestamp"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",endtime] forKey:@"req_end_timestamp"];
        [dict_log setObject:[NSString stringWithFormat:@"%f",timeDiffInSecs] forKey:@"req_diff_timestamp"];
        
        NSString *strtmptest = [NSString stringWithFormat:@"%@",[resultsDictionary1 objectForKey:@"code"]];
        strtmptest = [strtmptest stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (strtmptest == (id)[NSNull null] || strtmptest.length < 1 || [strtmptest isEqualToString:@"(null)"])
        {
            
            [dict_log setObject:@"500" forKey:@"req_code"];
        }
        else{
            
            strtmptest = [strtmptest stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (strtmptest.length > 0) {
                
                [dict_log setObject:[resultsDictionary1 objectForKey:@"code"] forKey:@"req_code"];
            }
            else {
                
                [dict_log setObject:@"500" forKey:@"req_code"];
            }
        }
        
        if (static_Logcashing_flag == YES) {
            
            NSArray *arrayObj = [[NSUserDefaults standardUserDefaults] objectForKey:@"log_array"];
            NSMutableArray *arrtemplog;
            if ([arrayObj count] > 0) {
                
                arrtemplog = [[NSMutableArray alloc] initWithArray:arrayObj];
                [arrtemplog addObject:dict_log];
                
            }
            else {
                
                arrtemplog = [[NSMutableArray alloc] init];
                [arrtemplog addObject:dict_log];
            }
            [[NSUserDefaults standardUserDefaults] setObject:arrtemplog forKey:@"log_array"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (arrtemplog) {
                [arrtemplog release];
            }
        } else {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"log_array"];
        }
        
        if (dict_log) {
            [dict_log release];
        }
        
        //log dictionary set end.
        
        return resultsDictionary1;
    }
    else {
        
        NSDictionary *resultsDictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Connection Error.\n Please check internet..",@"message",@"25",@"code",nil];
        return resultsDictionary1;
    }
    
    return nil;

}

// return Request time log values.
+(NSArray *) RequestTimeLog
{
    [self CheckDatabaseExist];
    if (static_Logcashing_flag == YES) {
        
        NSArray *arrayObj = [[NSUserDefaults standardUserDefaults] objectForKey:@"log_array"];
        return arrayObj;
    }
    return nil;
}

///***********************************Database coding*************************

+(void) CheckDatabaseExist
{
    BOOL success = [Data CheckDatabaseExist];
    if (!success) {
        Data *data = [[Data alloc] init];
        success = [data createDatabaseIfNotExist];
        DLog(@"createDatabaseIfNotExist %d",success);
    }
    
}
///*********************************End Database coding***********************

@end
