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
	NSString *jql;
	NSMutableArray *issues;
	NSMutableDictionary *priorityImages;
	UIActivityIndicatorView *activityIndicator;
}
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) Filter *filter;
@property (nonatomic, retain) NSString *jql;
@property (nonatomic, retain) NSMutableDictionary *priorityImages;

- (id)initForProject:(Project *)_project;
- (id)initForFilter:(Filter *)_filter;
- (id)initForJql:(NSString *)_jql;
- (IBAction)showActionSheet:(id)sender;
@end
