//
//  ViewController.swift
//  CodeTest
//
//  Created by Gaurav Bangad on 13/08/20.
//  Copyright © 2020 Gaurav Bangad. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var backgroundView:UIView = UIView()
    var displayDictionary:[String:Any]!
    var displayArray = [Any]()
    var tableView = UITableView()
    var imageCache = NSCache<NSString, UIImage>()
    var session: URLSession!
    var task: URLSessionDownloadTask!
    var textFilterButton:UIButton!
    var imageFilterButton:UIButton!
    var clearFilterButton:UIButton!

    var noFilter:UIButton!
    var indicator: UIActivityIndicatorView! = nil
    var selectedFilter:Filters!
    var unsortedArray = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        session = URLSession.shared
        task = URLSessionDownloadTask.init()
        selectedFilter = .clearFilter
        
        // Do any additional setup after loading the view.
        addIndicator()
        updateDataWithManager()
        self.createUI()
    }
    
    
    
    func  updateDataWithManager() -> Void {
        self.indicator.startAnimating()
        let manager = DisplayTableDataManager.init()
        manager.saveFile { (myMModel) in
            self.displayArray = myMModel
            self.indicator.stopAnimating()
            self.unsortedArray = myMModel

        }
    }
    
    
    func createUI(){
        
        
       backgroundView = UIView.init(frame: CGRect.init(x: 0, y: 70, width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 70))
        self.backgroundView.backgroundColor = UIColor.white
        addButtons()
        CreateTableView()
        self.view.addSubview(self.backgroundView)
    }
    
    func CreateTableView(){
       // self.backgroundView.frame
        tableView = UITableView.init(frame:CGRect.init(x: 0, y: 150, width: self.backgroundView.frame.size.width, height: self.backgroundView.frame.size.height) , style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.register(DisplayDataCell.self, forCellReuseIdentifier: "categoryCell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView.init()
        self.backgroundView.addSubview(tableView)
    }
    func addButtons() -> Void{
     //  textFilterButton = UIButton.init(frame: CGRect.init(x: 10, y: 10, width: self.view.frame.size.width-20, height: 50))
        
        let buttonStackView = UIStackView.init(frame: CGRect.init(x: 10, y: 40, width: self.view.frame.size.width-20, height: 60))
        
        
        textFilterButton = UIButton.init()
        textFilterButton.setTitleColor(UIColor.white, for: .normal)
        textFilterButton.setTitle("Text", for: .normal)
        textFilterButton.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))
        textFilterButton.tag = 1
        textFilterButton.addTarget(self, action: #selector(buttonTapped(sender:)), for:.touchUpInside)
        textFilterButton.titleLabel?.font = UIFont(name: "Helvetica", size:20.0)
        textFilterButton.layer.cornerRadius = 10.0
        
      //  imageFilterButton = UIButton.init(frame: CGRect.init(x: 10, y: 10, width: self.view.frame.size.width-20, height: 50))
        
        imageFilterButton = UIButton.init()
        imageFilterButton.setTitleColor(UIColor.white, for: .normal)
        imageFilterButton.setTitle("Image", for: .normal)
        imageFilterButton.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))
        imageFilterButton.tag = 2
        imageFilterButton.addTarget(self, action: #selector(buttonTapped(sender:)), for:.touchUpInside)
        imageFilterButton.titleLabel?.font = UIFont(name: "Helvetica", size:20.0)
        imageFilterButton.layer.cornerRadius = 10.0

        
        
        clearFilterButton = UIButton.init()
        clearFilterButton.setTitleColor(UIColor.white, for: .normal)
        clearFilterButton.setTitle("clear", for: .normal)
        clearFilterButton.backgroundColor = UIColor.orange
        clearFilterButton.tag = 3
        clearFilterButton.addTarget(self, action: #selector(buttonTapped(sender:)), for:.touchUpInside)
        clearFilterButton.titleLabel?.font = UIFont(name: "Helvetica", size:20.0)
        clearFilterButton.layer.cornerRadius = 10.0

      
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 8.0

        buttonStackView.addArrangedSubview(textFilterButton)
        buttonStackView.addArrangedSubview(imageFilterButton)
        buttonStackView.addArrangedSubview(clearFilterButton)
       
        self.backgroundView.addSubview(buttonStackView)
        
    }
    @objc func buttonTapped(sender:UIButton) -> Void {
        let tag  = sender.tag
        if tag == 1 {
            selectedFilter = .textFilter
        }else if tag == 2{
            selectedFilter = .imageFilter
        }else if tag == 3{
            selectedFilter = .clearFilter
        }
        sortByKey()
        setButtonBackgroundColor()
    }
    func setButtonBackgroundColor(){
        switch selectedFilter {
        case .textFilter:
             textFilterButton.backgroundColor = UIColor.orange
            
             imageFilterButton.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))
            
             clearFilterButton.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))


            break
        case .imageFilter:
            
            textFilterButton.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))
                       
            imageFilterButton.backgroundColor =  UIColor.orange
                       
            clearFilterButton.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))
            
            break
        case .clearFilter:
            
            textFilterButton.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))
                       
            imageFilterButton.backgroundColor = UIColor.init(cgColor: CGColor.init(srgbRed: 0.90, green: 0.78, blue: 0.61, alpha: 1.0))
            
            clearFilterButton.backgroundColor = UIColor.orange
            
            break
        default:
            break
        }
    }

 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray.count
     //   return 3
       }
       
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)as! DisplayDataCell
        
        let object = displayArray[indexPath.row] as? DisplayDataModel

    cell.dateLabel.text = object?.date
      cell.idLabel.text = object?.id
     cell.displayButtonForTextOrImage.setTitle(object?.type, for: .normal)
     if object?.type == "text" {
        cell.displayImageView.isHidden = true
        cell.displayTextView.isHidden = false
        cell.displayTextView.text = object?.data
          
     }else{
        
            cell.displayImageView.isHidden = false
            cell.displayTextView.isHidden = true
        cell.indicator.startAnimating()
            DispatchQueue.main.async {
                let imageName = object?.data
               
                if let imageCache = self.imageCache.object(forKey: imageName! as NSString){
                    cell.displayImageView.image = imageCache
                    cell.indicator.stopAnimating()
                }else{
                    cell.indicator.startAnimating()

                    let url = URL.init(string: imageName!)
                     
                    self.task = self.session.downloadTask(with: url!, completionHandler: { (location, response, error) -> Void in
                        if let data = try? Data(contentsOf: url!){
                        DispatchQueue.main.async(execute: { () -> Void in
                        // Before we assign the image, check whether the current cell is visible
                        let img:UIImage! = UIImage(data: data)
                            cell.displayImageView.image = img
                            cell.indicator.stopAnimating()
                            self.imageCache .setObject(img, forKey: imageName! as NSString)
                    })
                    }
                    })
                    self.task.resume()
                    }
                  
                }
             
            }
    
            return cell
       }
    
   func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // return UITableView.automaticDimension
        
       
            return 310
    
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
       
       return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.isUserInteractionEnabled = false
        header.backgroundColor = UIColor.clear
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
         if displayArray.count > 0 {
            

            
            let viewController: DisplayFullViewController = DisplayFullViewController()

            
                  viewController.displayModel = displayArray[indexPath.row] as! DisplayDataModel
                  
                  self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    func addIndicator() -> Void{
       indicator = UIActivityIndicatorView(style: .large)
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = view.center
        indicator.color = .lightGray
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)

    }
    
    func sortByKey() -> Void{
        
        var filterName = ""
        if selectedFilter == Filters.imageFilter {
            filterName = "image"
        }else if selectedFilter == Filters.textFilter{
            filterName = "text"

        }
        var mySortedArray = [Any]()
        if displayArray.count > 0 {
             mySortedArray = displayArray.sorted(by: {(obj1, obj2)  -> Bool in
                
                return ((obj1 as! DisplayDataModel).type == filterName)
            })
        }
        displayArray = mySortedArray
        if filterName == "" {
            displayArray = unsortedArray
        }
        self.tableView .reloadData()
        print(mySortedArray)


    }
    
    enum Filters {
        case clearFilter
        case imageFilter
        case textFilter
    }
}

