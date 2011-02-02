//
//  CreateIssueDelegate.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 1/10/11.
//  Copyright 2011 AMaslov. All rights reserved.
//
#import <UIKit/UIKit.h>

@class Issue;
@protocol CreateIssueDelegate<NSObject>

- (void)didCreateNewIssue:(Issue *)_issue;

@end
