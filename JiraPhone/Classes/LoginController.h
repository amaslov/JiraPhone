//
//  LoginController.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/15/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ConnectorDelegate.h"

@interface LoginController : UIViewController<ConnectorDelegate> {
	IBOutlet UITextField *nameField;
	IBOutlet UITextField *passwordField;
	IBOutlet UITextField *serverField;	
	
	UIActivityIndicatorView *activityIndicator;
	IBOutlet UISwitch *switchControl;
}
@property(nonatomic, retain) IBOutlet UISwitch *switchControl;
@property(nonatomic, retain) IBOutlet UITextField *nameField;
@property(nonatomic, retain) IBOutlet UITextField *passwordField;
@property(nonatomic, retain) IBOutlet UITextField *serverField;

- (IBAction)loginAction;
- (IBAction)logoutAction;
- (IBAction)bgClick;
- (IBAction)switchAction;

@end
