//
//  DisplayFullViewController.swift
//  CodeTest
//
//  Created by Gaurav Bangad on 17/08/20.
//  Copyright © 2020 Gaurav Bangad. All rights reserved.
//

import UIKit

class DisplayFullViewController: UIViewController {
    
    var backgroundView:UIView = UIView()
    var displayImageView: UIImageView = UIImageView.init()
    var idLabel:UILabel!
    var dateLabel:UILabel!
    var displayTextView: UITextView = UITextView.init()

    var displayModel = DisplayDataModel.init(dictionary: [:])
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        displayFullUI()
    }
    
    func displayFullUI(){
                
        backgroundView = UIView.init(frame: CGRect.init(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 70))
        
         self.backgroundView.backgroundColor = UIColor.white
        
        //DisplayImage
        // - self.backgroundView.bounds.size.height/2
        
        
        if displayModel.type == "image"{
            //  DispalyText
            
            displayImageView = UIImageView.init(frame: CGRect.init(x:self.backgroundView.frame.size.width/2 - self.backgroundView.frame.size.width/4, y: 60, width: self.backgroundView.frame.size.width/2 , height: self.backgroundView.frame.size.width/2))
            displayImageView.layer.cornerRadius = displayImageView.frame.size.width/2
            displayImageView.layer.masksToBounds = true
            displayImageView.clipsToBounds = true
          //  displayImageView.sizeToFit()
            displayTextView.isHidden = true
            displayImageView.isHidden = false
            var image:UIImage!
            let activityIndicator = UIActivityIndicatorView.init(style:.medium)
            activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            activityIndicator.startAnimating()
            if  image == nil{
                self.view.addSubview(activityIndicator)
            }
            URLSession.shared.dataTask(with: NSURL(string: displayModel.data!)! as URL, completionHandler: { (data, response, error) -> Void in

                if error != nil {
                    print(error ?? "No Error")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                        image = UIImage(data: data!)
                    activityIndicator.removeFromSuperview()
                    self.displayImageView.image = image
                    
                })

            }).resume()
            
           idLabel = UILabel.init(frame: CGRect.init(x: 10, y: self.displayImageView.bounds.origin.y + self.displayImageView.frame.size.height + 80, width: self.backgroundView.frame.size.width - 20 ,height: 60))
            
        }
  
        else{
            displayTextView = UITextView.init(frame: CGRect.init(x:10, y: 60, width: self.backgroundView.frame.size.width - 20 , height: self.backgroundView.frame.size.height/2))
            displayTextView.textColor = UIColor.black
            displayTextView.font = UIFont(name: "Helvetica", size: 20.0)
            displayTextView.isEditable = false
            displayTextView.isSelectable = false
           // displayTextView.isUserInteractionEnabled = false
            displayTextView.layoutIfNeeded()
            displayTextView.setNeedsLayout()
            displayTextView.text = displayModel.data
            displayTextView.isScrollEnabled = true
            self.displayImageView.isHidden = true
            self.displayTextView.isHidden = false
            
             idLabel = UILabel.init(frame: CGRect.init(x: 10, y: self.displayTextView.bounds.origin.y + self.displayTextView.frame.size.height + 80, width: self.backgroundView.frame.size.width - 20 ,height: 60))
            
        }
                
         //DisplayId
                
       
        
               idLabel.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))
               idLabel.textAlignment = .center
               idLabel.textColor = UIColor.black
               idLabel.layer.cornerRadius = 20.0
               idLabel.layer.masksToBounds = true
               idLabel.font = UIFont(name: "Helvetica", size:20.0)
               idLabel.text = "ID:- \(displayModel.id ?? "")"
        idLabel.clipsToBounds = true
        
        //  DisplayDate
        dateLabel = UILabel.init(frame: CGRect.init(x: 10, y: self.idLabel.frame.origin.y + idLabel.frame.size.height + 30, width: self.backgroundView.frame.size.width - 20, height: 60))
        dateLabel.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))
            
            dateLabel.layer.cornerRadius = 20.0
               dateLabel.layer.masksToBounds = true
               dateLabel.textColor = UIColor.black
               dateLabel.textAlignment = .center
               dateLabel.autoresizingMask = [.flexibleWidth];
               dateLabel.font = UIFont(name: "Helvetica", size:20.0)
                dateLabel.text = "DATE :- \(displayModel.date ?? "")"
              
        dateLabel.clipsToBounds = true
        self.backgroundView.backgroundColor = UIColor.white
        
     
        
        self.backgroundView.addSubview(displayImageView)
        self.backgroundView.addSubview(displayTextView)

        self.backgroundView.addSubview(idLabel)
        self.backgroundView.addSubview(dateLabel)
        self.view.addSubview(self.backgroundView)
    }

    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
