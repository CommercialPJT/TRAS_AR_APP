//
//  HomeViewController.swift
//  TRAS_AR_APP
//
//  Created by hong on 2022/05/14.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let toARView: UIButton = {
        let toARView = UIButton()
        toARView.backgroundColor = .blue
        return toARView
    }()
    
    let banner: UIImageView = {
        let bannerImage = UIImage(named: "banner_image")!
        let banner = UIImageView(image: bannerImage)
        return banner
    }()
    
    let putIntInfoButton: UIButton = {
        let putInInfoButton = UIButton()
        putInInfoButton.backgroundColor = .purple
        return putInInfoButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(banner)
        self.view.addSubview(putIntInfoButton)
        self.view.addSubview(toARView)
        
        putIntInfoButton.addTarget(self, action: #selector(putIntInfoButtonTapped), for: .touchUpInside)
        toARView.addTarget(self, action: #selector(toARViewTapped), for: .touchUpInside)

    }
    
    @objc func putIntInfoButtonTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoFormView")
        vc?.modalTransitionStyle = .coverVertical
        present(vc!, animated: true, completion: nil)
    }
    
    @objc func toARViewTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ARMapView")
        vc?.modalTransitionStyle = .coverVertical
        present(vc!, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
        banner.snp.makeConstraints { make in
            make.height.equalTo(self.view.frame.height/8)
            make.width.equalTo(self.view.frame.width)
        }
        
        putIntInfoButton.snp.makeConstraints { make in
            make.leftMargin.rightMargin.equalTo(self.view.frame.width/4)
            make.topMargin.equalTo(self.view.frame.height/5)
            make.bottomMargin.equalTo(self.view.frame.height/2)
            
        }
        
        toARView.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
    
}
