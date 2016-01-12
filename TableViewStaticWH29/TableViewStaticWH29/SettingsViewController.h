//
//  SettingsViewController.h
//  TableViewStaticWH29
//
//  Created by Nikolay Berlioz on 12.01.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;


- (IBAction)actionTextChanged:(UITextField *)sender;





@end
