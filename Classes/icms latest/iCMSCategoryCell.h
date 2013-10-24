//
//  iCMSCategoryCell.h
//  iJoomer
//
//  Created by Tailored Solutions on 3/20/13.
//
//

#import <UIKit/UIKit.h>

@class iCMSCategory;

@interface iCMSCategoryCell : UITableViewCell {

    IBOutlet UIView *backView;
    IBOutlet UIImageView *thumbImg;
    IBOutlet UILabel *lblCategoryName;
    IBOutlet UILabel *lblArticleCnt;
    
    iCMSCategory *category;
}

@property (nonatomic,retain) iCMSCategory *category;

- (void) reloadCell;

@end
