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
#import "LinkCell.h"
//#import "MutableIssuePicker.h"
#import "IssueDetailsController.h"
#import "CreateIssueDelegate.h"
#import "ConnectorDelegate.h"
#import "Issue.h"
#import "ActionSheetPicker.h"
#import "User.h"

@class Project;

@interface CreateIssueController : IssueDetailsController<ConnectorDelegate, UITextFieldDelegate> {
	IBOutlet MutableIssueDetailCell *mutableCell;
	IBOutlet LinkCell *mutableLink;
	Project *project;
	Issue *newIssue;
	NSMutableArray * _pickerViewArray;
	NSInteger selectedIndex;
	NSMutableArray * _groupArray;
	id<CreateIssueDelegate> delegate;
}
@property (nonatomic, assign) id<CreateIssueDelegate> delegate;
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) IBOutlet MutableIssueDetailCell *mutableCell;
@property (nonatomic, retain) IBOutlet LinkCell *mutableLink;
@property (nonatomic, retain) NSMutableArray *pickerViewArray;
@property (nonatomic, retain) NSMutableArray *groupArray;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic,retain) Issue *newIssue;
// _project - where create new issue
- (id)initForIssueInProject:(Project *)_project;

- (IBAction)doneAction;
//- (IBAction)doneAction:(id)sender;	// when the done button is clicked
//- (IBAction)textFieldReturn:(id)sender;	// when the user has selected pickerview

@end
