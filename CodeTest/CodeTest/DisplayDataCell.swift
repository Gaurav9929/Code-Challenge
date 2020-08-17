//
//  DisplayDataCell.swift
//  CodeTest
//
//  Created by Gaurav Bangad on 13/08/20.
//  Copyright © 2020 Gaurav Bangad. All rights reserved.
//

import UIKit

class DisplayDataCell: UITableViewCell {
 
    let cellId = "categoryCell"
    var idLabel:UILabel = UILabel.init()
    var dateLabel:UILabel = UILabel.init()
    var displayButtonForTextOrImage:UIButton = UIButton.init()
    var cellBackgroundView:UIView = UIView.init()
    var displayImageView: UIImageView = UIImageView.init()
    var displayTextView: UITextView = UITextView.init()
    var indicator: UIActivityIndicatorView! = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createTableCell()
        addIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createTableCell() {
      //  self.frame(forAlignmentRect: CGRect.init(x: 0, y: 0, width: 320, height: 70))

        //Cell background view
      //  self.contentView.backgroundColor = UIColor.orange
        
        cellBackgroundView = UIView.init(frame: CGRect.init(x: 10, y: 10, width: self.contentView.frame.size.width-20, height: self.contentView.frame.size.height - 20))

        cellBackgroundView.backgroundColor = UIColor.orange

        //for id
         idLabel = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: self.cellBackgroundView.bounds.size.width/2 - 30 ,height: 60))
        idLabel.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))
        idLabel.textAlignment = .center
        idLabel.textColor = UIColor.black
        idLabel.layer.cornerRadius = 20.0
        idLabel.layer.masksToBounds = true
        idLabel.font = UIFont(name: "Helvetica", size:20.0)

        //for date at corner
        dateLabel = UILabel.init(frame: CGRect.init(x: self.cellBackgroundView.bounds.size.width/2, y: 10, width: self.cellBackgroundView.bounds.size.width/2 - 10, height: 60))
        dateLabel.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))
        dateLabel.layer.cornerRadius = 20.0
        dateLabel.layer.masksToBounds = true
        dateLabel.textColor = UIColor.black
        dateLabel.textAlignment = .center
        dateLabel.autoresizingMask = [.flexibleWidth];
        dateLabel.font = UIFont(name: "Helvetica", size:20.0)


        let widthOfScreen = UIScreen.main.bounds.size.width - 40

        displayTextView = UITextView.init(frame: CGRect.init(x: 10, y: 80, width: widthOfScreen, height: 200))
        displayTextView.textColor = UIColor.black
        displayTextView.font = UIFont(name: "Helvetica", size: 20.0)
        displayTextView.isEditable = false
        displayTextView.isSelectable = false
        displayTextView.isUserInteractionEnabled = false
        displayTextView.isScrollEnabled = true
        displayTextView.layoutIfNeeded()
        displayTextView.setNeedsLayout()
        
        //for image
        displayImageView = UIImageView.init(frame: CGRect.init(x: cellBackgroundView.bounds.size.width/2 - 60, y: 80, width: 200, height: 200))
        displayImageView.layer.cornerRadius = displayImageView.frame.size.width/2
        displayImageView.layer.masksToBounds = true

        
       //let clickOnCellButton =
        
        
        cellBackgroundView.addSubview(idLabel)
        cellBackgroundView.addSubview(dateLabel)
        cellBackgroundView.addSubview(displayTextView)
        cellBackgroundView.addSubview(displayImageView)
        self.contentView.addSubview(cellBackgroundView)
        self.cellBackgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight];


    }
    
    func addIndicator() -> Void{
       indicator = UIActivityIndicatorView(style: .large)
        indicator.frame = CGRect(x: contentView.center.x, y: self.cellBackgroundView.frame.size.height/2, width:80 , height: 80)
        indicator.center = contentView.center
        indicator.color = .lightGray
        self.contentView.addSubview(indicator)
        self.contentView.bringSubviewToFront(indicator)
        indicator.layoutIfNeeded()
        indicator.setNeedsLayout()
    }
    
 
}
