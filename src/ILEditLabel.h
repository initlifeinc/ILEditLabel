//
//  ILEditLabel.h
//  InitLife
//
//  Created by guodi.ggd on 6/29/15.
//  Copyright (c) 2015 guodi.ggd. All rights reserved.
//

#import "ILLabel.h"

@interface ILEditLabel : ILLabel
@property (nonatomic, strong, readonly) UITapGestureRecognizer *tapGesture;
@property (nonatomic, assign) BOOL editEnabled;
@end
