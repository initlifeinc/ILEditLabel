//
//  FirstViewController.m
//  ILCommonKitDemo
//
//  Created by guodi.ggd on 6/30/15.
//  Copyright (c) 2015 guodi.ggd. All rights reserved.
//

#import "FirstViewController.h"
#import "ILEditLabel.h"
@interface FirstViewController ()
@property (nonatomic, strong) ILEditLabel *editLabel;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"edit label demo";
    [[UIPasteboard generalPasteboard] setString:@""];//clear board first
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(clickEdit:)];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.editLabel = [[ILEditLabel alloc] initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40 , 30)];
    self.editLabel.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.93 alpha:1];
    self.editLabel.copyingBackgroundColor = [UIColor grayColor];
    self.editLabel.text = @"long press to copy, tap to edit";
    [self.editLabel setCopyingEnabled:YES];
    [self.view addSubview:self.editLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickEdit:(id)sender
{
    [self.editLabel setEditEnabled:!self.editLabel.editEnabled];
    NSString *title =  self.editLabel.editEnabled?@"Done":@"Edit";
    self.navigationItem.rightBarButtonItem.title =title;
}

- (IBAction)clickShowCopyButton:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *str = [pasteboard string];
    [[[UIAlertView alloc] initWithTitle:@"copy value is:" message:str delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    
}
@end
