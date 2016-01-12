//
//  SettingsViewController.m
//  TableViewStaticWH29
//
//  Created by Nikolay Berlioz on 12.01.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () 

@end

static NSString *kSettingsName     = @"name";
static NSString *kSettingsLastName = @"lastName";
static NSString *kSettingsLogin    = @"login";
static NSString *kSettingsPassword = @"password";
static NSString *kSettingsPhone    = @"phone";
static NSString *kSettingsEmail    = @"email";


@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Save and Load

- (void) saveData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.nameField.text forKey:kSettingsName];
    [userDefaults setObject:self.lastNameField.text forKey:kSettingsLastName];
    [userDefaults setObject:self.loginField.text forKey:kSettingsLogin];
    [userDefaults setObject:self.passwordField.text forKey:kSettingsPassword];
    [userDefaults setObject:self.phoneNumberField.text forKey:kSettingsPhone];
    [userDefaults setObject:self.emailField.text forKey:kSettingsEmail];
    
    [userDefaults synchronize];
}

- (void) loadData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    self.nameField.text = [userDefaults objectForKey:kSettingsName];
    self.lastNameField.text = [userDefaults objectForKey:kSettingsLastName];
    self.loginField.text = [userDefaults objectForKey:kSettingsLogin];
    self.passwordField.text = [userDefaults objectForKey:kSettingsPassword];
    self.phoneNumberField.text = [userDefaults objectForKey:kSettingsPhone];
    self.emailField.text = [userDefaults objectForKey:kSettingsEmail];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.nameField])
    {
        [self.lastNameField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.lastNameField])
    {
        [self.loginField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.loginField])
    {
        [self.passwordField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.passwordField])
    {
        [self.phoneNumberField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.phoneNumberField])
    {
        [self.emailField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.emailField])
    {
        [textField resignFirstResponder];
    }
    
    
    return YES;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    
    if ([textField isEqual:self.phoneNumberField])
    {
        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1)
        {
            return NO;
        }
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        
        newString = [validComponents componentsJoinedByString:@""];
        
        static const int localNumberMaxLenght = 7;
        static const int areaCodeMaxLenght = 3;
        static const int countryCodeMaxLenght = 1;
        
        if ([newString length] > localNumberMaxLenght + areaCodeMaxLenght + countryCodeMaxLenght)
        {
            return NO;
        }
        
        NSMutableString *phoneNumberString = [NSMutableString string];
        
        NSInteger localNumberLenght = MIN([newString length], localNumberMaxLenght);
        
        //local number
        if (localNumberLenght > 0)
        {
            NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLenght];
            
            [phoneNumberString appendString:number];
            
            if ([phoneNumberString length] > 3)
            {
                [phoneNumberString insertString:@"-" atIndex:3];
            }
        }
        //area code number
        if ([newString length] > localNumberMaxLenght)
        {
            NSInteger areaCodeLenght = MIN((int)[newString length] - localNumberMaxLenght, areaCodeMaxLenght);
            
            NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLenght - areaCodeLenght, areaCodeLenght);
            
            NSString *area = [newString substringWithRange:areaRange];
            
            area = [NSString stringWithFormat:@"(%@) ", area];
            
            [phoneNumberString insertString:area atIndex:0];
        }
        //country code  number
        if ([newString length] > localNumberMaxLenght + areaCodeMaxLenght)
        {
            NSInteger countryCodeLenght = MIN((int)[newString length] - localNumberMaxLenght - areaCodeMaxLenght, countryCodeMaxLenght);
            
            NSRange countryCodeRange = NSMakeRange(0, countryCodeLenght);
            
            NSString *countryCode = [newString substringWithRange:countryCodeRange];
            
            countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
            
            [phoneNumberString insertString:countryCode atIndex:0];
        }
        
        textField.text = phoneNumberString;
        
        return NO;
    }
    
    if ([textField isEqual:self.emailField])
    {
        NSString *emailString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSCharacterSet *setCheck = [NSCharacterSet characterSetWithCharactersInString:@"@"];
        
        NSArray *components = [emailString componentsSeparatedByCharactersInSet:setCheck];
        
        if ([components count] > 2)
        {
            return NO;
        }
    }
    
    
    return YES;
}

#pragma mark - Actions

- (IBAction)actionTextChanged:(UITextField *)sender
{
    [self saveData];
}












@end
