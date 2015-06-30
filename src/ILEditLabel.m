//
//  ILEditLabel.m
//  InitLife
//
//  Created by guodi.ggd on 6/29/15.
//  Copyright (c) 2015 guodi.ggd. All rights reserved.
//

#import "ILEditLabel.h"

@interface ILEditLabel()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ILEditLabel



- (void)setEditEnabled:(BOOL)editEnabled
{
    if (!_tapGesture)
    {
        _tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        self.userInteractionEnabled = YES;
        _tapGesture.numberOfTapsRequired = 1;
        _tapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:_tapGesture];
    }
    
    _editEnabled = editEnabled;
    if (!_editEnabled) {
        [self.textField resignFirstResponder];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_textField && CGRectEqualToRect(_textField.frame, self.bounds)) {
        _textField.frame = self.bounds;
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        if (!_textField) {
            _textField = [[UITextField alloc] initWithFrame:self.bounds];
            _textField.text = self.text;
            self.text = @"";
            _textField.delegate = self;
            [self addSubview:_textField];
            [_textField becomeFirstResponder];
        }
    }
}

#pragma mark - text field delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self endEdit];
}

- (void)endEdit
{
    if (_textField) {
        [_textField removeFromSuperview];
        _textField.delegate = nil;
        self.text = _textField.text;
        _textField = nil;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

- (BOOL)resignFirstResponder
{
    NSLog(@"editlabel resignFirstResponder");

    
    return [super resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    NSLog(@"editlabel canBecomeFirstResponder");
    BOOL can = [super canBecomeFirstResponder];
    if (self.editEnabled) {
        can = YES;
    }
    return can;
}
@end
