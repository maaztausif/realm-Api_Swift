//
//  ViewController.swift
//  Alomofire
//
//  Created by macbook on 16/02/2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import Realm
import RealmSwift


class ViewController: UIViewController {

    var name:String?
    var secondName:String?
    
    
    
    let realm = try! Realm()
    var categories: Results<category>?
    
//    let parameters : [String:String] = [
//    "name":"characters"
//    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("From did load")
        getData()
        print(Realm.Configuration.defaultConfiguration.fileURL)

        
        fetchFilms()

    }
    
    func fetchFilms() {
       // 1
//        Alamofire.Request()
        AF.request("https://swapi.dev/api/films",method: .get).responseString { response in
//            print("Response String: \(response.value!)")
            
            let wheatherJSON : JSON = JSON(response.value!)

            print("from json : \(wheatherJSON)")
            print("============================================================================")
            let json = try? JSON(data: response.data!)
            self.name = json!["results"][0]["title"].string
            self.secondName = json!["results"][0]["opening_crawl"].string
            print("name:\(self.name!)!")
            print("secondName:\(self.secondName!)")
//            sleep(4)

            self.saveGetrealm()

        }
        
     }
    
    func saveGetrealm(){
        let newCategory = category()
        newCategory.name = "\(name!)"
        newCategory.secondName = "\(secondName!)"
        //realm.add(newCategory)
        print("name ====== \(newCategory.name)")
        print("secindname ======= \(newCategory.secondName)")
        print("==================")
        categories = realm.objects(category.self)
        print("from get realm name: \(categories)")
//        save(category:newCategory)
        do {
            try! realm.write{
                realm.add(newCategory)
            print("===================================== saveGetrealm =========================================")

            }
        } catch  {
            print("error saving data")
        }
        
        

    }
    func getData(){
        categories = realm.objects(category.self)
        if categories![0] == nil{
            print("nothing in database")
        }else{
            print("from catogory : \(categories![0])")
print("===================================== get data =========================================")
        }
        

        
    }
   
}

