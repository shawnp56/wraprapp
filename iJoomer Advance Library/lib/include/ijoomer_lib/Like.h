//
//  Like.h
//  iJoomer
//
//  Created by Tailored Solutions on 20/09/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Like : UIView {

}

@property(assign) int code;
@property (assign)int likeId;
@property (assign)int userId;
@property(nonatomic,retain) NSString *Error_msg;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *description;

@end
