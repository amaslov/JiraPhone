//
//  TextFieldCell.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/2/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "IssueCell.h"

@interface TextFieldCell : IssueCell {
	
	UITextField *textField;
	UILabel *label;

}
@property (nonatomic, retain) UITextField *textField;


@end
