//
//  DetailViewController.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/2/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "IssueDetailsViewController.h"
#import "LabelCell.h"

@interface DetailViewController : IssueDetailsViewController {
	NSInteger rowIndex;

}
- (id)initWithRowIndex:(NSInteger)rowIndex;

@end
