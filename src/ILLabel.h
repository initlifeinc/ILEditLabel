//
//  ILLabel
//  initlife
//
//  Created by __ on 14-8-1.
//  Copyright (c) 2014年 __ Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ILLabel;

@interface ILLabel : UILabel
@property (nonatomic, copy) UIColor *copyingBackgroundColor;
@property (nonatomic, copy) NSString *labelName;

@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *longPressGesture;

@property (nonatomic) BOOL copyingEnabled;

@end
