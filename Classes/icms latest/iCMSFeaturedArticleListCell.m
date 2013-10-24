//
//  iCMSFeaturedArticleListCell.m
//  iJoomer
//
//  Created by Tailored Solutions on 4/8/13.
//
//

#import "iCMSFeaturedArticleListCell.h"
#import "iCMSArticle.h"
#import "ApplicationData.h"

@implementation iCMSFeaturedArticleListCell

@synthesize article;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) reloadCell {
    lblArticleTitle.text = article.article_title;
    lblArticleTitle.textColor = [ApplicationData sharedInstance].textcolorhead;
    lblArticleDesc.text = article.introtext;
    lblArticleDesc.textColor = [ApplicationData sharedInstance].textcolorhead;
    if (article.thumbImg) {
        thumbImg.image = article.thumbImg;
    }
    else {
        thumbImg.image = [UIImage imageNamed:@"icms_featured_default_image.png"];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
