//
//  CreateIssueController.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 1/10/11.
//  Copyright 2011 AMaslov. All rights reserved.
//
// Subclass of IssueDetailsController, added ability to edit fields. It inherits almost only table view grouped presentation.

#import <UIKit/UIKit.h>
#import "MutableIssueDetailCell.h"
#import "IssueDetailsController.h"
#import "CreateIssueDelegate.h"
#import "ConnectorDelegate.h"

@class Project;

@interface CreateIssueController : IssueDetailsController<ConnectorDelegate> {
	IBOutlet MutableIssueDetailCell *mutableCell;
	Project *project;
	id<CreateIssueDelegate> delegate;
}
@property (nonatomic, assign) id<CreateIssueDelegate> delegate;
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) IBOutlet MutableIssueDetailCell *mutableCell;

// _project - where create new issue
- (id)initForIssueInProject:(Project *)_project;

- (IBAction)doneAction;
@end
