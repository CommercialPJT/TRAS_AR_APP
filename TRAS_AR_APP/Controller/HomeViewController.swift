//
//  HomeViewController.swift
//  TRAS_AR_APP
//
//  Created by hong on 2022/05/14.
//

import UIKit
import SnapKit
import Lottie

class HomeViewController: UIViewController {
    
    let animationView = AnimationView(name: "78003-town")
    let animationView2 = AnimationView(name: "82561-building")
    
    let banner: UIImageView = {
        let bannerImage = UIImage(named: "banner_image")!
        let banner = UIImageView(image: bannerImage)
        return banner
    }()
    
    let putIntInfoButton: UIButton = {
        let putInInfoButton = UIButton()
        putInInfoButton.backgroundColor = .purple
        putInInfoButton.setTitle("상권 예측하러 가기", for: .normal)
        putInInfoButton.setTitleColor(UIColor.black, for: .normal)
        putInInfoButton.layer.cornerRadius = 40
        putInInfoButton.clipsToBounds = true
        putInInfoButton.layer.borderWidth = 3
        putInInfoButton.layer.borderColor = UIColor.lightGray.cgColor
        putInInfoButton.backgroundColor = .clear
        return putInInfoButton
    }()
    
    let historyButton: UIButton = {
        let historyButton = UIButton()
        historyButton.backgroundColor = .red
        historyButton.layer.cornerRadius = 40
        historyButton.setTitle("과거 예측 이력 보기", for: .normal)
        historyButton.clipsToBounds = true
        return historyButton
    }()
    
    var FullLocManger = fullLocManager()
    var locData: locList!
    
    var LocalInfoManager = LocInfoManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.contentMode = .scaleAspectFit
        self.view.addSubview(animationView)
        animationView.play()
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        
//        animationView2.ContentMode = .scaleAspectFit
        self.view.addSubview(animationView2)
        animationView2.play()
        animationView2.loopMode = .loop
        animationView2.backgroundBehavior = .pauseAndRestore
        
        self.view.addSubview(banner)
        self.view.addSubview(putIntInfoButton)
//        self.view.addSubview(historyButton)
        
        putIntInfoButton.addTarget(self, action: #selector(putIntInfoButtonTapped), for: .touchUpInside)
//        toARView.addTarget(self, action: #selector(toARViewTapped), for: .touchUpInside)
        
//        guard
//            let jsonData = load(),
//            let dictData = String(data: jsonData, encoding: .utf8)
//        else { return }

//        guard
//            let jsonData = load(),
//            let areaList = try? JSONDecoder().decode(areaInfo.self, from: jsonData)
//        else { return  }
//
        FullLocManger.delegate = self
        FullLocManger.getLocData(key: "loc_datas")
        
        LocalInfoManager.delegate = self
//        2021-4
        LocalInfoManager.getLocInfoData(url: "https://grj49a.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://hxzdim.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://heo4yv.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://w2igge.deta.dev/")
        //2021-3
        LocalInfoManager.getLocInfoData(url: "https://kgk33m.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://5lcpnx.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://qqwrwd.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://4het5f.deta.dev/")
////
////
//        //2021-2
        LocalInfoManager.getLocInfoData(url: "https://yesgja.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://npzs83.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://1nffyo.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://p80ddr.deta.dev/")
//
//
//        //2021-1
        LocalInfoManager.getLocInfoData(url: "https://muqqfm.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://kzycfx.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://48xzhg.deta.dev/")
        LocalInfoManager.getLocInfoData(url: "https://p2he7v.deta.dev/")

        
//        1분기-1 : https://muqqfm.deta.dev/
//        1분기-2 : https://kzycfx.deta.dev/
//        1분기-3 : https://48xzhg.deta.dev/
//        1분기-4 : https://p2he7v.deta.dev/
//
//
//        2분기-1 : https://yesgja.deta.dev/
//        2분기-2 : https://npzs83.deta.dev/
//        2분기-3  : https://1nffyo.deta.dev/
//        2분기-4 : https://p80ddr.deta.dev/
//
//
//        3분기-1 : https://kgk33m.deta.dev/
//        3분기-2 : https://5lcpnx.deta.dev/
//        3분기-3 : https://qqwrwd.deta.dev/
//        3분기-4 : https://4het5f.deta.dev/
//
//        4분기-1. : https://grj49a.deta.dev/
//        4분기-2 : https://hxzdim.deta.dev/
//        4분기-3 : https://heo4yv.deta.dev/
//        4분기-4 : https://w2igge.deta.dev/



    }
    
    
    @objc func putIntInfoButtonTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoFormView")
        vc?.modalTransitionStyle = .coverVertical
        present(vc!, animated: true, completion: nil)
    }
    
    @objc func historyButtonTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ARMapView")
        vc?.modalTransitionStyle = .coverVertical
        present(vc!, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
        banner.snp.makeConstraints { make in
            make.height.equalTo(self.view.frame.height/7)
            make.width.equalTo(self.view.frame.width+700)
        }
        
        putIntInfoButton.snp.makeConstraints { make in

            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
            make.width.equalTo(self.view.frame.width/2+30)
            make.height.equalTo(self.view.frame.height/5)
    
        }
        
        animationView.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.size.equalTo(150)
            make.top.equalTo(self.view.frame.height/5)
            make.left.equalTo(20)
        }
        
        animationView2.snp.makeConstraints { make in
            make.top.equalTo(putIntInfoButton).inset(100)
            make.centerX.equalTo(self.view)
            make.size.equalTo(290)
        }

        
    }
    
}

extension HomeViewController: fullLocManagerDelegate {
    
    func didUpdateLocData(_ locManger: fullLocManager, event: locList) {
        DispatchQueue.main.async {
            self.locData = event
//            print(event)
        }
    }
    
    func didFailUpdateLocData(error: Error) {
        print(error)
    }
}

extension HomeViewController: LocInfoManagerDelegate {
    
    func didupdateLocInfoData(_ locInfoManager: LocInfoManager, event: areaList) {
        DispatchQueue.main.async {
//            print(event)
        }
    }
    
    func didFailUpdateLocInfoData(error: Error) {
        print(error)
    }
}
