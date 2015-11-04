//
//  ResultDetailViewController.m
//  AcronymsTest
//
//  Created by Yike Xue on 11/3/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import "ResultDetailViewController.h"

@interface ResultDetailViewController ()

@end

@implementation ResultDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.lfDetail != nil){
        self.Name.text = [NSString stringWithFormat:@"%@",[self.lfDetail objectForKey:@"lf"]];
        self.freqLabel.text = [NSString stringWithFormat:@"Frequence:%d",[[self.lfDetail objectForKey:@"freq"] intValue]];
        self.sinceLabel.text = [NSString stringWithFormat:@"Since:%d",[[self.lfDetail objectForKey:@"since"] intValue]];
        /***************************************/
        //There are some more elements could be shown, such as vars(with "lf","freq","since")
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
