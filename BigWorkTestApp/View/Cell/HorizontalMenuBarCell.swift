//
//  HorizontalMenuBarCell.swift
//  BigWorkTestApp
//
//  Created by kang jiyoun on 2021/08/13.
//

import UIKit
import RxSwift
import RxCocoa

class HorizontalMenuBarCell: UICollectionViewCell {
    
    
    let onData : AnyObserver<HorizontalMenuBarControllerModel>
    var bag = DisposeBag()
   
    @IBOutlet var TitleName: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        
        let data = PublishSubject<HorizontalMenuBarControllerModel>()
      
        onData = data.asObserver()
      
        
        super.init(coder: aDecoder)

        data
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] menu in
                self?.TitleName.text = menu.menuTitle
                if(menu.isSelected){
                    self?.TitleName.layer.cornerRadius = 10
                    self?.TitleName.backgroundColor = .blue
                }else{
                    self?.TitleName.layer.cornerRadius = 0
                    self?.TitleName.backgroundColor = .clear
                }
                
            })
            .disposed(by: bag)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

 

    
}
