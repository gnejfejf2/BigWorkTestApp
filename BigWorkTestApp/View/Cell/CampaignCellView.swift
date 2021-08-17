//
//  CampaignCellView.swift
//  BigWorkTestApp
//
//  Created by kang jiyoun on 2021/08/13.
//

import UIKit
import Kingfisher
class CampaignCellView: UICollectionViewCell {
    @IBOutlet var BannerImage: UIImageView!
    
    @IBOutlet var CoverImageView: UIImageView!
    @IBOutlet var TitleTextView: UILabel!
    @IBOutlet var SubTextView: UILabel!
    @IBOutlet var ProcessingView: UILabel!
    @IBOutlet var RecruitmentView: UILabel!
    @IBOutlet var PercentView: UILabel!
    @IBOutlet var PercentProgressView: UIProgressView!
    @IBOutlet var FinishView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configure(cellItem : CampaignModelElement){
        let url = URL(string: cellItem.smallListThumbnailImagePath)
        
        //이미지세팅
        BannerImage.kf.setImage(with: url)
        
        CoverImageView.isHidden = !cellItem.my.story
        
        
        TitleTextView.text = cellItem.name
       
        if(cellItem.endDate.stringToDate()!.nowTimeDif()){
            RecruitmentView.text = cellItem.my.story ? "기부완료" : "진행중"
            unCompletedCampaign()
        }else{
            RecruitmentView.text = cellItem.my.story ? "기부완료" : "종료"
            completedCampaign()
        }
        
        
        
        SubTextView.text = cellItem.campaignPromoter.name
        ProcessingView.text = (cellItem.organizations.count > 0 ? ProccesingEnum.open.rawValue : ProccesingEnum.group.rawValue)
        PercentView.text = String(cellItem.ratio) + "%"
        PercentProgressView.setProgress(Float((cellItem.ratio >= 100 ? 1 : Float(cellItem.ratio) / 100)) , animated: true)
        
        
    }
    
    func unCompletedCampaign(){
        BannerImage.alpha = 1.0
        TitleTextView.alpha = 1.0
        SubTextView.alpha = 1.0
    }
    
    func completedCampaign(){
        BannerImage.alpha = 0.1
        TitleTextView.alpha = 0.1
        SubTextView.alpha = 0.1
    }
    
    
}




