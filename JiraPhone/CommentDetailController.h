//
//  CommentDetailController.h
//  JiraPhone
//
//  Created by Matthew Gerrior on 6/5/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import "ConnectorDelegate.h"
#import "CreateCommentDelegate.h"

#define numberOfEditableRows 1
#define commentBodyRowIndex 0

#define kLabelTag 4096

@interface CommentDetailController : UITableViewController 
	<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ConnectorDelegate>{
		Comment *newComment;
		NSString *tempBody;
		NSString *issueKey;
		UITextField *textFieldBeingEdited;
		id<CreateCommentDelegate> delegate;
}

@property (nonatomic, retain) id<CreateCommentDelegate> delegate;
@property (nonatomic, retain) Comment *newComment;
@property (nonatomic, retain) NSString *tempBody;
@property (nonatomic, retain) NSString *issueKey;
@property (nonatomic, retain) UITextField *textFieldBeingEdited;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)textFieldDone:(id)sender;

@end
