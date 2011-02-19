//
//  IssuesController.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/16/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ConnectorDelegate.h"
#import "CreateIssueDelegate.h"

@class Project;
@interface IssuesController : UITableViewController<ConnectorDelegate, CreateIssueDelegate, UIActionSheetDelegate> {
	Project *project;	
	NSMutableArray *issues;
	UIActivityIndicatorView *activityIndicator;
}
@property (nonatomic, retain) Project *project;

- (id)initForProject:(Project *)_project;
- (IBAction)showActionSheet:(id)sender;
@end
