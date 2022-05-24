//
//  InfoFormViewController.swift
//  TRAS_AR_APP
//
//  Created by hong on 2022/05/14.
//

import UIKit
import SnapKit
import Eureka

class InfoFormViewController: FormViewController {
    
//    let banner: UIImageView = {
//        let bannerImage = UIImage(named: "banner_image")!
//        let banner = UIImageView(image: bannerImage)
//        return banner
//    }()
    
    
    var gu = ""
    var dong = ""
    var budget = 0
    var category1 = ""
    var category2 = ""
    
    let toARView: UIButton = {
        let toARView = UIButton()
        toARView.backgroundColor = .blue
        toARView.setTitle("예측", for: .normal)
        toARView.setTitleColor(UIColor.black, for: .normal)
        toARView.layer.cornerRadius = 10
        toARView.clipsToBounds = true
        toARView.backgroundColor = .white
        toARView.layer.borderColor = UIColor.black.cgColor
        toARView.layer.borderWidth = 2
        return toARView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(locFullDic)
        
//        self.view.addSubview(banner)

        createLoginForm()
        self.view.addSubview(toARView)
        toARView.addTarget(self, action: #selector(toARViewTapped), for: .touchUpInside)
        
    }
    
    private func alertNillData(nodata text: String) {
        
        let alert = UIAlertController(title: "", message: "\(text) 정보를 입력해주세요", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
        
    }
    
    private func findCoorData(dong data: String) {
        
        for item in locDatas {
//            print(item.법정동, self.dong)
            if item.법정동 == data {
                coor = [item.상권위도, item.상권경도]
                return
            }
        }
        
//        for item in locDatas {
////            print(item.법정동, self.dong)
//            if item.법정동 == data {
//                coor = [item.상권위도, item.상권경도]
//                return
//            }
//        }
        coor = [37.49510129007885, 127.11826137870351]
        return 
    }
    
    private func findAreaInfo(dong data: String, category2 category: String) {
        
        let list1 = locFullDic["20214"]!
        for item in list1 {

            if item.법정동 == data && item.서비스업종코드명 == category {
                fourthQuarter = item
                print(fourthQuarter!)
                break
            }
        }

        let list2 = locFullDic["20213"]!
        for item in list2 {

            if item.법정동 == data && item.서비스업종코드명 == category {
                thirdQuarter = item
                print(thirdQuarter!)
                break
            }
        }


        let list3 = locFullDic["20212"]!
        for item in list3 {

            if item.법정동 == data && item.서비스업종코드명 == category {
                secondQuearter = item
                print(secondQuearter!)
                break
            }
        }

        
        let list4 = locFullDic["20211"]!
        for item in list4 {
            
            if item.법정동 == data && item.서비스업종코드명 == category {
                firstQuarter = item
                print(firstQuarter!)
                break
            }
        }

    }
    
    @objc func toARViewTapped() {
        
        if budget == 0 {
            alertNillData(nodata: "예산")
        } else if gu == "" {
            alertNillData(nodata: "구")
        } else if dong == "" {
            alertNillData(nodata: "동")
        } else if category1 == "" {
            alertNillData(nodata: "업종")
        } else if category2 == "" {
            alertNillData(nodata: "상세 업종")
        }
        
        findCoorData(dong: self.dong)
        findAreaInfo(dong: self.dong, category2: self.category2)
        

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ARMapView")
        vc?.modalTransitionStyle = .coverVertical
        present(vc!, animated: true, completion: nil)

    }
    
    private func createLoginForm() {
        form +++ Section(header: "예측하기 위한 정보를 입력해주세요", footer: "")
            <<< IntRow() {
                $0.title = "예산(만원)"
                $0.placeholder = "예산"
                $0.validationOptions = .validatesAlways
            }.onChange({ row  in
                self.budget = row.value as! Int
                print(self.budget)
            })
            <<< ActionSheetRow<String>() {
                $0.title = "구"
                $0.selectorTitle = "구를 선택해주세요"
                $0.options = guList
            }.onChange({ row  in
                self.gu = row.value as! String
                print(self.gu)
                
                self.form +++ Section(header: "동 정보를 입력해주세요", footer: "")
                <<< ActionSheetRow<String>() {
                    $0.title = "동"
                    $0.selectorTitle = "동을 선택해주세요"
                    $0.options = dongList[self.gu]
                    //                    $0.value = "Two"    // initially selected
                }.onChange({ row  in
                    self.dong = row.value as! String
                    print(self.dong)
                    
                    self.form +++ Section(header: "업종 정보를 입력해주세요", footer: "")
                    <<< ActionSheetRow<String>() {
                        $0.title = "업종"
                        $0.selectorTitle = "업종을 선택해주세요"
                        $0.options = category1List
                        //                    $0.value = "Two"    // initially selected
                    }.onChange({ row  in
                        self.category1 = row.value as! String
                        print(self.category1)
                        self.form +++ Section(header: "상세 업종 정보를 입력해주세요", footer: "")
                        <<< ActionSheetRow<String>() {
                            $0.title = "상세 업종"
                            $0.selectorTitle = "상세 업종을 선택해주세요"
                            $0.options = categoryList[self.category1]
                            //                    $0.value = "Two"    // initially selected
                        }.onChange({ row  in
                            self.category2 = row.value as! String
                            print(self.category2)
                        })
                    })
                })
            })
        
        
//        <<< ActionSheetRow<String>() {
//            $0.title = "구"
//            $0.selectorTitle = "구를 선택해주세요"
//            $0.options = guList
//        }.onChange({ row  in
//            self.gu = row.value as! String
//            print(self.gu)
//        })
        
//            <<< ActionSheetRow<String>() {
//                    $0.title = "동"
//                    $0.selectorTitle = "동을 선택해주세요"
//                    $0.options = dongList[self.gu]
////                    $0.value = "Two"    // initially selected
//                }.onChange({ row  in
//                    self.dong = row.value as! String
//                    print(self.dong)
//                })
//            <<< IntRow() {
//                    $0.title = "예산(만원)"
//                    $0.placeholder = "예산"
//                $0.validationOptions = .validatesAlways
//                }.onChange({ row  in
//                    self.budget = row.value as! Int
//                    print(self.budget)
//                })
        
//            <<< ActionSheetRow<String>() {
//                    $0.title = "업종"
//                    $0.selectorTitle = "업종을 선택해주세요"
//                    $0.options = ["One","Two","Three"]
////                    $0.value = "Two"    // initially selected
//                }.onChange({ row  in
//                    self.category1 = row.value as! String
//                    print(self.category1)
//                })
        
//            <<< ActionSheetRow<String>() {
//                    $0.title = "상세 업종"
//                    $0.selectorTitle = "상세 업종을 선택해주세요"
//                    $0.options = ["One","Two","Three"]
////                    $0.value = "Two"    // initially selected
//                }.onChange({ row  in
//                    self.category2 = row.value as! String
//                    print(self.category2)
//                })
        
        
        }
    
    
    
    
    override func viewDidLayoutSubviews() {
        
        toARView.snp.makeConstraints { make in
            
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view.frame.width/3)
            make.height.equalTo(self.view.frame.height/11)
            make.top.equalTo(self.view.frame.height-100 )
         
        }
    }

}
