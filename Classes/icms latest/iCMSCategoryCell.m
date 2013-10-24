//
//  iCMSCategoryCell.m
//  iJoomer
//
//  Created by Tailored Solutions on 3/20/13.
//
//

#import "iCMSCategoryCell.h"
#import "iCMSCategory.h"
#import "ApplicationData.h"

@implementation iCMSCategoryCell

@synthesize category;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) reloadCell {

    lblCategoryName.text = category.category_name;
    lblCategoryName.font = [ApplicationData sharedInstance].header4;
//    lblCategoryName.textColor = [ApplicationData sharedInstance].textcolor;
    lblArticleCnt.text = [NSString stringWithFormat:@"(%d)",category.totalArticles];
//    lblArticleCnt.textColor = [ApplicationData sharedInstance].textcolor;
    lblArticleCnt.font = [ApplicationData sharedInstance].header4;
    if (category.thumbImg) {
        thumbImg.image = category.thumbImg;
    }
    else {
        thumbImg.image = [UIImage imageNamed:@"icms_cat_default.png"];
    }
}

@end
