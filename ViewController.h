//
//  ViewController.h
//  NexusCodingTask
//
//  Created by jiao on 11/25/14.
//  Copyright (c) 2014 JiaoyangLi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController <UITextFieldDelegate>
{
    NSString* inputWord;
    NSString* baseTerm;
    NSString *searchTerm;
}
@property (strong, nonatomic) IBOutlet UITextField* textField;
@property (nonatomic, strong) NSMutableArray* dataArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)GetData:(id)sender;
- (IBAction)clearInput:(id)sender;


@end

