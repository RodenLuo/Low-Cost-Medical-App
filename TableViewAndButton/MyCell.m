//
//  MyCell.m
//  TableViewAndButton
//
//  Created by Roden on 9/22/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib
{
    // Initialization code
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width * 0.047, self.contentView.frame.size.height, self.contentView.frame.size.width, 1)];
    
    lineView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [self.contentView addSubview:lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
