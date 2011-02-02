//
//  MutableIssueDetailCell.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 1/10/11.
//  Copyright 2011 AMaslov. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface MutableIssueDetailCell : UITableViewCell {
	IBOutlet UILabel *title;
	IBOutlet UITextField *textField;
}
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UITextField *textField;

@end
