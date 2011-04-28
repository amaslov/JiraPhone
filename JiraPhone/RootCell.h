//
//  RootCell.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/27/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootCell : UITableViewCell  {
	NSString *valueField;
	//UITextField *textField;
}
@property (retain,nonatomic) NSString *valueField;
//@property (retain,nonatomic) UITextField *textField;

//-(void)textFieldDidEndEditing:(UITextField *)textField;
//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField;
@end
