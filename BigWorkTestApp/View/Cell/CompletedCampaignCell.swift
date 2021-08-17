//
//  CompletedCampaignCell.swift
//  BigWorkTestApp
//
//  Created by kang jiyoun on 2021/08/16.
//

import UIKit

class CompletedCampaignCell: UICollectionViewCell {
    @IBOutlet var BannerImageView: UIImageView!
    
    @IBOutlet var CampaignName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configure(cellItem : CampaignModelElement){
        let url = URL(string: cellItem.smallListThumbnailImagePath)
        //이미지세팅
        BannerImageView.kf.setImage(with: url)
        BannerImageView.layer.cornerRadius = 10
        CampaignName.text = "테스트용 문구입니다."


    }
    
//    func configure(){
////        let url = URL(string: cellItem.smallListThumbnailImagePath)
//        //이미지세팅
//        BannerImageView.image = UIImage(named: "1")
//        BannerImageView.layer.cornerRadius = 10
//        CampaignName.text = "테스트용 문구입니다."
//
//
//    }
}
