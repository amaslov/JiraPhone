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
#import "MutableIssueDetailLink.h"
#import "MutableIssuePicker.h"
#import "IssueDetailsController.h"
#import "CreateIssueDelegate.h"
#import "ConnectorDelegate.h"

@class Project;

@interface CreateIssueController : IssueDetailsController<ConnectorDelegate> {
	IBOutlet MutableIssueDetailCell *mutableCell;
	IBOutlet MutableIssueDetailLink *mutableLink;
	UIPickerView *picker;
	UIBarButtonItem *doneButton;	// this button appears only when the picker is open
	Project *project;
	id<CreateIssueDelegate> delegate;
	NSArray *dataArray;

}
@property (nonatomic, assign) id<CreateIssueDelegate> delegate;
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) IBOutlet MutableIssueDetailCell *mutableCell;
@property (nonatomic, retain) IBOutlet MutableIssueDetailLink *mutableLink;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView; 
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) NSArray *dataArray; 

// _project - where create new issue
- (id)initForIssueInProject:(Project *)_project;

- (IBAction)doneAction;
//- (IBAction)doneAction:(id)sender;	// when the done button is clicked
- (IBAction)textFieldReturn:(id)sender;	// when the user has selected pickerview

@end
