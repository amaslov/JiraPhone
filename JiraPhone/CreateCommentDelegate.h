//
//  CreateCommentDelegate.h
//  JiraPhone
//
//  Created by Matthew Gerrior on 6/5/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comment;
@protocol CreateCommentDelegate<NSObject>

- (void)didCreateNewComment;

@end
