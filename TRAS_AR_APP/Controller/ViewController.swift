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
    
    var graphNodes = [SCNNode]()

    
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
    
    
    func makeBoard2(at position: SCNVector3, title text: String, ylabel label: [String], dataLabel dataLabel: [String], yDatas datas: [Int]) {
        
        
        // 보드 부분
        
        let skScene = SKScene(size: CGSize(width: 200, height: 200))
        skScene.backgroundColor = UIColor.clear
        
        let rectangle = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 200, height: 200), cornerRadius: 10)
        rectangle.fillColor = #colorLiteral(red: 0.807843148708344, green: 0.0274509806185961, blue: 0.333333343267441, alpha: 1.0)
        rectangle.strokeColor = #colorLiteral(red: 0.439215689897537, green: 0.0117647061124444, blue: 0.192156866192818, alpha: 1.0)
        rectangle.lineWidth = 5
        rectangle.alpha = 0.7
        let labelNode = SKLabelNode(text: text)
        labelNode.fontSize = 20
        labelNode.fontName = "San Fransisco"
        labelNode.position = CGPoint(x:100,y:170)
        skScene.addChild(rectangle)
        skScene.addChild(labelNode)
        
        
        // 그래프 레이블 부분
        
        let labelNode1 = SKLabelNode(text: label[0])
        labelNode1.fontSize = 15
        labelNode1.fontName = "San Fransisco"
        labelNode1.position = CGPoint(x:47,y:30)
        skScene.addChild(labelNode1)
        
        let labelNode2 = SKLabelNode(text: label[1])
        labelNode2.fontSize = 15
        labelNode2.fontName = "San Fransisco"
        labelNode2.position = CGPoint(x:140,y:30)
        skScene.addChild(labelNode2)
    
        
        
        // 그래프 y축 부분
        
        let labelNode11 = SKLabelNode(text: dataLabel[0])
        labelNode11.fontSize = 11
        labelNode11.fontName = "San Fransisco"
        labelNode11.position = CGPoint(x:50,y:55)
        skScene.addChild(labelNode11)
        
        let labelNode12 = SKLabelNode(text: dataLabel[1])
        labelNode12.fontSize = 11
        labelNode12.fontName = "San Fransisco"
        labelNode12.position = CGPoint(x:140,y:55)
        skScene.addChild(labelNode12)
        
        
        // 실제 보여지는 파트
        let plane = SCNPlane(width: 0.07, height: 0.05)
        let material = SCNMaterial()
        material.isDoubleSided = true
        material.diffuse.contents = skScene
        plane.materials = [material]
        let node = SCNNode(geometry: plane)
        node.position = position
        node.eulerAngles.x = .pi/2
        
        // 그래프 부분
        let box = SCNBox(width: 0.01, height: 0.01, length: 0.0003 * Double(datas[0]), chamferRadius: 0)
        let RGBValue = getRandomRGBValue()
        box.firstMaterial?.diffuse.contents = UIColor(red: RGBValue.0, green: RGBValue.1, blue: RGBValue.2, alpha: 1)
        let boxNode = SCNNode(geometry: box)
        node.addChildNode(boxNode)
        boxNode.position = SCNVector3(-0.018, 0, 0)
        
        
        let box2 = SCNBox(width: 0.01, height: 0.01, length: 0.0003 * Double(datas[1]), chamferRadius: 0)
        let RGBValue2 = getRandomRGBValue()
        box2.firstMaterial?.diffuse.contents = UIColor(red: RGBValue2.0, green: RGBValue2.1, blue: RGBValue2.2, alpha: 1)
        let boxNode2 = SCNNode(geometry: box2)
        node.addChildNode(boxNode2)
        boxNode2.position = SCNVector3(0.015, 0, 0)
        
        
        // 부모에 등록
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    func makeBoard(at position: SCNVector3, title text: String, ylabel label: [String], dataLabel dataLabel: [String], yDatas datas: [Int]) {
        
        
        // 보드 부분
        
        let skScene = SKScene(size: CGSize(width: 200, height: 200))
        skScene.backgroundColor = UIColor.clear
        
        let rectangle = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 200, height: 200), cornerRadius: 10)
        rectangle.fillColor = #colorLiteral(red: 0.807843148708344, green: 0.0274509806185961, blue: 0.333333343267441, alpha: 1.0)
        rectangle.strokeColor = #colorLiteral(red: 0.439215689897537, green: 0.0117647061124444, blue: 0.192156866192818, alpha: 1.0)
        rectangle.lineWidth = 5
        rectangle.alpha = 0.7
        let labelNode = SKLabelNode(text: text)
        labelNode.fontSize = 20
        labelNode.fontName = "San Fransisco"
        labelNode.position = CGPoint(x:100,y:170)
        skScene.addChild(rectangle)
        skScene.addChild(labelNode)
        
        
        // 그래프 레이블 부분
        
        let labelNode1 = SKLabelNode(text: label[0])
        labelNode1.fontSize = 15
        labelNode1.fontName = "San Fransisco"
        labelNode1.position = CGPoint(x:40,y:20)
        skScene.addChild(labelNode1)
        
        
        let labelNode2 = SKLabelNode(text: label[1])
        labelNode2.fontSize = 15
        labelNode2.fontName = "San Fransisco"
        labelNode2.position = CGPoint(x:80,y:20)
        skScene.addChild(labelNode2)
        
        
        let labelNode3 = SKLabelNode(text: label[2])
        labelNode3.fontSize = 15
        labelNode3.fontName = "San Fransisco"
        labelNode3.position = CGPoint(x:120,y:20)
        skScene.addChild(labelNode3)
        
        
        let labelNode4 = SKLabelNode(text: label[3])
        labelNode4.fontSize = 15
        labelNode4.fontName = "San Fransisco"
        labelNode4.position = CGPoint(x:160,y:20)
        skScene.addChild(labelNode4)
        
        
        // 그래프 y축 부분
        
        let labelNode11 = SKLabelNode(text: dataLabel[0])
        labelNode11.fontSize = 11
        labelNode11.fontName = "San Fransisco"
        labelNode11.position = CGPoint(x:40,y:50)
        skScene.addChild(labelNode11)
        
        
        let labelNode12 = SKLabelNode(text: dataLabel[1])
        labelNode12.fontSize = 11
        labelNode12.fontName = "San Fransisco"
        labelNode12.position = CGPoint(x:80,y:50)
        skScene.addChild(labelNode12)
        
        
        let labelNode13 = SKLabelNode(text: dataLabel[2])
        labelNode13.fontSize = 11
        labelNode13.fontName = "San Fransisco"
        labelNode13.position = CGPoint(x:120,y:50)
        skScene.addChild(labelNode13)
        
        
        let labelNode14 = SKLabelNode(text: dataLabel[3])
        labelNode14.fontSize = 11
        labelNode14.fontName = "San Fransisco"
        labelNode14.position = CGPoint(x:160,y:50)
        skScene.addChild(labelNode14)
        
        // 실제 보여지는 파트
        let plane = SCNPlane(width: 0.1, height: 0.05)
        let material = SCNMaterial()
        material.isDoubleSided = true
        material.diffuse.contents = skScene
        plane.materials = [material]
        let node = SCNNode(geometry: plane)
        node.position = position
        node.eulerAngles.x = .pi/2
        
        // 그래프 부분
        let box = SCNBox(width: 0.01, height: 0.01, length: 0.0003 * Double(datas[0]), chamferRadius: 0)
        let RGBValue = getRandomRGBValue()
        box.firstMaterial?.diffuse.contents = UIColor(red: RGBValue.0, green: RGBValue.1, blue: RGBValue.2, alpha: 1)
        let boxNode = SCNNode(geometry: box)
        node.addChildNode(boxNode)
        boxNode.position = SCNVector3(-0.03, 0, 0)
        
        
        let box2 = SCNBox(width: 0.01, height: 0.01, length: 0.0003 * Double(datas[1]), chamferRadius: 0)
        let RGBValue2 = getRandomRGBValue()
        box2.firstMaterial?.diffuse.contents = UIColor(red: RGBValue2.0, green: RGBValue2.1, blue: RGBValue2.2, alpha: 1)
        let boxNode2 = SCNNode(geometry: box2)
        node.addChildNode(boxNode2)
        boxNode2.position = SCNVector3(-0.01, 0, 0)
        
        let box3 = SCNBox(width: 0.01, height: 0.01, length: 0.0003 * Double(datas[2]), chamferRadius: 0)
        let RGBValue3 = getRandomRGBValue()
        box3.firstMaterial?.diffuse.contents = UIColor(red: RGBValue3.0, green: RGBValue3.1, blue: RGBValue3.2, alpha: 1)
        let boxNode3 = SCNNode(geometry: box3)
        node.addChildNode(boxNode3)
        boxNode3.position = SCNVector3(0.01, 0, 0)
        
        let box4 = SCNBox(width: 0.01, height: 0.01, length: 0.0003 * Double(datas[3]), chamferRadius: 0)
        let RGBValue4 = getRandomRGBValue()
        box4.firstMaterial?.diffuse.contents = UIColor(red: RGBValue4.0, green: RGBValue4.1, blue: RGBValue4.2, alpha: 1)
        let boxNode4 = SCNNode(geometry: box4)
        node.addChildNode(boxNode4)
        boxNode4.position = SCNVector3(0.03, 0, 0)
        
        
        // 부모에 등록
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    func makeBoard3(at position: SCNVector3, title text: String, ylabel label: [String], dataLabel dataLabel: [String], yDatas datas: [Int]) {

        // 보드 부분
        
        let skScene = SKScene(size: CGSize(width: 200, height: 200))
        skScene.backgroundColor = UIColor.clear
        
        let rectangle = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 200, height: 200), cornerRadius: 10)
        rectangle.fillColor = #colorLiteral(red: 0.807843148708344, green: 0.0274509806185961, blue: 0.333333343267441, alpha: 1.0)
        rectangle.strokeColor = #colorLiteral(red: 0.439215689897537, green: 0.0117647061124444, blue: 0.192156866192818, alpha: 1.0)
        rectangle.lineWidth = 5
        rectangle.alpha = 0.7
        let labelNode = SKLabelNode(text: text)
        labelNode.fontSize = 20
        labelNode.fontName = "San Fransisco"
        labelNode.position = CGPoint(x:100,y:170)
        skScene.addChild(rectangle)
        skScene.addChild(labelNode)
        
        
        // 그래프 레이블 부분
        
        let labelNode1 = SKLabelNode(text: label[0])
        labelNode1.fontSize = 15
        labelNode1.fontName = "San Fransisco"
        labelNode1.position = CGPoint(x:40,y:20)
        skScene.addChild(labelNode1)
        
        
        let labelNode2 = SKLabelNode(text: label[1])
        labelNode2.fontSize = 15
        labelNode2.fontName = "San Fransisco"
        labelNode2.position = CGPoint(x:80,y:20)
        skScene.addChild(labelNode2)
        
        
        let labelNode3 = SKLabelNode(text: label[2])
        labelNode3.fontSize = 15
        labelNode3.fontName = "San Fransisco"
        labelNode3.position = CGPoint(x:120,y:20)
        skScene.addChild(labelNode3)
        
        
        let labelNode4 = SKLabelNode(text: label[3])
        labelNode4.fontSize = 15
        labelNode4.fontName = "San Fransisco"
        labelNode4.position = CGPoint(x:160,y:20)
        skScene.addChild(labelNode4)
        
        
        // 그래프 y축 부분
        
        let labelNode11 = SKLabelNode(text: dataLabel[0])
        labelNode11.fontSize = 11
        labelNode11.fontName = "San Fransisco"
        labelNode11.position = CGPoint(x:40,y:50)
        skScene.addChild(labelNode11)
        
        
        let labelNode12 = SKLabelNode(text: dataLabel[1])
        labelNode12.fontSize = 11
        labelNode12.fontName = "San Fransisco"
        labelNode12.position = CGPoint(x:80,y:50)
        skScene.addChild(labelNode12)
        
        
        let labelNode13 = SKLabelNode(text: dataLabel[2])
        labelNode13.fontSize = 11
        labelNode13.fontName = "San Fransisco"
        labelNode13.position = CGPoint(x:120,y:50)
        skScene.addChild(labelNode13)
        
        
        let labelNode14 = SKLabelNode(text: dataLabel[3])
        labelNode14.fontSize = 11
        labelNode14.fontName = "San Fransisco"
        labelNode14.position = CGPoint(x:160,y:50)
        skScene.addChild(labelNode14)
        
        // 실제 보여지는 파트
        let plane = SCNPlane(width: 0.1, height: 0.05)
        let material = SCNMaterial()
        material.isDoubleSided = true
        material.diffuse.contents = skScene
        plane.materials = [material]
        let node = SCNNode(geometry: plane)
        node.position = position
        node.eulerAngles.x = .pi/2
        
        // 그래프 부분
        let box = SCNBox(width: 0.01, height: 0.01, length: 0.0000005 * Double(datas[0]), chamferRadius: 0)
        let RGBValue = getRandomRGBValue()
        box.firstMaterial?.diffuse.contents = UIColor(red: RGBValue.0, green: RGBValue.1, blue: RGBValue.2, alpha: 1)
        let boxNode = SCNNode(geometry: box)
        node.addChildNode(boxNode)
        boxNode.position = SCNVector3(-0.03, 0, 0)
        
        //
        let box2 = SCNBox(width: 0.01, height: 0.01, length: 0.0000005 * Double(datas[1]), chamferRadius: 0)
        let RGBValue2 = getRandomRGBValue()
        box2.firstMaterial?.diffuse.contents = UIColor(red: RGBValue2.0, green: RGBValue2.1, blue: RGBValue2.2, alpha: 1)
        let boxNode2 = SCNNode(geometry: box2)
        node.addChildNode(boxNode2)
        boxNode2.position = SCNVector3(-0.01, 0, 0)
        
        let box3 = SCNBox(width: 0.01, height: 0.01, length: 0.0000005 * Double(datas[2]), chamferRadius: 0)
        let RGBValue3 = getRandomRGBValue()
        box3.firstMaterial?.diffuse.contents = UIColor(red: RGBValue3.0, green: RGBValue3.1, blue: RGBValue3.2, alpha: 1)
        let boxNode3 = SCNNode(geometry: box3)
        node.addChildNode(boxNode3)
        boxNode3.position = SCNVector3(0.01, 0, 0)
        
        let box4 = SCNBox(width: 0.01, height: 0.01, length: 0.0000005 * Double(datas[3]), chamferRadius: 0)
        let RGBValue4 = getRandomRGBValue()
        box4.firstMaterial?.diffuse.contents = UIColor(red: RGBValue4.0, green: RGBValue4.1, blue: RGBValue4.2, alpha: 1)
        let boxNode4 = SCNNode(geometry: box4)
        node.addChildNode(boxNode4)
        boxNode4.position = SCNVector3(0.03, 0, 0)
        
        
        // 부모에 등록
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    func makeBoard4(position: SCNVector3, text: String) {
        
        let skScene = SKScene(size: CGSize(width: 200, height: 200))
        skScene.backgroundColor = UIColor.clear
        
        let rectangle = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 200, height: 200), cornerRadius: 10)
        rectangle.fillColor = #colorLiteral(red: 0.807843148708344, green: 0.0274509806185961, blue: 0.333333343267441, alpha: 1.0)
        rectangle.strokeColor = #colorLiteral(red: 0.439215689897537, green: 0.0117647061124444, blue: 0.192156866192818, alpha: 1.0)
        rectangle.lineWidth = 5
        rectangle.alpha = 0.7
        let labelNode = SKLabelNode(text: text)
        labelNode.fontSize = 25
        labelNode.fontName = "San Fransisco"
        labelNode.position = CGPoint(x:100,y:100)
        skScene.addChild(rectangle)
        skScene.addChild(labelNode)
        
        
        // 실제 보여지는 파트
        let plane = SCNPlane(width: 0.1, height: 0.05)
        let material = SCNMaterial()
        material.isDoubleSided = true
        material.diffuse.contents = skScene
        plane.materials = [material]
        let node = SCNNode(geometry: plane)
        node.position = position
        node.eulerAngles.x = .pi/2
        
        
        // 부모에 등록
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
   
    
    func addBox(at position: SCNVector3) {
        let box = SCNBox(width: 0.01, height: 0.01, length: 0.01, chamferRadius: 0)
        let RGBValue = getRandomRGBValue()
        box.firstMaterial?.diffuse.contents = UIColor(red: RGBValue.0, green: RGBValue.1, blue: RGBValue.2, alpha: 1)
        let boxNode = SCNNode(geometry: box)
        boxNode.position = position
        self.sceneView.scene.rootNode.addChildNode(boxNode)

    }
    
    private func getRandomRGBValue() -> (CGFloat,CGFloat,CGFloat) {
        
        let R = CGFloat(Double.random(in: 0..<1))
        let G = CGFloat(Double.random(in: 0..<1))
        let B = CGFloat(Double.random(in: 0..<1))
        
        return (R,G,B)
        
    }
    
//
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
            
//            let cor = [37.49510129007885, 127.11826137870351]
            let cor = coor
            let cor1 = [cor[0]-0.005,cor[1]-0.005]
            let cor2 = [cor[0]+0.005,cor[1]+0.005]
            
//            let cor1 = [37.520542,126.953076]
//            let cor2 = [37.513769,126.963719]
            
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
        let scale = Float(0.5 * hitResult.distance) / terrainNode.boundingSphere.radius
        terrainNode.transform = SCNMatrix4MakeScale(scale, scale, scale)
        terrainNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        // set the material
        
        terrainNode.geometry?.materials = defaultMaterials()
        
//        addBox(at: SCNVector3(terrainNode.position.x, terrainNode.position.y, terrainNode.position.z-0.1))
        makeBoard(at: SCNVector3(terrainNode.position.x, terrainNode.position.y, terrainNode.position.z-0.15), title: "점포수 변화", ylabel: ["21-1","21-2","21-3","21-4"], dataLabel: ["\(firstQuarter.점포수) 개","\(secondQuearter.점포수) 개","\(thirdQuarter.점포수) 개","\(fourthQuarter.점포수) 개"], yDatas: [firstQuarter.점포수,secondQuearter.점포수,thirdQuarter.점포수,fourthQuarter.점포수])
        makeBoard3(at: SCNVector3(terrainNode.position.x-0.15, terrainNode.position.y, terrainNode.position.z-0.15), title: "분기당 매출 건수", ylabel: ["21-1","21-2","21-3","21-4"], dataLabel: ["\(firstQuarter.분기당매출건수)","\(secondQuearter.분기당매출건수)","\(thirdQuarter.분기당매출건수)","\(fourthQuarter.분기당매출건수)"], yDatas: [firstQuarter.분기당매출건수,secondQuearter.분기당매출건수,thirdQuarter.분기당매출건수,fourthQuarter.분기당매출건수])
        
        makeBoard2(at: SCNVector3(terrainNode.position.x+0.15, terrainNode.position.y, terrainNode.position.z-0.15), title: "대분류 내 소분류 비중",ylabel: ["입시학원","교육 분야"], dataLabel: ["\(fourthQuarter.점포수) 개","\(fourthQuarter.점포수) 개"], yDatas: [fourthQuarter.점포수,fourthQuarter.점포수])
        
        makeBoard2(at: SCNVector3(terrainNode.position.x-0.15, terrainNode.position.y, terrainNode.position.z-0.25), title: "주중/주말 매출 비교", ylabel: ["주중","주말"], dataLabel: ["\(fourthQuarter.주중매출비율) %","\(fourthQuarter.주말매출비율) %"], yDatas: [fourthQuarter.주중매출비율,fourthQuarter.주말매출비율])
        
        makeBoard2(at: SCNVector3(terrainNode.position.x, terrainNode.position.y, terrainNode.position.z-0.25), title: "낮/밤 매출 비교", ylabel: ["낮","밤"], dataLabel: ["\(fourthQuarter.낮매출비율) %", "\(fourthQuarter.밤매출비율) %"], yDatas: [fourthQuarter.낮매출비율,fourthQuarter.밤매출비율])
        
        makeBoard2(at: SCNVector3(terrainNode.position.x+0.15, terrainNode.position.y, terrainNode.position.z-0.25), title: "성별 매출 비교", ylabel: ["남","녀"], dataLabel: ["\(fourthQuarter.남성매출비율) %","\(fourthQuarter.여성매출비율) %"], yDatas: [fourthQuarter.남성매출비율,fourthQuarter.여성매출비율])
        
        makeBoard(at: SCNVector3(terrainNode.position.x+0.17, terrainNode.position.y, terrainNode.position.z-0.06), title: "연령대별 매출 비교", ylabel: ["청소년","청년","장년","중노년"], dataLabel: ["\(fourthQuarter.청소년매출비율) %","\(fourthQuarter.청년매출비율) %","\(fourthQuarter.장년매출비율) %","\(fourthQuarter.중노년매출비율) %"], yDatas: [fourthQuarter.청소년매출비율,fourthQuarter.청년매출비율,fourthQuarter.장년매출비율,fourthQuarter.중노년매출비율])
        
        makeBoard4(position: SCNVector3(terrainNode.position.x-0.15, terrainNode.position.y, terrainNode.position.z-0.06), text: "\(fourthQuarter.구) \(fourthQuarter.법정동)")
        
        
        
        
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
        configuration.isLightEstimationEnabled = true
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
