//
//  Segment.m
//  ARKitDemo
//
//  Created by panz on 2018/10/9.
//  Copyright © 2018 panzhou. All rights reserved.
//

#import "Segment.h"
#import "FocusSquare.h"

@interface Segment()

@property (nonatomic, assign) Corner corner;
@property (nonatomic, assign) Aligment alignment;
@property (nonatomic, strong) SCNPlane *plane;
@property (nonatomic, assign) Direction openDirection;

@end

static CGFloat thickness = 0.018;
static CGFloat length = 0.5;
static CGFloat openLength = 0.2;

@implementation Segment

- (instancetype) initWithName:(NSString *)name corner:(Corner)corner alignment:(Aligment)aligment{
    if (self = [super init]) {
        self.corner = corner;
        self.alignment = aligment;
        self.name = name;
        
        [self initShowPlane];
    }
    return self;
}

- (void)initShowPlane{
    switch (self.alignment) {
        case AligmentVertical:
            self.plane = [SCNPlane planeWithWidth:thickness height:length];
            break;
        case AligmentHorizontal:
            self.plane = [SCNPlane planeWithWidth:length height:thickness];
            break;
        default:
            break;
    }
    
    SCNMaterial *material = self.plane.firstMaterial;
//    material.diffuse.contents = focus
    material.doubleSided = YES;
    material.ambient.contents = [UIColor blackColor];
    material.lightingModelName = SCNLightingModelConstant;  //物体光源类型
//    material.emission.contents =
    self.geometry = self.plane;
}

#pragma mark Getter and Setter

//- (void)setOpenDirection:(Direction)openDirection{
//    switch (_corner,_alignment) {
//        case AligmentVertical:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
//}

- (void)setReversed:(Direction)reversed{
    switch (reversed) {
        case Direction_Up:
            _reversed = Direction_Down;
            break;
        case Direction_Down:
            _reversed = Direction_Up;
            break;
        case Direction_Left:
            _reversed = Direction_Right;
            break;
        case Direction_Right:
            _reversed = Direction_Left;
            break;
            
        default:
            break;
    }
}

@end
