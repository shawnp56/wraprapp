//
//  iCMSFeaturedArticleListCell.h
//  iJoomer
//
//  Created by Tailored Solutions on 4/8/13.
//
//

#import "TableCellOwner.h"

@class iCMSArticle;

@interface iCMSFeaturedArticleListCell : TableCellOwner {

    IBOutlet UIImageView *thumbImg;
    IBOutlet UILabel *lblArticleTitle;
    IBOutlet UILabel *lblArticleDesc;
    
    
    iCMSArticle *article;
}

@property (nonatomic,retain) iCMSArticle *article;

- (void) reloadCell;


@end
