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

protocol fullLocManagerDelegate {
    func didUpdateLocData(_ locManger: fullLocManager, event: locList)
    func didFailUpdateLocData(error: Error)
}


protocol LocInfoManagerDelegate {
    func didupdateLocInfoData(_ locInfoManager: LocInfoManager, event: areaList)
    func didFailUpdateLocInfoData(error: Error)
    
}

struct fullLocManager {
    
    var delegate: fullLocManagerDelegate?
    
    func getLocData(key: String) {
        
        let url = "https://20ckk8.deta.dev/"
        
        AF.request(url,method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let eventJSON: JSON = JSON(value)
                if let event = updateLocData(json: eventJSON, key: "loc_datas") {
                    self.delegate?.didUpdateLocData(self,event: event)
                 
                }
            case let .failure(error):
                
                self.delegate?.didFailUpdateLocData(error: error)

            }
        }
    }
    
    
    func updateLocData(json:JSON,key: String) -> locList? {
        
        guard let lists = json[key].array else {return nil}
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


struct LocInfoManager {
    
    var delegate: LocInfoManagerDelegate?
    
    func getLocInfoData(url: String) {
        
//        let url = "https://v0vdfm.deta.dev/"
        
        AF.request(url,method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let LocInfoJSON: JSON = JSON(value)
                if let event = updateEventData(json: LocInfoJSON, key: "datas") {
                    self.delegate?.didupdateLocInfoData(self,event: event)
                 
                }
            case let .failure(error):
                print(error)
                self.delegate?.didFailUpdateLocInfoData(error: error)

            }
        }
    }
    
    
    func updateEventData(json:JSON,key: String) -> areaList? {
        
        guard let lists = json[key].array else {return nil}
        
        var datasList = [areaInfo]()
        
        for list in lists {
            let 기준년코드 = list["기준년코드"].rawValue as! Int
            let 기준분기코드 = list["기준분기코드"].rawValue as! Int
            let 상권구분코드명 = list["상권구분코드명"].rawValue as! String
            let 상권코드명 = list["상권코드명"].rawValue as! String
            let 서비스업종코드명 = list["서비스업종코드명"].rawValue as! String
            let 분기당매출금액 = list["분기당매출금액"].rawValue as! Int
            let 분기당매출건수 = list["분기당매출건수"].rawValue as! Int
            let 점포수 = list["점포수"].rawValue as! Int
            let 시 = list["시"].rawValue as! String
            let 구 = list["구"].rawValue as! String
            let 법정동 = list["법정동"].rawValue as! String
            let 지역분류 = list["지역분류"].rawValue as! Int
            let 서비스분류 = list["서비스분류"].rawValue as! Int
            let 주중매출비율 = list["주중매출비율"].rawValue as! Int
            let 주말매출비율 = list["주말매출비율"].rawValue as! Int
            let 낮매출비율 = list["낮매출비율"].rawValue as! Int
            let 밤매출비율 = list["밤매출비율"].rawValue as! Int
            let 남성매출비율 = list["남성매출비율"].rawValue as! Int
            let 여성매출비율 = list["여성매출비율"].rawValue as! Int
            let 청소년매출비율 = list["청소년매출비율"].rawValue as! Int
            let 청년매출비율 = list["청년매출비율"].rawValue as! Int
            let 장년매출비율 = list["장년매출비율"].rawValue as! Int
            let 중노년매출비율 = list["중노년매출비율"].rawValue as! Int
            let top3요일 = list["top3요일"].rawValue as! Int
            let top3시간 = list["top3시간"].rawValue as! Int
            let top3연령 = list["top3연령"].rawValue as! Int
            let top성별 = list["top성별"].rawValue as! Int
            let item = areaInfo(기준년코드: 기준년코드, 기준분기코드: 기준분기코드, 상권구분코드명: 상권구분코드명, 상권코드명: 상권코드명, 서비스업종코드명: 서비스업종코드명, 분기당매출금액: 분기당매출금액, 분기당매출건수: 분기당매출건수, 점포수: 점포수, 시: 시, 구: 구, 법정동: 법정동, 지역분류: 지역분류, 서비스분류: 서비스분류, 주중매출비율: 주중매출비율, 주말매출비율: 주말매출비율, 낮매출비율: 낮매출비율, 밤매출비율: 밤매출비율, 남성매출비율: 남성매출비율, 여성매출비율: 여성매출비율, 청소년매출비율: 청소년매출비율, 청년매출비율: 청년매출비율, 장년매출비율: 장년매출비율, 중노년매출비율: 중노년매출비율, top3요일: top3요일, top3시간: top3시간, top3연령: top3연령, top성별: top성별)
            datasList.append(item)
            locFullDatas.append(item)
            locFullDic["\(item.기준년코드)\(item.기준분기코드)"]?.append(item)
        }
        
        return areaList(areas: datasList)


    }
    
    
}


