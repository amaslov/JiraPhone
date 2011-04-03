//
//  IssueCell.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/2/11.
//  Copyright 2011 AMaslov. All rights reserved.

//  Used source code from http://cocoawithlove.com/2010/12/uitableview-construction-drawing-and.html

#import <UIKit/UIKit.h>
@class IssueDetailsViewController;

@interface IssueCell : UITableViewCell 
{
	IBOutlet UIView *content;
	NSArray *contentArray;
}
+ (NSString *)reuseIdentifier;
+ (NSString *)nibName;
+ (UITableViewCellStyle)style;
+ (CGFloat)rowHeight;

- (void)configureForData:(id)dataObject
			   tableView:(UITableView *)aTableView
			   indexPath:(NSIndexPath *)anIndexPath;
- (void)finishConstruction;
- (void)handleSelectionInTableView:(UITableView *)aTableView;

@end