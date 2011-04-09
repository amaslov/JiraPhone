//
//  IssueDetailsViewController.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/2/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IssueDetailsViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
	IBOutlet UITableView *tableView;
	NSMutableArray *tableSections;
	UITextField *currentTextField;
	CGFloat textFieldAnimatedDistance;
	NSMutableArray *headerViews;
	BOOL constantRowHeight;
	BOOL useCustomHeaders;
	
}
@property (nonatomic, retain) UITextField *currentTextField;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) BOOL constantRowHeight;
@property (nonatomic, assign) BOOL useCustomHeaders;


- (NSArray *)sectionAtIndex:(NSInteger)aSectionIndex;
- (id)dataForRow:(NSInteger)aRowIndex inSection:(NSInteger)aSectionIndex;
- (NSArray *)allDataInSection:(NSInteger)aSectionIndex;
- (void)setData:(id)dataObject forRow:(NSInteger)aRowIndex inSection:(NSInteger)aSectionIndex;
- (void)refreshCellForRow:(NSInteger)aRowIndex inSection:(NSInteger)aSectionIndex;
- (Class)classForRow:(NSInteger)aRowIndex inSection:(NSInteger)aSectionIndex;
- (void)addSectionAtIndex:(NSInteger)aSectionIndex
			withAnimation:(UITableViewRowAnimation)animation;
- (void)removeRowAtIndex:(NSInteger)aRowIndex inSection:(NSInteger)aSectionIndex
		   withAnimation:(UITableViewRowAnimation)animation;
- (void)removeAllSectionsWithAnimation:(UITableViewRowAnimation)animation;
- (void)appendRowToSection:(NSInteger)aSectionIndex
				 cellClass:(Class)aClass
				  cellData:(id)cellData
			 withAnimation:(UITableViewRowAnimation)animation;
- (void)addRowAtIndex:(NSInteger)aRowIndex
			inSection:(NSInteger)aSectionIndex
			cellClass:(Class)aClass
			 cellData:(id)cellData
		withAnimation:(UITableViewRowAnimation)animation;
- (void)emptySectionAtIndex:(NSInteger)aSectionIndex
			  withAnimation:(UITableViewRowAnimation)animation;
- (void)removeSectionAtIndex:(NSInteger)aSectionIndex
			   withAnimation:(UITableViewRowAnimation)animation;
- (IBAction)dismissKeyboard:(id)sender;
- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;
- (void)refresh:(id)sender;
- (void)headerSectionsReordered;

@end


//
// PageViewCellDescription is the class used to store Class and data pairs for
// table rows.
//
@interface IssueViewCellDescription : NSObject
{
	Class cellClass;
	id cellData;
}

@property (nonatomic, assign, readonly) Class cellClass;
@property (nonatomic, retain) id cellData;

@end

