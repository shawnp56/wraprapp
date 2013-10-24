//
//  iCMS.m
//  iJoomer
//
//  Created by Tailored Solutions on 4/9/13.
//
//

#import "iCMS.h"
#import "JSONKit.h"
#import "iCMSDatabaseObject.h"
//#import "JoomlaRegistration.h"



@implementation iCMS

/*
 
 Global Function of Create JSON String for app Request Post Variabl Dictionary
 
 This Function is use for Creating JSON String of All post Variable Dictionary

 */

+ (NSString *)CreateDictionary_iCMS :(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata {
    
    NSDictionary *dict_task;
    
    if ([extTask isEqualToString:@"ping"]) {
        
        dict_task = [NSDictionary dictionaryWithObjectsAndKeys:extTask, @"task", nil];
    }
    else
    {
        dict_task = [NSDictionary dictionaryWithObjectsAndKeys:@"icms", @"extName", extView, @"extView", extTask, @"extTask", Taskdatadict, @"taskData", nil];
    }
    
    NSString* jsonString = [dict_task JSONString];
    
    return jsonString;
}

/*
 
 Global Function for populating data of ICMS All Category List.
 
 This Function is use for Fetch data of ICMS All Category List and Store in Database as well Send to User.
 extView : categories
 extTask : category
 extName : icms
 Taskdatadict : Dictionary of Post Variables.
 */

//category list fetch and store in database code.
+(NSDictionary *)iCMSCategoryList:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSString *jsonString = [[NSString alloc] init];
    jsonString = [iCMS CreateDictionary_iCMS:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    NSString *StrCharReplace;
    
    iCMSDatabaseObject *icmsdata = [[iCMSDatabaseObject alloc] init];
    
    int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
    NSDictionary *dict;
    
    int kp = [icmsdata CheckDataExist:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ where REQObject = \"%@\"",[NSString stringWithFormat:@"iCMS%@",extTask], [self JsonstringRemoveChar:jsonString]]];
    
    if (kl && kp)
    {
        if ([[Taskdatadict objectForKey:@"id"] intValue] == 0)
        {
            
            StrCharReplace = [self JsonstringRemoveChar:jsonString];
            
            NSArray * arrcategories = [icmsdata getiCMSData:[NSString stringWithFormat:@"SELECT * FROM %@ where REQObject = \"%@\"",[NSString stringWithFormat:@"iCMS%@",extTask],[self JsonstringRemoveChar:jsonString]]];
            
            dict = [NSDictionary dictionaryWithObjectsAndKeys:arrcategories,@"categories",[NSString stringWithFormat:@"200"],@"code", nil];
            
            [self Categorydatastore:jsonString ExtTask:extTask];
        }
        else
        {
            
            NSArray * arrcategories = [icmsdata getiCMSData:[NSString stringWithFormat:@"SELECT * FROM %@ where categoryid = %@ AND REQObject = \"%@\"",[NSString stringWithFormat:@"iCMS%@",extTask],[Taskdatadict objectForKey:@"id"],[self JsonstringRemoveChar:jsonString]]];
            
            dict = [NSDictionary dictionaryWithObjectsAndKeys:arrcategories,@"categories",[NSString stringWithFormat:@"200"],@"code", nil];
        }
        
        return dict;
    }
    else
    {
        dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:nil];
        
        if ([[dict valueForKey:@"code"] intValue] == 200)
        {
            
            [iCMSApplicationData sharedInstance].pageLimit = [[dict objectForKey:@"pageLimit"] intValue];
            [iCMSApplicationData sharedInstance].totalArticle = [[dict objectForKey:@"total"] intValue];
            
            NSArray *categoryList = [dict objectForKey:@"categories"];
            
            [iCMSApplicationData sharedInstance].categoryListFlag = YES;
            if ([categoryList isKindOfClass:[NSArray class]])
            {
                NSArray *arrallkey;
                NSArray *values;
                NSDictionary *datadict;
                if ([categoryList count] > 0)
                {
                    datadict = [categoryList objectAtIndex:0];
                    arrallkey = [datadict allKeys];
                    values = [datadict allValues];
                    
                    int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
                    if (kl == 0)
                    {
                        NSString *Query = [iCMS Createtablestring:arrallkey allvalues:values];
                        Query = [NSString stringWithFormat:@"CREATE TABLE iCMS%@ (%@)", extTask, Query];
                        
                        [icmsdata CreateTable:Query];
                    }
                }
                
                NSMutableArray *inservalue = [[NSMutableArray alloc] init];
                for (int i = 0; i < [categoryList count]; i++)
                {
                    datadict = [categoryList objectAtIndex:i];
                    values = [datadict allValues];
                    NSString *strcolumenname;
                    NSString *strinsertvalues;
                    for (int l = 0 ; l < [arrallkey count]; l++)
                    {
                        NSString* Strings = [[NSString alloc] init];
                        if ([[values objectAtIndex:l] isKindOfClass:[NSArray class]])
                        {
                            // do somthing
                            NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                            Strings = [dictval JSONString];
                            [inservalue addObject:Strings];
                        }
                        else if ([[values objectAtIndex:l] isKindOfClass:[NSDictionary class]])
                        {
                            // do somthing
                            NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                            Strings = [dictval JSONString];
                            [inservalue addObject:Strings];
                        }
                        else
                        {
                            // do somthing
                            if ([arrayiCMSFieldconstant containsObject:[arrallkey objectAtIndex:l]])
                            {
                                NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                Strings = [dictval JSONString];
                                [inservalue addObject:Strings];
                            }
                            else
                            {
                                [inservalue addObject:[values objectAtIndex:l]];
                                
                                Strings = [values objectAtIndex:l];
                            }
                        }
                        
                        
                        if (l == 0) {
                            strcolumenname = [NSString stringWithFormat:@"%@",[arrallkey objectAtIndex:l]];
                            
                            if ([Strings isKindOfClass:[NSString class]]) {
                                Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                            }
                            
                            strinsertvalues = [NSString stringWithFormat:@"\"%@\"",Strings];
                        }
                        else
                        {
                            strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,[arrallkey objectAtIndex:l]];
                            
                            if ([Strings isKindOfClass:[NSString class]]) {
                                Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                            }
                            
                            strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,Strings];
                        }
                    }
                    
                    strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,@"REQObject"];
                    
                    strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self JsonstringRemoveChar:jsonString]];
                    
                    NSString *QUR = [NSString stringWithFormat:@"INSERT INTO iCMS%@ (%@) VALUES (%@);",extTask,strcolumenname, strinsertvalues];
                    
                    [icmsdata insertData:QUR];
                }
            }
            [iCMSApplicationData sharedInstance].categoryListFlag = NO;
        }
    }
    return dict;
}

/*
 
 Global Function for populating data of ICMS All Category List in Background.
 
 This Function is use for Fetch data of ICMS All Category List and Store in Database In Background.
 */

//category list fetch and store in database code.
+(void)Categorydatastore :(NSString *) json ExtTask:(NSString *) extTask
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL),
                   ^(void)
                   {
                       
                       if (![iCMSApplicationData sharedInstance].categoryListFlag) {
                           
                           NSDictionary *dict = [JoomlaRegistration JoomSocialDictionary:json Imagedata:nil];
                           
                           iCMSDatabaseObject *icmsdata = [[iCMSDatabaseObject alloc] init];
                           if ([[dict valueForKey:@"code"] intValue] == 200)
                           {
                               [iCMSApplicationData sharedInstance].pageLimit = [[dict objectForKey:@"pageLimit"] intValue];
                               [iCMSApplicationData sharedInstance].totalArticle = [[dict objectForKey:@"total"] intValue];
                               
                               NSArray *categoryList = [dict objectForKey:@"categories"];
                               if ([categoryList isKindOfClass:[NSArray class]])
                               {
                                   NSArray *arrallkey;
                                   NSArray *values;
                                   NSDictionary *datadict;
                                   if ([categoryList count] > 0)
                                   {
                                       datadict = [categoryList objectAtIndex:0];
                                       arrallkey = [datadict allKeys];
                                       values = [datadict allValues];
                                       
                                       int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
                                       if (kl == 0)
                                       {
                                           NSString *Query = [iCMS Createtablestring:arrallkey allvalues:values];
                                           Query = [NSString stringWithFormat:@"CREATE TABLE iCMS%@ (%@)", extTask, Query];
                                           
                                           [icmsdata CreateTable:Query];
                                       }
                                   }
                                   
                                   if (![iCMSApplicationData sharedInstance].archiveListFlag) {
                                       
                                       [icmsdata deleteData:[NSString stringWithFormat:@"delete from iCMS%@ where REQObject = \"%@\"",extTask, [self JsonstringRemoveChar:json]]];
                                   }
                                   
                                   [iCMSApplicationData sharedInstance].categoryListFlag = YES;
                                   NSMutableArray *inservalue = [[NSMutableArray alloc] init];
                                   for (int i = 0; i < [categoryList count]; i++)
                                   {
                                       datadict = [categoryList objectAtIndex:i];
                                       values = [datadict allValues];
                                      
                                       NSString *strcolumenname;
                                       NSString *strinsertvalues;
                                       for (int l = 0 ; l < [arrallkey count]; l++)
                                       {
                                           NSString* Strings = [[NSString alloc] init];
                                           if ([[values objectAtIndex:l] isKindOfClass:[NSArray class]])
                                           {
                                               // do somthing
                                               NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                               Strings = [dictval JSONString];
                                               [inservalue addObject:Strings];
                                           }
                                           else if ([[values objectAtIndex:l] isKindOfClass:[NSDictionary class]])
                                           {
                                               // do somthing
                                               NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                               Strings = [dictval JSONString];
                                               [inservalue addObject:Strings];
                                           }
                                           else
                                           {
                                               // do somthing
                                               if ([arrayiCMSFieldconstant containsObject:[arrallkey objectAtIndex:l]])
                                               {
                                                   NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                                   Strings = [dictval JSONString];
                                                   [inservalue addObject:Strings];
                                               }
                                               else
                                               {
                                                   [inservalue addObject:[values objectAtIndex:l]];
                                                   
                                                   Strings = [values objectAtIndex:l];
                                               }
                                           }
                                           
                                           if (l == 0) {
                                               strcolumenname = [NSString stringWithFormat:@"%@",[arrallkey objectAtIndex:l]];
                                               if ([Strings isKindOfClass:[NSString class]]) {
                                                   
                                                   Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                               }
                                               strinsertvalues = [NSString stringWithFormat:@"\"%@\"",Strings];
                                           }
                                           else
                                           {
                                               strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,[arrallkey objectAtIndex:l]];
                                               if ([Strings isKindOfClass:[NSString class]]) {
                                                   
                                                   Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                               }
                                               strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,Strings];
                                           }
                                       }
                                       
                                       
                                       strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,@"REQObject"];
                                       
                                       strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self JsonstringRemoveChar:json]];
                                       
                                       NSString *QUR = [NSString stringWithFormat:@"INSERT INTO iCMS%@ (%@) VALUES (%@);",extTask,strcolumenname, strinsertvalues];

                                       [icmsdata insertData:QUR];
                                   }
                               }
                               [iCMSApplicationData sharedInstance].categoryListFlag = NO;
                           }
                       }
                   });
}

//category list fetch with artical and store in database code
+(NSDictionary *)iCMSArticalListWith_Category:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata;
{
    
    NSString *jsonString = [[NSString alloc] init];
    jsonString = [iCMS CreateDictionary_iCMS:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    int cat = 0;
    int artical = 0;
    iCMSDatabaseObject *icmsdata = [[iCMSDatabaseObject alloc] init];
    NSDictionary *dict;
    
    int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
    
    int kp = [icmsdata CheckDataExist:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ where REQObject = \"%@\"",[NSString stringWithFormat:@"iCMS%@",extTask], [self JsonstringRemoveChar:jsonString]]];
    
    int kl1 = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMSarticles"]];
    
    
    int kp1 = [icmsdata CheckDataExist:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ where REQObject = \"%@\"",[NSString stringWithFormat:@"iCMSarticles"], [self JsonstringRemoveChar:jsonString]]];
    
    NSArray * arrcategories;
    NSArray * arrarticles;

    if (kl && kp)
    {
        
        arrcategories = [icmsdata getiCMSData:[NSString stringWithFormat:@"SELECT * FROM %@ where parent_id = \"%@\" AND REQObject = \"%@\"",[NSString stringWithFormat:@"iCMS%@",extTask],[Taskdatadict objectForKey:@"id"], [self JsonstringRemoveChar:jsonString]]];
        
        if ([arrcategories count] > 0) {
            cat = 1;
        }
    }
    
    if (kp1 && kl1) {
        
        arrarticles = [icmsdata getiCMSData:[NSString stringWithFormat:@"SELECT * FROM %@ where catid = \"%@\" AND REQObject = \"%@\"",[NSString stringWithFormat:@"iCMSarticles"],[Taskdatadict objectForKey:@"id"], [self JsonstringRemoveChar:[self JsonstringRemoveChar:jsonString]]]];
        
        if ([arrarticles count] > 0)
        {
            artical = 1;
        }
    }
    
    if (artical || cat) {
        
        dict = [NSDictionary dictionaryWithObjectsAndKeys:arrcategories,@"categories",[NSString stringWithFormat:@"200"],@"code",arrarticles,@"articles", nil];
   
        [self iCMSArticalListWith_Categorydatastore:jsonString ExtTask:extTask catinsert:cat articalinsert:artical TaskdataDictionary:Taskdatadict];
        
        return  dict;
    }
    else
    {
        dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:nil];
        
        [self iCMSArticalListWith_Categorydatastore:jsonString ExtTask:extTask catinsert:cat articalinsert:artical TaskdataDictionary:Taskdatadict];
        
        return  dict;
    }
    
    return dict;
}

//category list fetch with artical and store in database code
+(void)iCMSArticalListWith_Categorydatastore :(NSString *) json ExtTask:(NSString *) extTask catinsert:(int)catflag articalinsert:(int)articalflag TaskdataDictionary :(NSMutableDictionary *) Taskdatadict
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL),
                   ^(void)
                   {
                       if (![iCMSApplicationData sharedInstance].categoryListFlag && ![iCMSApplicationData sharedInstance].articalListFlag) {
                           
                           NSDictionary *dict = [JoomlaRegistration JoomSocialDictionary:json Imagedata:nil];
                           
                           iCMSDatabaseObject *icmsdata = [[iCMSDatabaseObject alloc] init];
                           if ([[dict valueForKey:@"code"] intValue] == 200)
                           {
                               [iCMSApplicationData sharedInstance].pageLimit = [[dict objectForKey:@"pageLimit"] intValue];
                               [iCMSApplicationData sharedInstance].totalArticle = [[dict objectForKey:@"total"] intValue];
                               NSLog(@"json: %@",json);
                               if (![iCMSApplicationData sharedInstance].categoryListFlag) {
                                   
                                   NSArray *categoryList = [dict objectForKey:@"categories"];
                                   if ([categoryList isKindOfClass:[NSArray class]])
                                   {
                                       NSArray *arrallkey;
                                       NSArray *values;
                                       NSDictionary *datadict;
                                       if ([categoryList count] > 0)
                                       {
                                           datadict = [categoryList objectAtIndex:0];
                                           arrallkey = [datadict allKeys];
                                           values = [datadict allValues];
                                           
                                           int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
                                           if (kl == 0)
                                           {
                                               NSString *Query = [iCMS Createtablestring:arrallkey allvalues:values];
                                               Query = [NSString stringWithFormat:@"CREATE TABLE iCMS%@ (%@)", extTask, Query];
                                               
                                               [icmsdata CreateTable:Query];
                                           }
                                       }
                                       
                                       //if (![iCMSApplicationData sharedInstance].categoryListFlag) {

                                           [icmsdata deleteData:[NSString stringWithFormat:@"delete from iCMScategory where parent_id = \"%@\" AND REQObject = \"%@\"",[Taskdatadict objectForKey:@"id"], [self JsonstringRemoveChar:json]]];
                                       //}
                                       [iCMSApplicationData sharedInstance].categoryListFlag = YES;
                                       
                                       NSMutableArray *inservalue = [[NSMutableArray alloc] init];
                                       for (int i = 0; i < [categoryList count]; i++)
                                       {
                                           datadict = [categoryList objectAtIndex:i];
                                           values = [datadict allValues];
                                           NSString *strcolumenname;
                                           NSString *strinsertvalues;
                                           for (int l = 0 ; l < [arrallkey count]; l++)
                                           {
                                               NSString* Strings = [[NSString alloc] init];
                                               if ([[values objectAtIndex:l] isKindOfClass:[NSArray class]])
                                               {
                                                   // do somthing
                                                   NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                                   Strings = [dictval JSONString];
                                                   [inservalue addObject:Strings];
                                               }
                                               else if ([[values objectAtIndex:l] isKindOfClass:[NSDictionary class]])
                                               {
                                                   // do somthing
                                                   NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                                   Strings = [dictval JSONString];
                                                   [inservalue addObject:Strings];
                                               }
                                               else
                                               {
                                                   // do somthing
                                                   if ([arrayiCMSFieldconstant containsObject:[arrallkey objectAtIndex:l]])
                                                   {
                                                       NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                                       Strings = [dictval JSONString];
                                                       [inservalue addObject:Strings];
                                                   }
                                                   else
                                                   {
                                                       [inservalue addObject:[values objectAtIndex:l]];
                                                       
                                                       Strings = [values objectAtIndex:l];
                                                   }
                                               }

                                               if (l == 0) {
                                                   strcolumenname = [NSString stringWithFormat:@"%@",[arrallkey objectAtIndex:l]];
                                                   if ([Strings isKindOfClass:[NSString class]]) {
                                                       Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                                   }
                                                   
                                                   strinsertvalues = [NSString stringWithFormat:@"\"%@\"",Strings];
                                               }
                                               else
                                               {
                                                   strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,[arrallkey objectAtIndex:l]];
                                                   if ([Strings isKindOfClass:[NSString class]]) {
                                                       Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                                   }
                                                   strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,Strings];
                                               }
                                           }
                                           
                                           
                                           strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,@"REQObject"];
                                           
                                           strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self JsonstringRemoveChar:json]];
                                           
                                           NSString *QUR = [NSString stringWithFormat:@"INSERT INTO iCMS%@ (%@) VALUES (%@);",extTask,strcolumenname, strinsertvalues];
                                           
                                           [icmsdata insertData:QUR];
                                       }
                                       
                                       [iCMSApplicationData sharedInstance].categoryListFlag = NO;
                                   }
                               }
                               
                               if (![iCMSApplicationData sharedInstance].articalListFlag) {
                                   
                                   NSArray *articalList = [dict objectForKey:@"articles"];
                                   if ([articalList isKindOfClass:[NSArray class]])
                                   {
                                       NSArray *arrallkey;
                                       NSArray *values;
                                       NSDictionary *datadict;
                                       if ([articalList count] > 0)
                                       {
                                           datadict = [articalList objectAtIndex:0];
                                           arrallkey = [datadict allKeys];
                                           values = [datadict allValues];
                                           
                                           int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMSarticles"]];
                                           if (kl == 0)
                                           {
                                               NSString *Query = [iCMS Createtablestring:arrallkey allvalues:values];
                                               Query = [NSString stringWithFormat:@"CREATE TABLE iCMSarticles (%@)", Query];

                                               [icmsdata CreateTable:Query];
                                           }
                                       }
                                       //if (![iCMSApplicationData sharedInstance].articalListFlag) {
                                           
                                           [icmsdata deleteData:[NSString stringWithFormat:@"delete from iCMSarticles where catid = %@ AND REQObject = \"%@\"",[Taskdatadict objectForKey:@"id"], [self JsonstringRemoveChar:json]]];
                                      // }
                                       [iCMSApplicationData sharedInstance].articalListFlag = YES;
                                       NSMutableArray *inservalue = [[NSMutableArray alloc] init];
                                       for (int i = 0; i < [articalList count]; i++)
                                       {
                                           datadict = [articalList objectAtIndex:i];
                                           values = [datadict allValues];
                                           NSString *strcolumenname;
                                           NSString *strinsertvalues;
                                           for (int l = 0 ; l < [arrallkey count]; l++)
                                           {
                                               NSString* Strings = [[NSString alloc] init];
                                               if ([[values objectAtIndex:l] isKindOfClass:[NSArray class]])
                                               {
                                                   // do somthing
                                                   NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                                   Strings = [dictval JSONString];
                                                   [inservalue addObject:Strings];
                                               }
                                               else if ([[values objectAtIndex:l] isKindOfClass:[NSDictionary class]])
                                               {
                                                   // do somthing
                                                   NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                                   Strings = [dictval JSONString];
                                                   [inservalue addObject:Strings];
                                               }
                                               else
                                               {
                                                   // do somthing
                                                   if ([arrayiCMSFieldconstant containsObject:[arrallkey objectAtIndex:l]])
                                                   {
                                                       NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                                       Strings = [dictval JSONString];
                                                       [inservalue addObject:Strings];
                                                   }
                                                   else
                                                   {
                                                       [inservalue addObject:[values objectAtIndex:l]];

                                                       Strings = [values objectAtIndex:l];
                                                   }
                                               }
                                               
                                               if (l == 0) {
                                                   strcolumenname = [NSString stringWithFormat:@"%@",[arrallkey objectAtIndex:l]];
                                                   Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                                   strinsertvalues = [NSString stringWithFormat:@"\"%@\"",Strings];
                                               }
                                               else
                                               {
                                                   strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,[arrallkey objectAtIndex:l]];
                                                   Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                                   strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,Strings];
                                               }
                                           }
                                           
                                           
                                           strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,@"REQObject"];
                                           
                                           strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self JsonstringRemoveChar:json]];
                                           
                                           NSString *QUR = [NSString stringWithFormat:@"INSERT INTO iCMSarticles (%@) VALUES (%@);",strcolumenname, strinsertvalues];

                                           [icmsdata insertData:QUR];
                                       }
                                       [iCMSApplicationData sharedInstance].articalListFlag = NO;
                                   }
                               }
                           }
                           else
                           {
                               [iCMSApplicationData sharedInstance].categoryListFlag = NO;
                               [iCMSApplicationData sharedInstance].articalListFlag = NO;
                           }
                       }
                   });
}

/*Archive list fetch and store in databas.
 
 extView : articles
 extTask : archive
 extName : icms
 Taskdatadict : Dictionary of Post Variables.
 */
+(NSDictionary *)iCMSArchiveList:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    
    NSString *jsonString = [[NSString alloc] init];
    jsonString = [iCMS CreateDictionary_iCMS:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    iCMSDatabaseObject *icmsdata = [[iCMSDatabaseObject alloc] init];
    
    int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
    NSDictionary *dict;
    
    int kp = [icmsdata CheckDataExist:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ where REQObject = \"%@\"",[NSString stringWithFormat:@"iCMS%@",extTask],[self JsonstringRemoveChar:jsonString]]];

    
    if (kl && kp)
    {
        
        NSArray * arrcategories = [icmsdata getiCMSData:[NSString stringWithFormat:@"SELECT * FROM %@ where REQObject = \"%@\"",[NSString stringWithFormat:@"iCMS%@",extTask],[self JsonstringRemoveChar:jsonString]]];
        
        dict = [NSDictionary dictionaryWithObjectsAndKeys:arrcategories,@"articles",[NSString stringWithFormat:@"200"],@"code", nil];
        
        [self iCMSArchiveListdatastore:jsonString ExtTask:extTask];
        
        
        return dict;
    }
    else
    {
        
        dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:nil];
        
        if ([[dict valueForKey:@"code"] intValue] == 200)
        {
            [iCMSApplicationData sharedInstance].pageLimit = [[dict objectForKey:@"pageLimit"] intValue];
            [iCMSApplicationData sharedInstance].totalArchived = [[dict objectForKey:@"total"] intValue];
            
            [iCMSApplicationData sharedInstance].archiveListFlag = YES;
            NSArray *categoryList = [dict objectForKey:@"articles"];
            
            if ([categoryList isKindOfClass:[NSArray class]])
            {
                NSArray *arrallkey;
                NSArray *values;
                NSDictionary *datadict;
                if ([categoryList count] > 0)
                {
                    datadict = [categoryList objectAtIndex:0];
                    arrallkey = [datadict allKeys];
                    values = [datadict allValues];
                    
                    int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
                    if (kl == 0)
                    {
                        NSString *Query = [iCMS Createtablestring:arrallkey allvalues:values];
                        Query = [NSString stringWithFormat:@"CREATE TABLE iCMS%@ (%@)", extTask, Query];
                        [icmsdata CreateTable:Query];
                    }
                }
                
                NSMutableArray *inservalue = [[NSMutableArray alloc] init];
                for (int i = 0; i < [categoryList count]; i++)
                {
                    datadict = [categoryList objectAtIndex:i];
                    values = [datadict allValues];
                    NSString *strcolumenname;
                    NSString *strinsertvalues;
                    for (int l = 0 ; l < [arrallkey count]; l++)
                    {
                        NSString* Strings = [[NSString alloc] init];
                        if ([[values objectAtIndex:l] isKindOfClass:[NSArray class]])
                        {
                            // do somthing
                            NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                            Strings = [dictval JSONString];
                            [inservalue addObject:Strings];
                        }
                        else if ([[values objectAtIndex:l] isKindOfClass:[NSDictionary class]])
                        {
                            // do somthing
                            NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                            Strings = [dictval JSONString];
                            [inservalue addObject:Strings];
                        }
                        else
                        {
                            // do somthing
                            if ([arrayiCMSFieldconstant containsObject:[arrallkey objectAtIndex:l]])
                            {
                                NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                Strings = [dictval JSONString];
                                [inservalue addObject:Strings];
                            }
                            else
                            {
                                [inservalue addObject:[values objectAtIndex:i]];
                                Strings = [values objectAtIndex:l];
                            }
                        }
                        
                        if (l == 0) {
                            strcolumenname = [NSString stringWithFormat:@"%@",[arrallkey objectAtIndex:l]];
                            
                            if ([Strings isKindOfClass:[NSString class]]) {
                                
                                Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                            }
                            
                            strinsertvalues = [NSString stringWithFormat:@"\"%@\"",Strings];
                        }
                        else
                        {
                            strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,[arrallkey objectAtIndex:l]];
                            
                            if ([Strings isKindOfClass:[NSString class]]) {
                                
                                Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                            }
                            
                            strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,Strings];
                        }
                    }
                    
                    strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,@"REQObject"];
                    
                    strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self JsonstringRemoveChar:jsonString]];

                    NSString *QUR = [NSString stringWithFormat:@"INSERT INTO iCMS%@ (%@) VALUES (%@);",extTask,strcolumenname, strinsertvalues];

                    [icmsdata insertData:QUR];
                }
            }
            [iCMSApplicationData sharedInstance].archiveListFlag = NO;
        }
        return dict;
    }
    return dict;
}

//Archive list fetch and store in databas.
+(void)iCMSArchiveListdatastore :(NSString *) json ExtTask:(NSString *) extTask
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL),
                   ^(void)
                   {
                       if (![iCMSApplicationData sharedInstance].archiveListFlag) {
                           
                           iCMSDatabaseObject *icmsdata = [[iCMSDatabaseObject alloc] init];
                           NSDictionary *dict = [JoomlaRegistration JoomSocialDictionary:json Imagedata:nil];
                           
                           if ([[dict valueForKey:@"code"] intValue] == 200)
                           {
                               [iCMSApplicationData sharedInstance].pageLimit = [[dict objectForKey:@"pageLimit"] intValue];
                               [iCMSApplicationData sharedInstance].totalArchived = [[dict objectForKey:@"total"] intValue];
                               
                               NSArray *categoryList = [dict objectForKey:@"articles"];
                               
                               if ([categoryList isKindOfClass:[NSArray class]])
                               {
                                   NSArray *arrallkey;
                                   NSArray *values;
                                   NSDictionary *datadict;
                                   if ([categoryList count] > 0)
                                   {
                                       datadict = [categoryList objectAtIndex:0];
                                       arrallkey = [datadict allKeys];
                                       values = [datadict allValues];
                                       
                                       int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
                                       if (kl == 0)
                                       {
                                           NSString *Query = [iCMS Createtablestring:arrallkey allvalues:values];
                                           Query = [NSString stringWithFormat:@"CREATE TABLE iCMS%@ (%@)", extTask, Query];

                                           [icmsdata CreateTable:Query];
                                       }
                                   }
                                   
                                   if (![iCMSApplicationData sharedInstance].archiveListFlag) {
                                       
                                       [icmsdata deleteData:[NSString stringWithFormat:@"delete from iCMS%@ where REQObject = \"%@\"",extTask, [self JsonstringRemoveChar:json]]];
                                   }
                                   [iCMSApplicationData sharedInstance].archiveListFlag = YES;
                                   NSMutableArray *inservalue = [[NSMutableArray alloc] init];
                                   for (int i = 0; i < [categoryList count]; i++)
                                   {
                                       datadict = [categoryList objectAtIndex:i];
                                       values = [datadict allValues];
                                       NSString *strcolumenname;
                                       NSString *strinsertvalues;
                                       for (int l = 0 ; l < [arrallkey count]; l++)
                                       {
                                           NSString* Strings = [[NSString alloc] init];
                                           if ([[values objectAtIndex:l] isKindOfClass:[NSArray class]])
                                           {
                                               // do somthing
                                               NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                               Strings = [dictval JSONString];
                                               [inservalue addObject:Strings];
                                           }
                                           else if ([[values objectAtIndex:l] isKindOfClass:[NSDictionary class]])
                                           {
                                               // do somthing
                                               NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:i],[arrallkey objectAtIndex:l], nil];
                                               Strings = [dictval JSONString];
                                               [inservalue addObject:Strings];
                                           }
                                           else
                                           {
                                               // do somthing
                                               if ([arrayiCMSFieldconstant containsObject:[arrallkey objectAtIndex:i]])
                                               {
                                                   NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                                   Strings = [dictval JSONString];
                                                   [inservalue addObject:Strings];
                                               }
                                               else
                                               {
                                                   [inservalue addObject:[values objectAtIndex:l]];
                                                   Strings = [values objectAtIndex:l];
                                               }
                                           }
                                           
                                           if (l == 0) {
                                               strcolumenname = [NSString stringWithFormat:@"%@",[arrallkey objectAtIndex:l]];
                                               
                                               if ([Strings isKindOfClass:[NSString class]]) {
                                                   Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                               }
                                               
                                               strinsertvalues = [NSString stringWithFormat:@"\"%@\"",Strings];
                                           }
                                           else
                                           {
                                               strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,[arrallkey objectAtIndex:l]];
                                               
                                               if ([Strings isKindOfClass:[NSString class]]) {
                                                   
                                                   Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                               }
                                               
                                               strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,Strings];
                                           }
                                       }
                                       
                                       strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,@"REQObject"];
                                       
                                       strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self JsonstringRemoveChar:json]];

                                       NSString *QUR = [NSString stringWithFormat:@"INSERT INTO iCMS%@ (%@) VALUES (%@);",extTask,strcolumenname, strinsertvalues];

                                       [icmsdata insertData:QUR];
                                   }
                               }
                           }
                           [iCMSApplicationData sharedInstance].archiveListFlag = NO;
                       }
                       
                   });
}

/*Featured list fetch and store in database.

 
 extView : articles
 extTask : featured
 extName : icms
 Taskdatadict : Dictionary of Post Variables.
 */

+(NSDictionary *)iCMSFeaturedList:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    
    NSString *jsonString = [[NSString alloc] init];
    jsonString = [iCMS CreateDictionary_iCMS:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    iCMSDatabaseObject *icmsdata = [[iCMSDatabaseObject alloc] init];
    
    int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
    NSDictionary *dict;
    
    int kp = [icmsdata CheckDataExist:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ where REQObject = \"%@\"",[NSString stringWithFormat:@"iCMS%@",extTask],[self JsonstringRemoveChar:jsonString]]];
    
    if (kl && kp)
    {
        NSArray * arrcategories = [icmsdata getiCMSData:[NSString stringWithFormat:@"SELECT * FROM %@ where REQObject = \"%@\"",[NSString stringWithFormat:@"iCMS%@",extTask],[self JsonstringRemoveChar:jsonString]]];
        
        dict = [NSDictionary dictionaryWithObjectsAndKeys:arrcategories,@"articles",[NSString stringWithFormat:@"200"],@"code", nil];
        
        [self iCMSFeaturedListdatastore:jsonString ExtTask:extTask];
        
        return dict;
    }
    else
    {
        [iCMSApplicationData sharedInstance].feturedListFlag = YES;
        dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:nil];
        
        [iCMSApplicationData sharedInstance].pageLimit = [[dict objectForKey:@"pageLimit"] intValue];
        [iCMSApplicationData sharedInstance].totalFeatured = [[dict objectForKey:@"total"] intValue];
        
        if ([[dict valueForKey:@"code"] intValue] == 200)
        {
            
            [iCMSApplicationData sharedInstance].FeaturedpageLimit = [[dict objectForKey:@"pageLimit"] intValue];
            [iCMSApplicationData sharedInstance].totalFeatured = [[dict objectForKey:@"total"] intValue];
            
            //[iCMSApplicationData sharedInstance].feturedListFlag = YES;
            NSArray *categoryList = [dict objectForKey:@"articles"];
            
            if ([categoryList isKindOfClass:[NSArray class]])
            {
                NSArray *arrallkey;
                NSArray *values;
                NSDictionary *datadict;
                if ([categoryList count] > 0)
                {
                    datadict = [categoryList objectAtIndex:0];
                    arrallkey = [datadict allKeys];
                    values = [datadict allValues];
                    
                    int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
                    if (kl == 0)
                    {
                        NSString *Query = [iCMS Createtablestring:arrallkey allvalues:values];
                        Query = [NSString stringWithFormat:@"CREATE TABLE iCMS%@ (%@)", extTask, Query];
                        
                        [icmsdata CreateTable:Query];
                    }
                }
                
                NSMutableArray *inservalue = [[NSMutableArray alloc] init];
                for (int i = 0; i < [categoryList count]; i++)
                {
                    datadict = [categoryList objectAtIndex:i];
                    values = [datadict allValues];
                    NSString *strcolumenname;// = [[NSString alloc] init];
                    NSString *strinsertvalues;// = [[NSString alloc] init];
                    for (int l = 0 ; l < [arrallkey count]; l++)
                    {
                        NSString* Strings  = [[NSString alloc] init];
                        if ([[values objectAtIndex:l] isKindOfClass:[NSArray class]])
                        {
                            // do somthing
                            NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                            Strings = [dictval JSONString];
                            [inservalue addObject:Strings];
                        }
                        else if ([[values objectAtIndex:l] isKindOfClass:[NSDictionary class]])
                        {
                            // do somthing
                            NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                            Strings = [dictval JSONString];
                            [inservalue addObject:Strings];
                        }
                        else
                        {
                            // do somthing
                            if ([arrayiCMSFieldconstant containsObject:[arrallkey objectAtIndex:i]])
                            {
                                NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                Strings = [dictval JSONString];
                                [inservalue addObject:Strings];
                            }
                            else
                            {
                                [inservalue addObject:[values objectAtIndex:i]];
                                Strings = [values objectAtIndex:l];
                            }
                        }
                        
                        if (l == 0) {
                            strcolumenname = [NSString stringWithFormat:@"%@",[arrallkey objectAtIndex:l]];
                            
                            if ([Strings isKindOfClass:[NSString class]]) {
                                
                                Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                            }
                            
                            strinsertvalues = [NSString stringWithFormat:@"\"%@\"",Strings];
                        }
                        else
                        {
                            strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,[arrallkey objectAtIndex:l]];
                            
                            if ([Strings isKindOfClass:[NSString class]]) {
                                
                                Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                            }
                            
                            strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,Strings];
                        }
                    }
                    
                    strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,@"REQObject"];
                    
                    strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self JsonstringRemoveChar:jsonString]];

                    NSString *QUR = [NSString stringWithFormat:@"INSERT INTO iCMS%@ (%@) VALUES (%@);",extTask,strcolumenname, strinsertvalues];

                    [icmsdata insertData:QUR];
                }
            }
            [iCMSApplicationData sharedInstance].feturedListFlag = NO;
        }
        else
        {
            [iCMSApplicationData sharedInstance].feturedListFlag = NO;
        }
    }
    return dict;
}

//featured list fetch and store in database.
+(void)iCMSFeaturedListdatastore :(NSString *) json ExtTask:(NSString *) extTask
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL),
                   ^(void)
                   {
                       
                       if (![iCMSApplicationData sharedInstance].feturedListFlag) {
                           
                           [iCMSApplicationData sharedInstance].feturedListFlag = YES;
                           iCMSDatabaseObject *icmsdata = [[iCMSDatabaseObject alloc] init];
                           NSDictionary *dict = [JoomlaRegistration JoomSocialDictionary:json Imagedata:nil];
                           
                           if ([[dict valueForKey:@"code"] intValue] == 200)
                           {
                               
                               [iCMSApplicationData sharedInstance].pageLimit = [[dict objectForKey:@"pageLimit"] intValue];
                               [iCMSApplicationData sharedInstance].totalFeatured = [[dict objectForKey:@"total"] intValue];
                               
                               NSArray *categoryList = [dict objectForKey:@"articles"];
                               
                               if ([categoryList isKindOfClass:[NSArray class]])
                               {
                                   NSArray *arrallkey;
                                   NSArray *values;
                                   NSDictionary *datadict;
                                   if ([categoryList count] > 0)
                                   {
                                       datadict = [categoryList objectAtIndex:0];
                                       arrallkey = [datadict allKeys];
                                       values = [datadict allValues];
                                       
                                       int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
                                       if (kl == 0)
                                       {
                                           NSString *Query = [iCMS Createtablestring:arrallkey allvalues:values];
                                           Query = [NSString stringWithFormat:@"CREATE TABLE iCMS%@ (%@)", extTask, Query];

                                           [icmsdata CreateTable:Query];
                                       }
                                   }
                                   //if (![iCMSApplicationData sharedInstance].feturedListFlag) {
                                       
                                       [icmsdata deleteData:[NSString stringWithFormat:@"delete from iCMS%@ where REQObject =\"%@\"",extTask,[self JsonstringRemoveChar:json]]];
                                       
                                  // }
                                   //[iCMSApplicationData sharedInstance].feturedListFlag = YES;
                                   
                                   NSMutableArray *inservalue = [[NSMutableArray alloc] init];
                                   for (int i = 0; i < [categoryList count]; i++)
                                   {
                                       datadict = [categoryList objectAtIndex:i];
                                       values = [datadict allValues];
                                       NSString *strcolumenname;
                                       NSString *strinsertvalues;
                                       for (int l = 0 ; l < [arrallkey count]; l++)
                                       {
                                           NSString* Strings = [[NSString alloc] init];
                                           if ([[values objectAtIndex:l] isKindOfClass:[NSArray class]])
                                           {
                                               // do somthing
                                               NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                               Strings = [dictval JSONString];
                                               [inservalue addObject:Strings];
                                           }
                                           else if ([[values objectAtIndex:l] isKindOfClass:[NSDictionary class]])
                                           {
                                               // do somthing
                                               NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                               Strings = [dictval JSONString];
                                               [inservalue addObject:Strings];
                                           }
                                           else
                                           {
                                               // do somthing
                                               if ([arrayiCMSFieldconstant containsObject:[arrallkey objectAtIndex:i]])
                                               {
                                                   NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                                   Strings = [dictval JSONString];
                                                   [inservalue addObject:Strings];
                                               }
                                               else
                                               {
                                                   [inservalue addObject:[values objectAtIndex:i]];

                                                   Strings = [values objectAtIndex:l];
                                               }
                                           }
                                           
                                           if (l == 0) {
                                               strcolumenname = [NSString stringWithFormat:@"%@",[arrallkey objectAtIndex:l]];
                                               
                                               if ([Strings isKindOfClass:[NSString class]]) {
                                                   
                                                   Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                               }
                                               
                                               strinsertvalues = [NSString stringWithFormat:@"\"%@\"",Strings];
                                           }
                                           else
                                           {
                                               strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,[arrallkey objectAtIndex:l]];
                                               
                                               if ([Strings isKindOfClass:[NSString class]]) {
                                                   
                                                   Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                               }
                                               
                                               strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,Strings];
                                           }
                                       }
                                       
                                       strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,@"REQObject"];
                                       
                                       strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self JsonstringRemoveChar:json]];

                                       NSString *QUR = [NSString stringWithFormat:@"INSERT INTO iCMS%@ (%@) VALUES (%@);",extTask,strcolumenname, strinsertvalues];
                                       
                                       [icmsdata insertData:QUR];
                                   }
                                   
                                   [iCMSApplicationData sharedInstance].feturedListFlag = NO;
                               }
                           }
                           else
                           {
                               [iCMSApplicationData sharedInstance].feturedListFlag = NO;
                           }
                       }
                   });
}

/*
Artical detail fetch and store in database.
 
extView : articles
extTask : articleDetail
extName : icms
Taskdatadict : Dictionary of Post Variables.
 
 */
+(NSDictionary *)iCMSArticalDetailviewList:(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata articalid:(NSString *) articalid
{
    
    NSString *jsonString = [[NSString alloc] init];
    jsonString = [iCMS CreateDictionary_iCMS:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    iCMSDatabaseObject *icmsdata = [[iCMSDatabaseObject alloc] init];
    
    NSDictionary *dict;

    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:nil];
    
    if ([[dict valueForKey:@"code"] intValue] == 200)
    {
        
        NSDictionary *categoryList = [dict objectForKey:@"article"];
        
        if ([categoryList isKindOfClass:[NSDictionary class]])
        {
            NSArray *arrallkey;
            NSArray *values;
            
            NSDictionary *datadict;
            if ([categoryList count] > 0)
            {
                datadict = categoryList;
                arrallkey = [datadict allKeys];
                values  = [datadict allValues];
                
                int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
                if (kl == 0)
                {
                    NSString *Query = [iCMS Createtablestring:arrallkey allvalues:values];
                    
                    Query = [NSString stringWithFormat:@"CREATE TABLE iCMS%@ (%@)", extTask, Query];

                    [icmsdata CreateTable:Query];
                }
            }
            
            values = [datadict allValues];
            NSString *strcolumenname;
            NSString *strinsertvalues;
            for (int l = 0 ; l < [arrallkey count]; l++)
            {
                NSString* Strings = [[NSString alloc] init];
                
                if ([[values objectAtIndex:l] isKindOfClass:[NSArray class]])
                {
                    // do somthing
                    NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                    Strings = [dictval JSONString];
                }
                else if ([[values objectAtIndex:l] isKindOfClass:[NSDictionary class]])
                {
                    // do somthing
                    NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                    Strings = [dictval JSONString];
                }
                else
                {
                    // do somthing
                    if ([arrayiCMSFieldconstant containsObject:[arrallkey objectAtIndex:l]])
                    {
                        NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                        Strings = [dictval JSONString];
                    }
                    else
                    {
                        Strings = [values objectAtIndex:l];
                    }
                }
                
                if (l == 0) {
                    strcolumenname = [NSString stringWithFormat:@"%@",[arrallkey objectAtIndex:l]];

                    strinsertvalues = [NSString stringWithFormat:@"\"%@\"",[self HTMLStringRemoveChar:Strings]];
                }
                else
                {
                    strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,[arrallkey objectAtIndex:l]];
                    strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self HTMLStringRemoveChar:Strings]];
                }
            }
            
            strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,@"REQObject"];
            
            strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self JsonstringRemoveChar:jsonString]];
            
            NSString *QUR = [NSString stringWithFormat:@"INSERT INTO iCMS%@ (%@) VALUES (%@);",extTask,strcolumenname, strinsertvalues];
            
            [icmsdata insertData:QUR];
            
        }
    }
    
    return dict;
}

//Artical detail fetch and store in database.
+(void)iCMSArticalDetailListdatastore :(NSString *) json ExtTask:(NSString *) extTask articalid:(NSString *) articalid
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL),
                   ^(void)
                   {
                       
                       iCMSDatabaseObject *icmsdata = [[iCMSDatabaseObject alloc] init];
                       NSDictionary *dict = [JoomlaRegistration JoomSocialDictionary:json Imagedata:nil];
                       
                       if ([[dict valueForKey:@"code"] intValue] == 200)
                       {
                           
                           NSDictionary *categoryList = [dict objectForKey:@"article"];
                           
                           if ([categoryList isKindOfClass:[NSDictionary class]])
                           {
                               NSArray *arrallkey;
                               NSArray *values;
                               
                               NSDictionary *datadict;
                               if ([categoryList count] > 0)
                               {
                                   datadict = categoryList;
                                   arrallkey = [datadict allKeys];
                                   values  = [datadict allValues];
                                   
                                   int kl = [icmsdata CheckTableExist:[NSString stringWithFormat:@"iCMS%@",extTask]];
                                   if (kl == 0)
                                   {
                                       NSString *Query = [iCMS Createtablestring:arrallkey allvalues:values];
                                       Query = [NSString stringWithFormat:@"CREATE TABLE iCMS%@ (%@)", extTask, Query];

                                       [icmsdata CreateTable:Query];
                                   }
                               }
                               
                               values = [datadict allValues];
                               NSString *strcolumenname;
                               NSString *strinsertvalues;
                               for (int l = 0 ; l < [arrallkey count]; l++)
                               {
                                   NSString* Strings = [[NSString alloc] init];
                                   
                                   if ([[values objectAtIndex:l] isKindOfClass:[NSArray class]])
                                   {
                                       // do somthing
                                       NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                       Strings = [dictval JSONString];
                                   }
                                   else if ([[values objectAtIndex:l] isKindOfClass:[NSDictionary class]])
                                   {
                                       // do somthing
                                       NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                       Strings = [dictval JSONString];
                                   }
                                   else
                                   {
                                       // do somthing
                                       if ([arrayiCMSFieldconstant containsObject:[arrallkey objectAtIndex:l]])
                                       {
                                           NSDictionary *dictval = [NSDictionary dictionaryWithObjectsAndKeys:[values objectAtIndex:l],[arrallkey objectAtIndex:l], nil];
                                           Strings = [dictval JSONString];
                                       }
                                       else
                                       {
                                           Strings = [values objectAtIndex:l];
                                       }
                                   }
                                   
                                   if (l == 0) {
                                       strcolumenname = [NSString stringWithFormat:@"%@",[arrallkey objectAtIndex:l]];
                                       //Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                       strinsertvalues = [NSString stringWithFormat:@"\"%@\"",[self HTMLStringRemoveChar:Strings]];
                                   }
                                   else
                                   {
                                       strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,[arrallkey objectAtIndex:l]];
                                       //Strings = [Strings stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
                                       strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self HTMLStringRemoveChar:Strings]];
                                   }
                               }
                               
                               strcolumenname = [NSString stringWithFormat:@"%@,%@",strcolumenname,@"REQObject"];
                               
                               strinsertvalues = [NSString stringWithFormat:@"%@,\"%@\"",strinsertvalues,[self JsonstringRemoveChar:json]];

                               NSString *QUR = [NSString stringWithFormat:@"INSERT INTO iCMS%@ (%@) VALUES (%@);",extTask,strcolumenname, strinsertvalues];

                               [icmsdata insertData:QUR];
                               
                           }
                       }
                       
                   });
}

//create table string function.
+(NSString *)Createtablestring:(NSArray *)allkey allvalues:(NSArray *)allvalue
{
    NSString *strtablestr = [[NSString alloc] init];
    NSMutableArray *arrPK = [[NSMutableArray alloc] init];
    for (int i = 0; i < [allkey count]; i++)
    {
        if (i != 0)
        {
            
            strtablestr = [NSString stringWithFormat:@"%@,",strtablestr];
        }
        if ([[allvalue objectAtIndex:i] isKindOfClass:[NSArray class]])
        {
            // do somthing
            
            if ([strtablestr length] > 0)
            {
                strtablestr = [NSString stringWithFormat:@"%@ %@ TEXT",strtablestr,[allkey objectAtIndex:i]];
            }
            else
            {
                strtablestr = [NSString stringWithFormat:@"%@ TEXT",[allkey objectAtIndex:i]];
            }
        }
        else if ([[allvalue objectAtIndex:i] isKindOfClass:[NSDictionary class]])
        {
            // do somthing
            
            if ([strtablestr length] > 0)
            {
                strtablestr = [NSString stringWithFormat:@"%@ %@ TEXT",strtablestr,[allkey objectAtIndex:i]];
            }
            else
            {
                strtablestr = [NSString stringWithFormat:@"%@ TEXT",[allkey objectAtIndex:i]];
            }
        }
        else
        {
            // do somthing
            if ([strtablestr length] > 0)
            {
                if ([arrayiCMSFieldconstant containsObject:[allkey objectAtIndex:i]])
                {
                    strtablestr = [NSString stringWithFormat:@"%@ %@ TEXT",strtablestr,[allkey objectAtIndex:i]];
                }
                else if ([[[allkey objectAtIndex:i] lowercaseString] rangeOfString:@"id"].location == NSNotFound)
                {
                    strtablestr = [NSString stringWithFormat:@"%@ %@ VARCHAR",strtablestr,[allkey objectAtIndex:i]];
                }
                else
                {
                    strtablestr = [NSString stringWithFormat:@"%@ %@ VARCHAR PRIMARY KEY",strtablestr,[allkey objectAtIndex:i]];
                    [arrPK addObject:[allkey objectAtIndex:i]];
                }
            }
            else
            {
                if ([arrayiCMSFieldconstant containsObject:[allkey objectAtIndex:i]])
                {
                    strtablestr = [NSString stringWithFormat:@"%@ TEXT",[allkey objectAtIndex:i]];
                }
                else if ([[[allkey objectAtIndex:i] lowercaseString] rangeOfString:@"id"].location == NSNotFound)
                {
                    strtablestr = [NSString stringWithFormat:@"%@ VARCHAR",[allkey objectAtIndex:i]];
                }
                else
                {
                    strtablestr = [NSString stringWithFormat:@"%@ VARCHAR PRIMARY KEY",[allkey objectAtIndex:i]];
                    [arrPK addObject:[allkey objectAtIndex:i]];
                }
            }
        }
    }
    
    strtablestr = [NSString stringWithFormat:@"%@, REQObject VARCHAR",strtablestr];
    
    if ([arrPK count] > 1)
    {
        
        strtablestr = [strtablestr stringByReplacingOccurrencesOfString:@"PRIMARY KEY" withString:@"NOT NULL"];
        NSString *strPK;
        for (int k = 0; k < [arrPK count]; k++)
        {
            if (k == 0)
            {
                strPK = [arrPK objectAtIndex:k];
            }
            else
            {
                strPK = [NSString stringWithFormat:@"%@, %@", strPK, [arrPK objectAtIndex:k]];
            }
        }
        strtablestr =[NSString stringWithFormat: @"%@, PRIMARY KEY (%@)",strtablestr,strPK];
    }
    
    return strtablestr;
}

//string replace double quets with singal.
+(NSString *)JsonstringRemoveChar:(NSString *)json
{
    NSString *strtmp1 = [json stringByReplacingOccurrencesOfString: @"\"" withString:@"\\'"];
    return strtmp1;
}

//string replace singal quets with double.
+(NSString *)JsonstringAddChar:(NSString *)json
{
    NSString *strtmp1 = [json stringByReplacingOccurrencesOfString:@"\\'" withString:@"\""];
    return strtmp1;
}

//string replace double quets with singal.
+(NSString *)HTMLStringRemoveChar:(NSString *)json
{
    NSString *strtmp1 = [json stringByReplacingOccurrencesOfString: @"\"" withString:@"~**~"];
    return strtmp1;
}

//string replace singal quets with double.
+(NSString *)HTMLStringAddChar:(NSString *)json
{
    NSString *strtmp1 = [json stringByReplacingOccurrencesOfString:@"~**~" withString:@"\""];
    return strtmp1;
}

// Testing url

+(NSDictionary *)ClintTestURlPingResponce :(NSString *) extView ExtTask:(NSString *) extTask TaskdataDictionary :(NSMutableDictionary *) Taskdatadict Imagedata:(NSData *) imagedata
{
    NSString *jsonString = [[NSString alloc] init];
    jsonString = [iCMS CreateDictionary_iCMS:extView ExtTask:extTask TaskdataDictionary:Taskdatadict Imagedata:imagedata];
    
    NSDictionary *dict;
    
    dict = [JoomlaRegistration JoomSocialDictionary:jsonString Imagedata:nil];
    
    if ([[dict valueForKey:@"code"] intValue] != 200)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kServerURL];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return dict;
}

+(BOOL) DropAllTabl {
    
    iCMSDatabaseObject *icmsdata = [[iCMSDatabaseObject alloc] init];
    [icmsdata DropallTable];
    
    [[iCMSApplicationData sharedInstance].iCMSArchivedArticleList removeAllObjects];
    [[iCMSApplicationData sharedInstance].iCMSArticleList removeAllObjects];
    [[iCMSApplicationData sharedInstance].iCMSCategoryList removeAllObjects];
    [[iCMSApplicationData sharedInstance].iCMSFeaturedArticleList removeAllObjects];
    return YES;
}

@end
