//
//  NXSegmentItem.h
//  NXSegmentedControlDemo
//
//  Created by iNuoXia on 14-7-3.
//  Copyright (c) 2014年 NuoXia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXSegmentItem : UIView

// title or image, not both
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

-(instancetype)initWithTile: (NSString *)title;
-(instancetype)initWithImage:(UIImage *)image;

@end
