//
//  LoginViewController.m
//  ParseChat
//
//  Created by ezietz on 7/10/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)clickedSignUp:(id)sender {
    [self registerUser];
}

- (IBAction)clickedLogin:(id)sender {
    [self loginUser];
}

- (void)registerUser {
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.userField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            
            if ([self.userField.text isEqual:@""]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Username"
                                                                           message:@"Please enter a username"
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     // handle cancel response here. Doing nothing will dismiss the view.
                                                                 }];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if ([self.passwordField.text isEqual:@""]){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Password"
                                                                               message:@"Please enter a password"
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                                         // handle cancel response here. Doing nothing will dismiss the view.
                                                                     }];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:@"There was an error signing up or logging in."
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     // handle cancel response here. Doing nothing will dismiss the view.
                                                                 }];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        }
            else {
            NSLog(@"User registered successfully");
            }
        [self performSegueWithIdentifier:@"loginSegue" sender:nil];
    }];
}

- (void)loginUser {
    NSString *username = self.userField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

@end
