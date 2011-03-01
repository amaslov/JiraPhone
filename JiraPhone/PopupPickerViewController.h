//
//  PopupPickerViewController.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 2/25/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PopupPickerViewController : UIViewController {
	IBOutlet UIPickerView *pickerView;
	NSMutableArray *list;
}

@end
