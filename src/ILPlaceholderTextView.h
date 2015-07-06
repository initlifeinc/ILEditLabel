//
//  ILPlaceholderTextView.h
//  Pods
//
//  Created by guodi.ggd on 7/6/15.
//
//

#import <UIKit/UIKit.h>

@interface ILPlaceholderTextView : UITextView
@property (nonatomic, copy  ) NSString  *placeholder;       // default is nil.
@property (nonatomic, strong) UIColor   *placeholderColor;  // default is [UIColor grayColor];
@property (nonatomic, strong) UIFont    *placeholderFont;   // default is TextView Font

@end
