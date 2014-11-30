//
//  ViewController.m
//  NexusCodingTask
//
//  Created by jiao on 11/25/14.
//  Copyright (c) 2014 JiaoyangLi. All rights reserved.
//

#import "ViewController.h"

#define BASE_URL    @"https://services.nexusinds.com/DummySvc/DummySvc.svc"
#define PATH_TERM   @"/GetData/"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tableView = _tableView;

/*- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//table view methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//customize number of rows in table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductListTableCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductListTableCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.numberOfLines = 0;
    }
    
    cell.textLabel.text =  self.dataArray[indexPath.row][@"PartDescription"];
    return cell;
}

-(void)connection: (NSURLConnection *)CONNECTION didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    long errorCode = httpResponse.statusCode;
    NSString *fileMIMEType = [[httpResponse MIMEType] lowercaseString];
    NSLog(@"response is %ld, %@", errorCode, fileMIMEType);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(0) error:nil];
     self.dataArray = [NSMutableArray array];
     for (id object in dict) {
        NSArray *objectArray = [[NSArray alloc] initWithObjects:object, nil];
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"PartNum contains %@", _textField.text];
        NSArray* filteredData = [objectArray filteredArrayUsingPredicate:filterPredicate];

        if (filteredData.count != 0)
        {
            [self.dataArray addObjectsFromArray: filteredData];
        }
        else
        {
         NSLog(@"There is no matched product!");
        }
    }
    
    if ([self.dataArray count]) {
       self.tableView.hidden = NO;
       [self.tableView reloadData];
        NSLog(@"%@",self.dataArray);
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong Input" message:@"There is no matched product!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // inform the user
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
    NSLog(@"Connection failed! Error - %@ %@",
          
          [error localizedDescription],
          
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    // do something with the data
    
    // receivedData is declared as a method instance elsewhere
    
    NSLog(@"Succeeded!");
    
}

-(IBAction)GetData:(id)sender
{
    [self.textField resignFirstResponder];
    
    inputWord = _textField.text;
    NSString *requestString = [NSString stringWithFormat:@"%@%@%@",BASE_URL, PATH_TERM, inputWord];;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (IBAction)clearInput:(id)sender
{
    [self.textField resignFirstResponder];

    _textField.text = nil;
}


@end
