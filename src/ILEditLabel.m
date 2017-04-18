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
- (id)init
{
    if (self = [super init]) {
        [self initEditLabel];
    }
    return self;
}

+ (UIColor *)defaultPlaceholderColor
{
    return [UIColor colorWithRed:0 green:0 blue:0.098 alpha:0.22];
}

- (void)initEditLabel
{
    self.isEditable = YES;
    self.editEnabled = YES;
    self.placeholderColor = [[self class] defaultPlaceholderColor];
    [self placeholderLabel];
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self.textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"]) {
        [self checkPlaceholder];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)checkPlaceholder
{
    if (!self.editEnabled) {
        [self showPlaceholderLabel:NO];
        return ;
    }
    if(self.text.length == 0 && ![self.textView isFirstResponder]) {
        [self showPlaceholderLabel:YES];
    } else {
        [self showPlaceholderLabel:NO];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self checkPlaceholder];
    [self layoutIfNeeded];
}

- (void)showPlaceholderLabel:(BOOL)show
{
    self.placeholderLabel.hidden = !show;
    self.placeholderLabel.textColor = self.placeholderColor;
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.font = self.font;
    if (!show) {
        self.textView.hidden = YES;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
{
    if (self.isEditable) {
        [self setEditEnabled:editing];
    }
}

- (void)setEditEnabled:(BOOL)editEnabled
{
    _editEnabled = editEnabled;
    [self applyEditing];
}

- (void)setIsEditable:(BOOL)isEditable
{
    _isEditable = isEditable;
    if (!isEditable) {
        [self setEditEnabled:isEditable];
    }
}


- (void)applyEditing
{
    if (_editEnabled)
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
    
    if (!_editEnabled) {
        self.textView.hidden = YES;
    }
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

- (void)setPlaceholderColor:(UIColor *)color
{
    _placeholderColor = color;
    if (_textView) {
        _textView.placeholderColor = color;
    }
}
- (ILPlaceholderTextView *)textView
{
    if (!_textView) {
        _textView = [[ILPlaceholderTextView alloc] initWithFrame:self.bounds];
        _textView.layoutManager.allowsNonContiguousLayout = NO;
        _textView.hidden = YES;
        _textView.editable = YES;
        _textView.placeholderColor = self.placeholderColor;
        //_textView.contentInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.textView.textContainer.lineFragmentPadding = 0;
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
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self endEdit];
    if (self.editDelegate && [self.editDelegate respondsToSelector:@selector(editLabelDidEndEditing:)]) {
        [self.editDelegate editLabelDidEndEditing:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length > 0 && [text isEqualToString:@"\n"]) {
        if (self.editDelegate && [self.editDelegate respondsToSelector:@selector(editLabelDidPressReturn:)]) {
            return [self.editDelegate editLabelDidPressReturn:self];
        }
    }
    return YES;
}
@end
