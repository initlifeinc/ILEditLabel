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

- (BOOL)editLabelDidPressReturn:(ILEditLabel *)editLabel;

@end

@interface ILEditLabel : ILLabel
@property (nonatomic, strong, readonly) UITapGestureRecognizer *tapGesture;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) BOOL editEnabled;//开启或者关闭编辑状态
@property (nonatomic, assign) BOOL isEditable;//是否可以编辑状态,当且仅当isEditable为YES情况，editEnabled才有效，否则，不可编辑
@property (nonatomic, weak) id<ILEditLabelDelegate> editDelegate;
@property (nonatomic, strong) UIColor *placeholderColor;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
@end
