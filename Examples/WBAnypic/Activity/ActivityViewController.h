//
//  ActivityViewController.h
//  whiteboard
//
//  Created by ttg-fueled on 9/20/13.
//  Copyright (c) 2013 Fueled. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBViewController.h"
#import "WBActivityCell.h"

@interface ActivityViewController : WBViewController <UITableViewDelegate, UITableViewDataSource, WBActivitycellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
