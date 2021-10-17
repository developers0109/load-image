//
//  NewsModel.swift
//  LoadImage JSON
//
//  Created by Edi Sunardi on 08/02/21.
//

import Foundation
import Combine
import SwiftyJSON

class NewsModel : ObservableObject {
    @Published var data = [News]()
    
    init() {
        
        let url = "https://api.rawg.io/api/games?key=2e70fca9ef5b41ff95bd76faa3746080"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            let items = json["results"].array!
            
            for i in items {
                
                let title = i["name"].stringValue
                
                let description = i["description"].stringValue
                
                let imurl = i["background_image"].stringValue
                
                let content = i["content"].stringValue
                
                DispatchQueue.main.async {
                    self.data.append(News(title: title, description: description, image: imurl, content: content))
                }
                
            }
            
        }.resume()
    }
    
}
