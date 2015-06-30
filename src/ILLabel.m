//
//  ILLabel
//  initlife
//
//  Created by __ on 14-8-1.
//  Copyright (c) 2014年 __ Co.,Ltd. All rights reserved.
//

#import "ILLabel.h"

@interface ILLabel ()

@property (nonatomic, strong) UILongPressGestureRecognizer *longTapGestureRecognizer;
@property (nonatomic, strong) UIMenuController *labelCopyMenu;
@property (nonatomic, copy) UIColor *oriColor;

@end

@implementation ILLabel

@synthesize labelName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)setCopyingEnabled:(BOOL)copyingEnabled
{
    _copyingEnabled = copyingEnabled;
    if (!_longTapGestureRecognizer && copyingEnabled)
    {
        _longTapGestureRecognizer =
            [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handleLongTap:)];
        self.userInteractionEnabled = YES;
        _longTapGestureRecognizer.minimumPressDuration = 0.2;

        [self addGestureRecognizer:_longTapGestureRecognizer];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(hideMenu:)
                                                     name:UIMenuControllerDidHideMenuNotification
                                                   object:nil];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)hideMenu:(id)sender
{
    if (self.oriColor) {
        self.backgroundColor = self.oriColor;
        self.oriColor = nil;
    }
}

- (void)handleLongTap:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        [self showCopyMenu];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return self.copyingEnabled;
}

- (void)showCopyMenu
{
    if (!_labelCopyMenu)
    {
        _labelCopyMenu = [UIMenuController sharedMenuController];
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:2];

        UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"copy", nil) action:@selector(copyText:)];

        [items addObject:item];
        _labelCopyMenu.menuItems = items;
    }

    [self becomeFirstResponder];
    if (self.copyingBackgroundColor) {
        self.oriColor = self.backgroundColor;
        self.backgroundColor = self.copyingBackgroundColor;
    }
    
    [_labelCopyMenu setTargetRect:self.bounds inView:self];
    [_labelCopyMenu setMenuVisible:YES animated:YES];

}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return _copyingEnabled && action == @selector(copyText:);
}

- (void)copyText:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.text) {
        [pasteboard setString:self.text];
    }
    [self hideMenu:nil];
}

@end
