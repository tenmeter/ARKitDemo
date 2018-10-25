//
//  Segment.h
//  ARKitDemo
//
//  Created by panz on 2018/10/9.
//  Copyright © 2018 panzhou. All rights reserved.
//



#import <SceneKit/SceneKit.h>

/*
 The focus square consists of eight segments as follows, which can be individually animated.
 
     s1  s2
     _   _
 s3 |     | s4
 
 s5 |     | s6
     -   -
     s7  s8
 */
typedef NS_ENUM(NSInteger,Corner) {
    Corner_topLeft, // s1, s3
    Corner_topRight, //s2, s4
    Corner_bottomRight, //s6, s8
    Corner_bottomLeft //s5,s7
};

typedef NS_ENUM(NSInteger,Aligment) {
    AligmentHorizontal, //s1 s2 s7 s8
    AligmentVertical //s3 s4 s5 s6
};

typedef NS_ENUM(NSInteger,Direction) {
    Direction_Up,
    Direction_Down,
    Direction_Left,
    Direction_Right
};

NS_ASSUME_NONNULL_BEGIN

@interface Segment :SCNNode


/**
 初始化检测平面

 @param name 检测平面名称
 @param corner 检测平面展示的边角
 @param aligment 水平还是竖直展示
 @return 当前的平面
 */
- (instancetype)initWithName:(NSString *)name
                      corner:(Corner)corner
                   alignment:(Aligment)aligment;

@property (nonatomic ,assign) Direction reversed;

@end

NS_ASSUME_NONNULL_END
