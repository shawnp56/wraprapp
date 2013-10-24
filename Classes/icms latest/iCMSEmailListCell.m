//
//  iCMSEmailListCell.m
//  iJoomer
//
//  Created by Tailored Solutions on 4/11/13.
//
//

#import "iCMSEmailListCell.h"
#import "Option.h"

@implementation iCMSEmailListCell

@synthesize option,checkImg;

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
    
    thumbImg.image = option.thumbImg;
    lblName.text = option.name;
    lblEmail.text = option.email;
    
}

- (void)dealloc {
    [option release];
    [checkImg release];
    [thumbImg release];
    [super dealloc];
}
@end
