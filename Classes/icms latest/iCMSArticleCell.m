//
//  iCMSArticleCell.m
//  iJoomer
//
//  Created by Tailored Solutions on 3/20/13.
//
//

#import "iCMSArticleCell.h"
#import "iCMSArticle.h"

@implementation iCMSArticleCell

@synthesize article;
@synthesize btnRemove;
@synthesize isFavoriteArticle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) reloadCell {
 
    if (isFavoriteArticle) {
        btnRemove.hidden = NO;
    }
    else {
        btnRemove.hidden = YES;
    }
    
    lblArticleTitle.text = article.article_title;
    lblArticleDesc.text = article.introtext;
    if (article.thumbImg) {
        thumbImg.image = article.thumbImg;
    }
    else {
        thumbImg.image = [UIImage imageNamed:@"icms_article_default_image.png"];
    }
}

- (void)dealloc {
    [btnRemove release];
    [super dealloc];
}
@end
