//
//  LocalInfoManager.swift
//  TRAS_AR_APP
//
//  Created by hong on 2022/05/15.
//

import UIKit
import SwiftyJSON
import Alamofire
import Foundation

protocol EventManagerDelegate {
    func didUpdateEventData(_ eventManger: EventManger, event: locList)
    func didFailUpdateEventData(error: Error)
}

//protocol ShoppingMallDelegate {
//    func didUpdateShopData(_ eventManager: ShoppingMallManager, data: ShoppingModel)
//    func didFailUpdateShopData(error: Error)
//}
//

struct EventManger {
    
    var delegate: EventManagerDelegate?
    
    func getEventData(shoppingMall: String) {
        
        let url = "https://v0vdfm.deta.dev/"
        
        AF.request(url,method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let eventJSON: JSON = JSON(value)
                if let event = updateEventData(json: eventJSON, ShoppingMall: "loc_datas") {
                    self.delegate?.didUpdateEventData(self,event: event)
                 
                }
            case let .failure(error):
                
                self.delegate?.didFailUpdateEventData(error: error)

            }
        }
    }
    
    
    func updateEventData(json:JSON,ShoppingMall: String) -> locList? {
        
        guard let lists = json[ShoppingMall].array else {return nil}
        
        var datasList = [locInfo]()
        
        for list in lists {
            let 일자 = list["일자"].rawValue as! Int
            let 상권명 = list["상권명"].rawValue as! String
            let 상권구분 = list["상권구분"].rawValue as! String
            let 상권경도 = list["상권경도"].rawValue as! Double
            let 상권위도 = list["상권위도"].rawValue as! Double
            let 시 = list["시"].rawValue as!  String
            let 구 = list["구"].rawValue as! String
            let 법정동 = list["법정동"].rawValue as! String
            let item = locInfo(일자: 일자, 상권구분: 상권구분, 상권명: 상권명, 상권경도: 상권경도, 상권위도: 상권위도, 시: 시, 구: 구, 법정동: 법정동)
            datasList.append(item)
            locDatas.append(item)
        }
        
        return locList(locs: datasList)


    }
    
    
}



//
//struct ShoppingMallManager {
//
//    var delegate: ShoppingMallDelegate?
//
//    func getNameList() {
//
//        let url = "https://gg6hx0.deta.dev/"
//
//        AF.request(url,method: .get).validate().responseJSON { (response) in
//            switch response.result {
//            case .success(let value):
//                let eventJSON: JSON = JSON(value)
//                if let datas = getLogoData(json: eventJSON) {
//                    self.delegate?.didUpdateShopData(self,data: datas)
//
//                }
//            case let .failure(error):
//
//                self.delegate?.didFailUpdateShopData(error: error)
//
//            }
//        }
//
//    }
//
//    func getLogoData(json:JSON) -> ShoppingModel? {
//
//
//        guard let list = json["쇼핑몰 리스트"].array else {return nil}
//
//        let dataList = list.map{$0.stringValue}
//
//        guard let logoList = json["로고"].dictionary else {return nil}
//
//        var logoURLList: [String:String] = [:]
//
//        for item in dataList {
//
//            guard let logoURL = logoList[item] else {return nil}
//
//            logoURLList[item] = logoURL.stringValue
//        }
//
//        let logoDatas = logoData(logo: logoURLList)
//
//        let shoppingMallLogoData = ShoppingModel(ShopList: dataList, logo: logoDatas)
//
//        return shoppingMallLogoData
//
//
//    }
//
//
//}
