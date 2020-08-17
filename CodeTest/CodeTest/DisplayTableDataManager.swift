//
//  DisplayTableDataManager.swift
//  CodeTest
//
//  Created by Gaurav Bangad on 13/08/20.
//  Copyright © 2020 Gaurav Bangad. All rights reserved.
//

enum Type {
    case TextType
    case ImageType
}

import UIKit

class DisplayTableDataManager: NSObject {
    
    let myJsonString = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    
    func isFilePresentInDocumentDirectory() -> Bool{
        let fileManager = FileManager.default
             
        if fileManager.fileExists(atPath: getLibaryDirectoryPathForFile(fileName: "display.json")){
            return true
        }
        return false
    }
    
    func saveFile(closure:@escaping ([DisplayDataModel])->Void) -> Void {
     

        if isFilePresentInDocumentDirectory() {
            var displayObjects = [DisplayDataModel]()

            do {
                let data = try Data.init(contentsOf:URL.init(fileURLWithPath: self.getLibaryDirectoryPathForFile(fileName: "display.json")))
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])as? [[String : Any]]
                
                if let displayDictionariesObject = json{
                    for item in displayDictionariesObject{
                        
                        let dataModel:DisplayDataModel =  DisplayDataModel.init(dictionary:item)
                        
                        displayObjects.append(dataModel)
                    }
                    closure(displayObjects)
                }
                
                print()
            }
            catch{
                print("Error fetching from ")
            }
            
        }else{
                fetchDataFromUrl { (model) in
                    print(model)
                    
                    let filePath =  URL.init(fileURLWithPath: self.getLibaryDirectoryPathForFile(fileName: "display.json"))
                    do {
                               let data = try JSONSerialization.data(withJSONObject: model, options: [])
                            try data.write(to: filePath.absoluteURL, options: [])
                             print("File save successfully")
                            var displayObjects = [DisplayDataModel]()

                            //  if let displayDictionariesObject = model ! {

                              for item in (model as?[Any])!{
                            
                                let dataModel:DisplayDataModel =  DisplayDataModel.init(dictionary:item as! [String : Any])
                                   
                                    displayObjects.append(dataModel)
                                  }
                              closure(displayObjects)
                           } catch {
                               print(error)
                           }
              //      }
                }
            }
    }
    
        private func getdocumentDirectory() -> String {
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        return documentDirectory[0]
    }
    
    private func getLibaryDirectoryPathForFile(fileName:String) -> String {
        let path = getdocumentDirectory()
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(fileName)
            
            return pathURL.absoluteString
        }
        else{
            return ""
        }
    }
    
    func fetchDataFromUrl(completionHandler: @escaping (Any) -> Void) {
        let url = URL.init(string:myJsonString)
      let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
        if let error = error {
          print("Error with fetching films: \(error)")
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          print("Error with the response, unexpected status code: \(response)")
          return
        }
        if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []){
            print(json)
            completionHandler(json)
        }
   
      })
      task.resume()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
