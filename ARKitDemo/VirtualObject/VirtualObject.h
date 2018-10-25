//
//  VirtualObject.h
//  ARKitDemo
//
//  Created by panz on 2018/9/25.
//  Copyright © 2018年 panzhou. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>

@interface VirtualObject : SCNReferenceNode

@property (nonatomic ,strong) NSString *modelName;

- ( NSArray *) allowedAlignments;

- (BOOL ) isPlacementValid:(ARPlaneAnchor * ) planeAnchor;

- (void) setTransformWithNewTransform:(simd_float4x4) transform
            relativeToCameraTransform:(simd_float4x4) cameratransform
                     isSmoothMovement:(BOOL) smoothMovement
                             aligment:(ARPlaneAnchorAlignment) aligment
                       allowAnimation:(BOOL) allowAnimation;

- (void) reset;

@end
