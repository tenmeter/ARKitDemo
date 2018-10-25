//
//  VirtualObject.m
//  ARKitDemo
//
//  Created by panz on 2018/9/25.
//  Copyright © 2018年 panzhou. All rights reserved.
//

#import "VirtualObject.h"
#import <math.h>

@interface VirtualObject()

@property (nonatomic ,assign) ARPlaneAnchorAlignment currentAligment;
@property (nonatomic ,assign) BOOL isChangingAlignment;
@property (nonatomic ,assign) CGFloat objectRotation;
@property (nonatomic ,assign) CGFloat rotationWhenAlignedHorizontally;
@property (nonatomic ,strong) ARAnchor *anchor;
@property (nonatomic ,strong) NSMutableArray *recentVirtualObjectDistances;

@end

@implementation VirtualObject

- (instancetype )init{
    if (self = [super init]) {
        self.currentAligment = ARPlaneAnchorAlignmentHorizontal;
        self.isChangingAlignment = NO;
        self.objectRotation = 0;
        
    }
    return self;
}

-(NSArray *)allowedAlignments{
    if ([self.modelName isEqualToString:@"sticky note"]) {
        return @[@(ARPlaneAnchorAlignmentHorizontal), @(ARPlaneAnchorAlignmentVertical)];
    }else if([self.modelName isEqualToString:@"painting"]){
        return @[@(ARPlaneAnchorAlignmentVertical)];
    }
    
    return @[@(ARPlaneAnchorAlignmentHorizontal)];
}

- (void)reset{
    [self.recentVirtualObjectDistances removeAllObjects];
}

- (BOOL) isPlacementValid:(ARPlaneAnchor *)planeAnchor{
    if (planeAnchor) {
        return [self.allowedAlignments containsObject:@(planeAnchor.alignment)];
    }
    return true;
}

//inline simd_float4x4 translation(firstObject:sim_float3){
//    
//}

//- (void)setTransformWithNewTransform:(simd_float4x4)transform relativeToCameraTransform:(simd_float4x4)cameratransform isSmoothMovement:(BOOL)smoothMovement aligment:(ARPlaneAnchorAlignment)aligment allowAnimation:(BOOL)allowAnimation{
//    float3 = cameratransform.trans
//}

//inline sim_floe

#pragma  mark lazy load

- (CGFloat)objectRotation{
    return self.childNodes.firstObject.eulerAngles.y;
}

- (NSString *)modelName{
    NSString *modelNameString = self.referenceURL.lastPathComponent;
    return [modelNameString stringByReplacingOccurrencesOfString:@".scn" withString:@""];
}


- (void)setObjectRotation:(CGFloat)objectRotation{
    CGFloat normalized = objectRotation / (2 *M_PI);
    normalized = (normalized + 2 *M_PI) / (2 * M_PI);
    
    if (normalized > M_PI) {
        normalized -= 2 * M_PI;
    }
    
    SCNVector3 vector3 = SCNVector3Make(self.childNodes.firstObject.eulerAngles.x, normalized, self.childNodes.firstObject.eulerAngles.z);
    
    [self.childNodes.firstObject setEulerAngles:vector3];
    
    if (self.currentAligment == ARPlaneAnchorAlignmentHorizontal) {
        self.rotationWhenAlignedHorizontally = normalized;
    }
    
}

@end
