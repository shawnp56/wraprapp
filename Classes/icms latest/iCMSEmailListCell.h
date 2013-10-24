//
//  iCMSEmailListCell.h
//  iJoomer
//
//  Created by Tailored Solutions on 4/11/13.
//
//

#import <UIKit/UIKit.h>

@class Option;

@interface iCMSEmailListCell : UITableViewCell {

    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblEmail;
    IBOutlet UIImageView *thumbImg;
    
    IBOutlet UIImageView *checkImg;
    
    Option *option;
    
}

@property (nonatomic,retain) Option *option;
@property (nonatomic,retain) IBOutlet UIImageView *checkImg;

- (void) reloadCell;

@end
