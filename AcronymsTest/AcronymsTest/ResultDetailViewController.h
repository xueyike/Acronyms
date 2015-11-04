//
//  ResultDetailViewController.h
//  AcronymsTest
//
//  Created by Yike Xue on 11/3/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultDetailViewController : UIViewController
@property (weak, nonatomic) NSDictionary *lfDetail;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *freqLabel;
@property (weak, nonatomic) IBOutlet UILabel *sinceLabel;

@end
