
//  MenuViewController.swift
//  HorizontalMenu
//
//  Created by Ramprasad A on 13/01/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit


struct HorizontalMenuBarControllerModel : Identifiable {
    var id : String = UUID().uuidString
    var menuTitle: String
    var isSelected: Bool
    
    init(withTitle title: String, isSelected selected: Bool) {
        self.menuTitle = title
        self.isSelected = selected
    }
}

class HorizontalMenuBarController : UIViewController {
    
    
    var menuCollectionView: UICollectionView = UICollectionView()
    
    var menuList = ["NEWS", "TECHNOLOGY", "POLYTICS", "SCIENCE", "SPORTS"]
    var segueIdentifiers = ["First", "Second", "Third", "Fourth", "Fifth"]
    var menuDataSource: [HorizontalMenuBarControllerModel] = []
 
    var currentIndex: Int = 0

    
    //View Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        dragGestureSetting()
        setupDataSrource()
   
        
    }


    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
   
}

//MARK:- Helper Methods:
extension HorizontalMenuBarController {
    
    func dragGestureSetting(){
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe(_:)))
        leftRecognizer.direction = .left
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe(_:)))
        rightRecognizer.direction = .right
        self.view.addGestureRecognizer(leftRecognizer)
        self.view.addGestureRecognizer(rightRecognizer)
    }
    
    @objc private func handleRightSwipe(_ sender: UISwipeGestureRecognizer) {
        if currentIndex > 0 {
            self.currentIndex = self.currentIndex - 1
            let indexPath = IndexPath(row: currentIndex, section: 0)
            self.menuCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            
            self.updateMenuObjects()
          
        }
    }
    
   @objc private func handleLeftSwipe(_ sender: UISwipeGestureRecognizer) {
        if currentIndex < self.segueIdentifiers.count - 1 {
            self.currentIndex = self.currentIndex + 1
            let indexPath = IndexPath(row: currentIndex, section: 0)
            
            self.menuCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            self.updateMenuObjects()
          
        }
    }
    
    //Creates a data source array for Horizontal Menu with tapped state.
    func setupDataSrource() {
        for (index, menuItem) in self.menuList.enumerated() {
            if index == 0 {
                let menuObject = HorizontalMenuBarControllerModel(withTitle: menuItem, isSelected: true)
                self.menuDataSource.append(menuObject)
            } else {
                let menuObject = HorizontalMenuBarControllerModel(withTitle: menuItem, isSelected: false)
                self.menuDataSource.append(menuObject)
            }
        }
    }
    
  
    //Updates Menu List Objects upon - Tap on Menu or Scroll using swipe Gestures
    func updateMenuObjects() {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        for (index, _) in self.menuDataSource.enumerated() {
            if index == indexPath.row {
                self.menuDataSource[index].isSelected = true
            } else {
                self.menuDataSource[index].isSelected = false
            }
        }
        self.menuCollectionView.reloadData()
    }
}

//MARK:- Collection View Data Source Methods:
extension HorizontalMenuBarController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalMenuBarCell", for: indexPath) as? HorizontalMenuBarCell
        let menuObject = self.menuDataSource[indexPath.row]
        cell?.TitleName.text = menuObject.menuTitle
        if menuObject.isSelected {
          //  cell?.SelectedView.backgroundColor = UIColor.red
            cell?.TitleName.textColor = UIColor.blue
        } else {
          //  cell?.SelectedView.backgroundColor = UIColor.white
            cell?.TitleName.textColor = UIColor.black
            cell?.TitleName.backgroundColor = UIColor.white
        }
        return cell!
    }
}

//MARK:- Collection View Delegate Source Methods:
extension HorizontalMenuBarController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        for (index, _) in self.menuDataSource.enumerated() {
            if index == indexPath.row {
                self.menuDataSource[index].isSelected = true
            } else {
                self.menuDataSource[index].isSelected = false
            }
        }
        collectionView.reloadData()
       
    }
}


