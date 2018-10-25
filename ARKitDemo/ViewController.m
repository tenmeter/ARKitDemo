//
//  ViewController.m
//  ARKitDemo
//
//  Created by panz on 2018/9/25.
//  Copyright © 2018年 panzhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ARSCNViewDelegate,ARSessionDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@end

    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sceneView.delegate = self;
    self.sceneView.session.delegate = self;
    [self setupCamera];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.planeDetection = ARPlaneDetectionHorizontal | ARPlaneDetectionVertical;
    // Run the view's session
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewDidAppear:(BOOL)animated{
    if (!ARWorldTrackingConfiguration.isSupported) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"ARKit" message:@" ARKit is not available on this device. For apps that require ARKit for core functionality, use the `arkit` key in the key in the `UIRequiredDeviceCapabilities` section of the Info.plist to prevent the app from installing. (If the app can't be installed, this error can't be triggered in a production scenario.) In apps where AR is an additive feature, use `isSupported` to determine whether to show UI for launching AR experiences." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confrimAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [controller dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [controller addAction:confrimAction];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

- (void)setupCamera{
    if (!self.sceneView.pointOfView.camera) {
        return;
    }
    
    SCNCamera *camera = self.sceneView.pointOfView.camera;
    camera.wantsHDR = YES;
    camera.exposureOffset = -1;   //曝光偏移
    camera.minimumExposure = -1;   //最小的曝光偏移
    camera.maximumExposure = 3;    //最大的曝光偏移
}

#pragma mark - ARSCNViewDelegate

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor{
    if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
        return;
    }
    
    ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
    
    
    
}

/*
// Override to create and configure nodes for anchors added to the view's session.
- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    SCNNode *node = [SCNNode new];
 
    // Add geometry to the node...
 
    return node;
}
*/

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
