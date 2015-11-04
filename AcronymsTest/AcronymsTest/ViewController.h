//
//  ViewController.h
//  AcronymsTest
//
//  Created by Yike Xue on 11/3/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *acronymInputField;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (strong, nonatomic) NSMutableArray *searchResult;

- (IBAction)tapSearch:(id)sender;
@end

