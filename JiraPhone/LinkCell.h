//
//  LinkCell.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/27/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootCell.h"

@interface LinkCell : RootCell {
	UILabel *details;
}
@property (nonatomic, retain) UILabel *details;

@end
