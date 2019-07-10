//
//  ChatViewController.m
//  ParseChat
//
//  Created by ezietz on 7/10/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import "ChatViewController.h"
#import "Parse/Parse.h"
#import "ChatCell.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *messagesArray;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self onTimer];
}

- (IBAction)clickedSend:(id)sender {
    
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_fbu2019"];
    // Use the name of your outlet to get the text the user typed
    chatMessage[@"text"] = self.messageField.text;
    chatMessage[@"user"] = PFUser.currentUser;
    
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The message was saved!");
            self.messageField.text = @"";
        } else {
            NSLog(@"Problem saving message: %@", error.localizedDescription);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    PFObject *msg = self.messagesArray[indexPath.row];
    cell.messageLabel.text = msg[@"text"];
    
    PFUser *user = msg[@"user"];
    if (user != nil) {
        // User found! update username label with username
        cell.user.text = user.username;
    } else {
        // No user found, set default username
        cell.user.text = @"🤖";
    }
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messagesArray.count;
}

- (void)onTimer {
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Message_fbu2019"];
//    [query whereKey:@"likesCount" greaterThan:@100];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"user"];
    query.limit = 20;
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.messagesArray = posts;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

@end
