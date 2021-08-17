//
//  ViewController.swift
//  BigWorkTestApp
//
//  Created by kang jiyoun on 2021/08/13.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

import DropDown

class ViewController: UIViewController {
    
    let bag : DisposeBag = DisposeBag()
    let menuBarStartIndex : Int = 0
    
    let uploadData : Driver<Void> = Driver<Void>.just(())
    
    lazy var viewModel : ViewControllerViewModel = {
        ViewControllerViewModel(Input: (selectIndex: PublishSubject<Int>(), reloadData : dropDownBtn.rx.tap.map { _ in () }.asDriver(onErrorJustReturn: ())))
    }()
    
    
    lazy var xMarkButton : UIImageView = {
        var xMark = UIImageView()
        var markImage =  UIImage(systemName: "xmark", withConfiguration: .none)
        markImage?.withRenderingMode(.alwaysTemplate)
        xMark.image = markImage
        xMark.tintColor = .black
        xMark.contentMode = .scaleToFill
        
        return xMark
    }()
    
    lazy var spinner : UIView = {
        let view = UIView()
        //view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.backgroundColor = .gray.withAlphaComponent(0.9)
       
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        spinner.startAnimating()
        return view
    }()
    
    
    lazy var HeaderTextView1 : UILabel = {
        var headerView = UILabel()
        headerView.backgroundColor = .clear
        headerView.textColor = .black
        headerView.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        headerView.text = "캠페인"
        headerView.sizeToFit()
        return headerView
    }()
    
    lazy var HeaderTextView2 : UILabel = {
        var headerView = UILabel()
        headerView.backgroundColor = .clear
        headerView.textColor = .black
        headerView.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        headerView.text = "포스트"
        headerView.sizeToFit()
        return headerView
    }()
    
    lazy var topStackView : UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.sizeToFit()
        stackView.addArrangedSubview(HeaderTextView1)
        stackView.addArrangedSubview(HeaderTextView2)
        return stackView
    }()
    lazy var completedCollectionViewHeader : UILabel = {
        var headerView = UILabel()
        headerView.backgroundColor = .clear
        headerView.textColor = .black
        
        headerView.font = UIFont.systemFont(ofSize: 14, weight: .black)
        headerView.text = "내가 참여한 캠페인"
        headerView.sizeToFit()
        return headerView
    }()
    lazy var completedCollectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        //스크롤 방향조절
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(UINib(nibName : "CompletedCampaignCell", bundle : nil) , forCellWithReuseIdentifier : "CompletedCampaignCell")
        
        return cv
        
    }()
    
    
    lazy var menuCollectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        //아이템마다 간격조정
        
        //스크롤 방향조절
        layout.scrollDirection = .horizontal
        //section 의 위치 조절 -> 공부필요
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(UINib(nibName : "HorizontalMenuBarCell", bundle : nil) , forCellWithReuseIdentifier : "HorizontalMenuBarCell")
        return cv
        
    }()
    
    lazy var dropDownBtn : UIButton = {
        var isbeauty = UIButton()
   
        isbeauty.setTitleColor(.green, for: .normal)
        isbeauty.titleLabel!.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        isbeauty.backgroundColor = UIColor.clear
        isbeauty.titleLabel?.sizeToFit()
        isbeauty.layer.cornerRadius = 5
        isbeauty.layer.borderWidth = 1
      
        return isbeauty
    }()
    
    lazy var optionBox : DropDown = {
        var dropBox = DropDown()
        dropBox.dataSource = ["피자", "치킨", "족발보쌈", "치즈돈까스", "햄버거"]
       
       
        return dropBox
    }()
    
    
    
    
    lazy var campaingItemCollectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        //아이템마다 간격조정
        
        //스크롤 방향조절
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(UINib(nibName : "CampaignCellView", bundle : nil) , forCellWithReuseIdentifier : "CampaignCellView")
        return cv
        
    }()
    
    
    var currentIndex: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetting()
     //   print(solution2([5, 1, 9, 8, 10, 5],3))
        //   setupDataSrource()
    }
    
    
    
    
    
}
extension ViewController {
    
   
    func UISetting() {
        view.addSubview(xMarkButton)
        view.addSubview(topStackView)
        view.addSubview(completedCollectionViewHeader)
        view.addSubview(campaingItemCollectionView)
        view.addSubview(menuCollectionView)
        view.addSubview(dropDownBtn)
        view.addSubview(optionBox)
        view.addSubview(completedCollectionView)
        view.addSubview(spinner)
        
        
        // view.safeAreaLayoutGuide.ba
        //        view.addSubview()
        //Xmark Setting
        xMarkButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view).offset(10)
            make.width.height.equalTo(20)
        }
        topStackView.snp.makeConstraints { make in
            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view)
            
            // make.right.equalTo(HeaderTextView2.snp.leading).offset(10)
        }
        //완료한 아이템 해더 타이틀
        completedCollectionViewHeader.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(5)
            make.leading.equalTo(view).offset(10)
        }
        
        completedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(completedCollectionViewHeader.snp.bottom).offset(5)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(140)
        }
        //메뉴창 셋팅
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(completedCollectionView.snp.bottom).offset(5)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(30)
        }
        dropDownBtn.snp.makeConstraints { make in
            make.top.equalTo(menuCollectionView.snp.bottom).offset(5)
            make.leading.equalTo(view).offset(10)
            make.height.equalTo(30)
        }
        
        dropDownBtn.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        optionBox.anchorView = dropDownBtn
        
        
        
//        optionBox.snp.makeConstraints { make in
//            make.top.equalTo(completedCollectionView.snp.bottom).offset(5)
//            make.width.equalTo(UIScreen.main.bounds.width)
//            make.height.equalTo(30)
//        }
//
        //아이템들이 보여줄공간 셋팅
        campaingItemCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dropDownBtn.snp.bottom)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        completedCollectionView.rx.setDelegate(self).disposed(by: bag)
        
        
        //메뉴컬랙션뷰와 뷰모델의 메뉴데이터를 바인딩
        viewModel.output.completedItem
            .asObservable()
            .bind(to: completedCollectionView.rx.items){
                (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompletedCampaignCell", for: indexPath) as? CompletedCampaignCell
                cell?.configure(cellItem: element)
                
                return cell!
            }.disposed(by: bag)
        
            // viewModel.input.selectIndex.onNext(self.optionBox.index)
        
        
        
        //메뉴컬랙션의 딜리게이트 선언
        menuCollectionView.rx.setDelegate(self).disposed(by: bag)
        //메뉴컬랙션뷰와 뷰모델의 메뉴데이터를 바인딩
        viewModel.output.menuDataSources
            .asObservable()
            .bind(to: menuCollectionView.rx.items){
                (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalMenuBarCell", for: indexPath) as? HorizontalMenuBarCell
                
                cell?.onData.onNext(element)
                
                return cell!
            }.disposed(by: bag)
        
        //메뉴를 클릭했을경우에 따른 뷰처리와 에니메이션 처리
        menuCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self]indexPath in
                self?.viewModel.input.selectIndex.onNext(indexPath.row)
                self?.menuCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }).disposed(by: bag)
        //메뉴 컬랙션이 완성된후 기본값을 넣어줘야 정상적으로 에니매이션이 작동한다.
        self.viewModel.input.selectIndex.onNext(menuBarStartIndex)
        
        //켐페인컬랙션뷰의 딜리게이트 선언
        campaingItemCollectionView.rx.setDelegate(self).disposed(by: bag)
        //켐페인컬랙션뷰와 뷰모델의 컬랙션 데이터와 바인딩
        viewModel.output.campaigns
            .asObservable()
            .bind(to: campaingItemCollectionView.rx.items){
                (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CampaignCellView", for: indexPath) as? CampaignCellView
                cell?.configure(cellItem: element)
                return cell!
                
            }.disposed(by: bag)
        
        
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        
        
        // 액티비티 인디케이터
        viewModel.output.activity
            .map { !$0 }
            .asObservable()
            .bind(to: spinner.rx.isHidden)
            .disposed(by: bag)
        
        
//
//        dropDownBtn.rx.controlEvent(.touchDown)
//            .bind(to: viewModel.input.fetchMenus)
//
//            .disposed(by: bag)
  
     
//        viewModel.output.menuDataSources
//            .map { items in
//                return "테스트"
//            }
//            .asObservable()
//            .bind(to: dropDownBtn.rx.title())
//            .disposed(by: bag)
//        
    }
    
 
    @objc
    func buttonDidTap() {
        
        optionBox.bottomOffset = CGPoint(x: 0, y : optionBox.anchorView!.plainView.bounds.height)
        optionBox.show()
     //   print(optionBox.anchorView?.plainView.bounds.height)
    }
}




extension ViewController :  UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == self.menuCollectionView){
            return CGSize(width: 100, height: 30)
        }else if(collectionView == self.completedCollectionView){
            return CGSize(width: 100, height: 140)
        }else{
            return CGSize(width: UIScreen.main.bounds.width, height: 120)
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(scrollView == self.campaingItemCollectionView){
            let offset = scrollView.contentOffset.y
            let height = scrollView.contentSize.height
//
          
            if offset > height - scrollView.frame.size.height - 300 {
                self.viewModel.process()
            }
        }
      
    }
}
