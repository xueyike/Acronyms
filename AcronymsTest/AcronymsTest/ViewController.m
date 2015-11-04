//
//  ViewController.m
//  AcronymsTest
//
//  Created by Yike Xue on 11/3/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "ResultDetailViewController.h"

static NSString * const BaseURLString = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";
static NSInteger const INTERNET_TIMEOUT = 20;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageLabel.text = [NSString stringWithFormat:@"Search for its corresponding meanings."];
    self.messageLabel.textColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapSearch:(id)sender {
    [self.acronymInputField resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //Make sure the input is valid(non-empty)
    if([self validInput]){
        //For ios6 and above
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //For ios7 and above
        //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSDictionary *parameters = @{@"sf": [NSString stringWithFormat:@"%@",[self.acronymInputField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]};
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = INTERNET_TIMEOUT;
        [manager GET:BaseURLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //deal with response with NSJSONSerialization
            //Receive response as NSData
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            if([jsonArray count] > 0){
                self.searchResult = [[NSMutableArray alloc] init];
                NSDictionary *lfsDict = jsonArray[0];
                NSArray *lfsArray = [lfsDict objectForKey:@"lfs"];
                for(NSDictionary *lfDict in lfsArray){
                    [self.searchResult addObject:lfDict];
                    /***************************************************/
                    //Here we can present a new view controller to show the detail of the cell by sending the var to next view controller,
                    //including one or more sets of "freq", "lf", "since"
                }
                
                //UI update should execute in Main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                        [self.resultTableView reloadData];
                        self.messageLabel.text = [NSString stringWithFormat:@"Search for its corresponding meanings."];
                        self.messageLabel.textColor = [UIColor blueColor];
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
            }else{
                self.searchResult = nil;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.resultTableView reloadData];
                    self.messageLabel.text = [NSString stringWithFormat:@"*** No Matching Result! ***"];
                    self.messageLabel.textColor = [UIColor redColor];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.messageLabel.text = [NSString stringWithFormat:@"Error! Please check your network setting."];
                self.messageLabel.textColor = [UIColor redColor];
            });
            NSLog(@"Error: %@", error);
        }];

    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.messageLabel.text = @"Please input a valid acronym!";
            self.messageLabel.textColor = [UIColor redColor];
        });
    }
    
}
- (IBAction)didEndOnExit:(id)sender {
    [self resignFirstResponder];
}

- (bool) validInput{
    //Check if the key word is empty or single letter. Later on we can add more constraints
    if([[self.acronymInputField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] < 2){
        return NO;
    }else{
        return YES;
    }
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.searchResult != nil && [self.searchResult count] > 0) ? [self.searchResult count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseIdentifier = @"ResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];

    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.searchResult[indexPath.row] objectForKey:@"lf"]];
    
    return cell;
}

// #pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Get the new view controller using [segue destinationViewController].
    //Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showDetail"]){
        ResultDetailViewController *destination = segue.destinationViewController;
        NSIndexPath *indexPath = [self.resultTableView indexPathForCell:sender];
        if ([destination respondsToSelector:@selector(setLfDetail:)]) {
            NSDictionary *dict = self.searchResult[indexPath.row];
            [destination setValue:dict forKey:@"lfDetail"]; ;
        }
    }
}
@end
