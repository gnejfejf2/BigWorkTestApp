//
//  cloneViewModel.swift
//  BigWorkTestApp
//
//  Created by kang jiyoun on 2021/08/13.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
protocol ViewControllerModelProtocol {
    //ex typealias MyName = String
    //var name: MyName = "brody"
    //Driver는 UI layer에서 좀 더 직관적으로 사용하도록 제공하는 unit입니다. Observable는 상황에 따라 MainScheduler와 BackgroundScheduler를 지정해줘야 하지만 Driver는 MainScheduler에서 사용합니다.
    typealias Input = (
        (selectIndex : PublishSubject<Int> , reloadData : Driver<Void> )
    )
    typealias Output = (
        completedItem : Driver<[CampaignModelElement]> , menuDataSources : Driver<[HorizontalMenuBarControllerModel]> , campaigns : Driver<[CampaignModelElement]> , activity : BehaviorSubject<Bool>
    )
   
    var input : ViewControllerModelProtocol.Input { get }
    var output : ViewControllerModelProtocol.Output { get }
    
    
}

class ViewControllerViewModel : ViewControllerModelProtocol {
    var input : ViewControllerModelProtocol.Input
    var output : ViewControllerModelProtocol.Output

   
    let service : CampaignService = CampaignService.shared
    
    typealias State = (campaings : BehaviorRelay<CampaignModelElements> ,  activating : BehaviorSubject<Bool>)
    private let state : State = (campaings : BehaviorRelay(value: []) , activating : BehaviorSubject<Bool>(value: false))
   
    var pagingCount : Int = 0
    var pagingActive : Bool = true
    let pagingSize : Int = 20
    
    
    let bag : DisposeBag = DisposeBag()
  
    init(Input : ViewControllerModelProtocol.Input){
      
        input = Input
        output = ViewControllerViewModel.getOutput(service , input, state: state)
        process()
    }
    
}

private extension ViewControllerViewModel {
    
    static func getOutput(_ service : CampaignService , _ Input : ViewControllerModelProtocol.Input  , state : State) ->  ViewControllerModelProtocol.Output{
       // let fetching = PublishSubject<Void>()
       
        
        let index = Input.selectIndex.asObserver()
    
        let completedItems = state.campaings
            .map{ $0.filter{ $0.my.story } }
            .asDriver(onErrorJustReturn: [])
      
    
        let menus = Single<[String]>.just(["전체", "노인","지구촌","환경","장애인"])
            .asObservable()
           
        let menuSettings : Driver<[HorizontalMenuBarControllerModel]> = Observable
            .combineLatest(index , menus)
            .map { (selectedIndex, menuItems) in
                var selectedMenu : [HorizontalMenuBarControllerModel] = []
                for i in 0..<menuItems.count{
                    if(i == selectedIndex){
                        selectedMenu.append(HorizontalMenuBarControllerModel(withTitle: menuItems[i] , isSelected: true))
                    }else{
                        selectedMenu.append(HorizontalMenuBarControllerModel(withTitle: menuItems[i] , isSelected: false))
                    }
                    
                }
                return selectedMenu
            }
            .map{ $0 }
            .asDriver(onErrorJustReturn: [])
         
        let gerItem = state.campaings.asDriver(onErrorJustReturn: [])
        
        
         
        
        
        return (completedItem : completedItems , menuDataSources : menuSettings , campaigns : gerItem , activity : state.activating.asObserver())
        
    }
    
}

extension ViewControllerViewModel {
   
    func process() -> Void {
        if(self.pagingActive){
            state.activating.onNext(true)
            self.service.fetchCampaign(pagingCount: pagingCount, pagingSize: pagingSize)
                .asObservable()
               
                .map({  [state , weak self]  in
                    if($0.count == self!.pagingSize - 1 || $0.count == self?.pagingSize){
                        self?.pagingCount += 1
                    }else if($0.count == 0){
                        self?.pagingActive = false
                    }
                        
                    
                    state.campaings.accept(state.campaings.value + $0)
                })
                .do(onNext: { [weak self] _ in
                    self?.state.activating.onNext(false)
                })
                .do(onError: { [weak self] _ in
                    self?.pagingActive = false
                    self?.state.activating.onNext(false)
                })
                .subscribe()
                .disposed(by: bag)
        }
        
    }
    
}
