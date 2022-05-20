//
//  LocalInfoModel.swift
//  TRAS_AR_APP
//
//  Created by hong on 2022/05/15.
//

import Foundation


let loc_coor = [Double]()

// 점포 수 변화

// 분기당 매출 건수

// 업종 대분류 중 업종 소분류의 점포 수 비중

// 주중/ 주말 매출 건수 대비 매출 금액 비중

// 낮/ 밤 매출 건수 대비 매출 금액 비중

// 성별 매출 건수 대비 매출 금액 비중

// 연령 대별 매출 건수 대비 매출 금액 비중 


struct locList: Codable {
    let locs: [locInfo]
}
struct locInfo: Codable {
    let 일자 : Int
    let 상권구분 : String
    let 상권명 : String
    let 상권경도 : Double
    let 상권위도 : Double
    let 시 : String
    let 구 : String
    let 법정동 : String
}


struct areaList: Codable {
    let areas: [areaInfo]
}

struct areaInfo: Codable {
    let 기준년코드 : Int
    let 기준분기코드 : Int
    let 상권구분코드명 : String
    let 상권코드명 : String
    let 서비스업종코드명 : String
    let 분기당매출금액 : Int
    let 분기당매출건수 : Int
    let 점포수 : Int
    let 시 : String
    let 구 : String
    let 법정동 : String
    let 지역분류 : Int
    let 서비스분류 : Int
    let 주중매출비율 : Int
    let 주말매출비율 : Int
    let 낮매출비율 : Int
    let 밤매출비율 : Int
    let 남성매출비율 : Int
    let 여성매출비율 : Int
    let 청소년매출비율 : Int
    let 청년매출비율 : Int
    let 장년매출비율 : Int
    let 중노년매출비율 : Int
    let top3요일 : Int
    let top3시간 : Int
    let top3연령 : Int
    let top성별 : Int
}
