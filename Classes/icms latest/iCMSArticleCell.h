//
//  iCMSArticleCell.h
//  iJoomer
//
//  Created by Tailored Solutions on 3/20/13.
//
//

#import <UIKit/UIKit.h>

@class iCMSArticle;

@interface iCMSArticleCell : UITableViewCell {
    
    IBOutlet UIImageView *thumbImg;
    IBOutlet UILabel *lblArticleTitle;
    IBOutlet UILabel *lblArticleDesc;
    IBOutlet UIButton *btnRemove;
    BOOL isFavoriteArticle;
    
    iCMSArticle *article;
}
@property BOOL isFavoriteArticle;
@property (nonatomic,retain) iCMSArticle *article;
@property (nonatomic,retain) IBOutlet UIButton *btnRemove;

- (void) reloadCell;

@end
