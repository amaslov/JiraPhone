//
//  MutableIssueDetailCell.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 1/10/11.
//  Copyright 2011 AMaslov. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "RootCell.h"


@interface MutableIssueDetailCell : RootCell <UITextFieldDelegate> {
	IBOutlet UILabel *title;
	IBOutlet UITextField *textField;
	//NSString *valueField;
}
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UITextField *textField;
//@property (retain,nonatomic) NSString *valueField;

@end
