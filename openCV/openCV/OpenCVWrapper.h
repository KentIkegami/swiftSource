//
//  OpenCVWrapper.h
//  openCV
//
//  Created by inf on 2018/06/01.
//  Copyright © 2018年 kent. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject
//(返り値の型 *)関数名:(引数の型 *)引数名;
//ToGray
- (UIImage *)toGray:(UIImage *)input_img;
//Camera
- (void)createCameraWithParentView:(UIImageView*)parentView;
- (void)start;

@end
