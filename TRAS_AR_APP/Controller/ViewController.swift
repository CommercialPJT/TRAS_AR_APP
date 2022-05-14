//
//  ViewController.swift
//  TRAS_AR_APP
//
//  Created by hong on 2022/05/14.
//

import UIKit
import SceneKit
import ARKit
import MapboxSceneKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        registerGestureRecognizers()
    }
    
    private func registerGestureRecognizers() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapped(recognizer: UITapGestureRecognizer) {
        
        let sceneView = recognizer.view as! ARSCNView
        let touch = recognizer.location(in: sceneView)
        
        let hitTestResults = sceneView.hitTest(touch, types: .existingPlane)
        
        if !hitTestResults.isEmpty {
            let hitTestResult = hitTestResults.first!
            
            for node in self.sceneView.scene.rootNode.childNodes {
                node.removeFromParentNode()
            }
            
            let cor1 = [37.520542,126.953076]
            let cor2 = [37.513769,126.963719]
            
            addTerrainNode(from: hitTestResult, cor1: cor1, cor2: cor2)
            
        }
        
    }
    
    private func addTerrainNode(from hitResult : ARHitTestResult, cor1: [Double], cor2: [Double]) {
    
        let minlat = min(cor1[0], cor2[0])
        let maxlat = max(cor1[0], cor2[0])
        let minlon = min(cor1[1], cor2[1])
        let maxlon = max(cor1[1], cor2[1])
        
        let terrainNode = TerrainNode(minLat: minlat, maxLat: maxlat,
                                      minLon: minlon, maxLon: maxlon)
        let scale = Float(0.333 * hitResult.distance) / terrainNode.boundingSphere.radius
        terrainNode.transform = SCNMatrix4MakeScale(scale, scale, scale)
        terrainNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        // set the material
        
        terrainNode.geometry?.materials = defaultMaterials()
        
        self.sceneView.scene.rootNode.addChildNode(terrainNode)
        
        terrainNode.fetchTerrainAndTexture(minWallHeight: 100, enableDynamicShadows: true, textureStyle: "mapbox/satellite-v9", heightProgress: nil, heightCompletion: { fetchError in
                    if let fetchError = fetchError {
                        NSLog("Terrain load failed: \(fetchError.localizedDescription)")
                    } else {
                        NSLog("Terrain load complete")
                    }
                }, textureProgress: nil) { image, fetchError in
                    if let fetchError = fetchError {
                        NSLog("Texture load failed: \(fetchError.localizedDescription)")
                    }
                    if image != nil {
                        NSLog("Texture load complete")
                        terrainNode.geometry?.materials[4].diffuse.contents = image
                    }
                }
    }
    
    
    private func defaultMaterials() -> [SCNMaterial] {
            let groundImage = SCNMaterial()
            groundImage.diffuse.contents = UIColor.darkGray
            groundImage.name = "Ground texture"

            let sideMaterial = SCNMaterial()
            sideMaterial.diffuse.contents = UIColor.darkGray
            //TODO: Some kind of bug with the normals for sides where not having them double-sided has them not show up
            sideMaterial.isDoubleSided = true
            sideMaterial.name = "Side"

            let bottomMaterial = SCNMaterial()
            bottomMaterial.diffuse.contents = UIColor.black
            bottomMaterial.name = "Bottom"

            return [sideMaterial, sideMaterial, sideMaterial, sideMaterial, groundImage, bottomMaterial]
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
