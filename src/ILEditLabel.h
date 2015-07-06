//
//  ILEditLabel.h
//  InitLife
//
//  Created by guodi.ggd on 6/29/15.
//  Copyright (c) 2015 guodi.ggd. All rights reserved.
//

#import "ILLabel.h"

@class ILEditLabel;
@protocol ILEditLabelDelegate <NSObject>
- (void)didFinishEdit:(ILEditLabel *)label;

- (BOOL)editLabelShouldBeginEditing:(ILEditLabel *)editLabel;

- (void)editLabelDidEndEditing:(ILEditLabel *)editLabel;
@end

@interface ILEditLabel : ILLabel
@property (nonatomic, strong, readonly) UITapGestureRecognizer *tapGesture;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) BOOL editEnabled;
@property (nonatomic, weak) id<ILEditLabelDelegate> editDelegate;
@property (nonatomic, strong) UIColor *placeholderColor;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
@end
