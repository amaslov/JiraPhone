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
@class Filter;
@interface IssuesController : UITableViewController<ConnectorDelegate, CreateIssueDelegate, UIActionSheetDelegate> {
	Project *project;
	Filter *filter;
	NSMutableArray *issues;
	UIActivityIndicatorView *activityIndicator;
}
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) Filter *filter;

- (id)initForProject:(Project *)_project;
- (id)initForFilter:(Filter *)_filter;
- (IBAction)showActionSheet:(id)sender;
@end
