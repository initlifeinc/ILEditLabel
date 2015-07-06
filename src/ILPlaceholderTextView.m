//
//  ILPlaceholderTextView.m
//  Pods
//
//  Created by guodi.ggd on 7/6/15.
//
//

#import "ILPlaceholderTextView.h"
@interface ILPlaceholderTextView()
@property (nonatomic, strong) UILabel *placeholderLabel;
@end

@implementation ILPlaceholderTextView

- (id)init
{
    self = [super init];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.frame = self.bounds;
}

- (void)dealloc
{
    [self removeTextChangeObserver];
}

- (void)addTextChangeObserver
{
    self.placeholderColor = [UIColor grayColor];
    self.placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.placeholderLabel.hidden = YES;
    [self addSubview:self.placeholderLabel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)removeTextChangeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Set Method

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textChanged:nil];
}

- (void)textChanged:(NSNotification *)notification
{
    if (self.text.length != 0)
    {
        [self showPlaceholder:NO];
    } else {
        [self showPlaceholder:YES];
    }
}

- (void)showPlaceholder:(BOOL)show
{
    self.placeholderLabel.hidden = !show;
    if (show) {
        self.placeholderLabel.frame = self.bounds;
        self.placeholderLabel.font = self.placeholderFont?:self.font;
        self.placeholderLabel.textColor = self.placeholderColor?:self.textColor;

    }
    self.placeholderLabel.text = self.placeholder;
}
@end
