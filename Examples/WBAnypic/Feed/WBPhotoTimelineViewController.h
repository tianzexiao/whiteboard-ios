//
//  WBPhotoTimelineViewController.h
//  whiteboard
//
//  Created by prs-fueled on 9/9/13.
//  Copyright (c) 2013 Fueled. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBViewController.h"

@interface WBPhotoTimelineViewController : WBViewController <UITableViewDataSource,
                                                             UITableViewDelegate>

/**
 The main tableview that is being used for the photo timeline
 */
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

/**
 This array contains the Photo objects to be displayed in the
 */
@property (nonatomic, strong) NSArray *photos;

/**
 Sets and returns the value if the table is loading or not
 */
@property (nonatomic, assign) BOOL isLoading;

/**
 Flag for indicating if the load more cell should be added or not
 */
@property (nonatomic, assign) BOOL loadMore;

@property (nonatomic, assign) NSInteger photoOffset;

/**
 Checks to see if the cell is the load more cell
 */
- (BOOL)isLoadMoreCell:(NSInteger)row;

/**
 Sets the name of the nib that is being used for the table cell
 */
- (NSString *)tableCellNib;

- (void)showLoginScreen;

/**
 Sets the name of the nib that is being used for the load more cell
 */
- (NSString *)loadMoreTableCellNib;

@end
