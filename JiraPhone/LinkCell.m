//
//  LinkCell.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/27/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "LinkCell.h"


@implementation LinkCell

@synthesize details;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[details release];
    [super dealloc];
}


@end
