//
//  ILEditLabel.m
//  InitLife
//
//  Created by guodi.ggd on 6/29/15.
//  Copyright (c) 2015 guodi.ggd. All rights reserved.
//

#import "ILEditLabel.h"
#import "ILPlaceholderTextView.h"

@interface ILEditLabel()<UITextViewDelegate>
@property (nonatomic, strong) ILPlaceholderTextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation ILEditLabel
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initEditLabel];
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        [self initEditLabel];
    }
    return self;
}

- (void)initEditLabel
{
    self.placeholderColor = [UIColor grayColor];
    self.placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self.textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"]) {
        //if (!self.editEnabled) {
            if(self.text.length == 0 && ![self.textView isFirstResponder]) {
                [self showPlaceholderLabel:YES];
            } else {
                [self showPlaceholderLabel:NO];
                self.textView.hidden = YES;
            }
        //}
    }
}

- (void)showPlaceholderLabel:(BOOL)show
{
    self.placeholderLabel.hidden = !show;
    self.placeholderLabel.textColor = self.placeholderColor;
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.font = self.font;
    
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
{
    [self setEditEnabled:editing];
    
}

- (void)setEditEnabled:(BOOL)editEnabled
{
    if (editEnabled)
    {
        if (!_tapGesture) {
            _tapGesture =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleSingleTap:)];
            self.userInteractionEnabled = YES;
            _tapGesture.numberOfTapsRequired = 1;
            _tapGesture.numberOfTouchesRequired = 1;
            [self addGestureRecognizer:_tapGesture];
        }
    } else {
        if (_tapGesture) {
            [self removeGestureRecognizer:_tapGesture];
            _tapGesture = nil;
        }
    }
    
    _editEnabled = editEnabled;
    if (!_editEnabled) {
//        if ([self.textView isFirstResponder]) {
//            [self.textView resignFirstResponder];
//        }
        self.textView.hidden = YES;
    } else  {
        //self.textView.text = self.text;
        //self.textView.hidden = NO;
    }
   // [self layoutIfNeeded];

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_textView && !CGRectEqualToRect(_textView.frame, self.bounds)) {
        _textView.frame = self.bounds;
    }
    if (_placeholderLabel && !CGRectEqualToRect(_placeholderLabel.frame, self.bounds)) {
        _placeholderLabel.frame = self.bounds;
    }
}

- (void)dealloc
{
    self.textView.delegate = nil;
    [self.textView removeObserver:self forKeyPath:@"text"];
    [self removeObserver:self forKeyPath:@"text"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        self.textView.font = self.font;
        self.textView.placeholder = self.placeholder;
        self.textView.textColor = self.textColor;
        self.textView.text = self.text;
        self.text = @"";
        self.textView.hidden = NO;
        
        [self.textView becomeFirstResponder];

    }
}

- (NSString *)text
{
    NSString *str = [super text];
    if (self.editEnabled
        && self.textView.hidden == NO
        && [self.textView isFirstResponder]) {
        str = self.textView.text;
    }
    return str;
}

- (ILPlaceholderTextView *)textView
{
    if (!_textView) {
        _textView = [[ILPlaceholderTextView alloc] initWithFrame:self.bounds];
        _textView.hidden = YES;
        _textView.editable = YES;
        //_textView.contentInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.textView.textContainer.lineFragmentPadding = 0;
        UIEdgeInsets ss = _textView.textContainerInset;
        _textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);//UIEdgeInsetsMake(0, -5, 0, -5);
        _textView.delegate = self;
        [self addSubview:_textView];
    }
    return _textView;
}


- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _placeholderLabel.frame = self.bounds;
        _placeholderLabel.hidden = YES;
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}
#pragma mark - text field delegate
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [self endEdit];
//}

- (void)endEdit
{
    if (_textView) {
        self.text = _textView.text;
    }
    if (self.editDelegate && [self.editDelegate respondsToSelector:@selector(didFinishEdit:)]) {
        [self.editDelegate didFinishEdit:self];
    }
}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField endEditing:YES];
//    return YES;
//}

- (BOOL)resignFirstResponder
{
    if (self.editDelegate && [self.editDelegate respondsToSelector:@selector(didFinishEdit:)]) {
        [self.editDelegate didFinishEdit:self];
    }
    
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


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.editDelegate && [self.editDelegate respondsToSelector:@selector(editLabelShouldBeginEditing:)]) {
        return [self.editDelegate editLabelShouldBeginEditing:self];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self endEdit];
    if (self.editDelegate && [self.editDelegate respondsToSelector:@selector(editLabelDidEndEditing:)]) {
        [self.editDelegate editLabelDidEndEditing:self];
    }
}
@end
