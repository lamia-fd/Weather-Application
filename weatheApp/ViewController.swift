//
//  ViewController.swift
//  weatheApp
//
//  Created by لمياء فالح الدوسري on 17/05/1443 AH.
//

import UIKit
import Foundation


class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    

    
    @IBOutlet weak var maxTmp: UILabel!
    @IBOutlet weak var avgTmp: UILabel!
    @IBOutlet weak var minTmp: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var cloud: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var collect1: UICollectionView!
    @IBOutlet weak var collect2: UICollectionView!
    
    
    
    var maxTmpText = ""
   var avgTmpText = ""
    var minTmpText = ""
    var windSpeedText = ""
    var humidityText = ""
     var cloudText = ""
     var feelsLikeText = ""
   
    let url =  URL(string:"https://api.openweathermap.org/data/2.5/weather?q=riyadh&appid=b89dd02047e82447ca0a27b9c0e1ec03")
    
   let days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
   let tims = ["1 AM","2 AM","3 AM","4 AM","5 AM","6A M","7 AM","8 AM","9 AM","10 AM"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let hour = dateFormatter.string(from: date)
        
        time.text! += hour
 
        print(hour)

        
        APIreq2{ [self] in
            print("works")
            
            maxTmp.text = maxTmpText
            avgTmp.text = avgTmpText
            minTmp.text = minTmpText
       
            windSpeed.text! += windSpeedText
            humidity.text! += humidityText
            cloud.text! += cloudText
            feelsLike.text! += feelsLikeText

            
        }
        
        
        
        
        
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collect1{
            return tims.count
        }
        
            
        return days.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == collect1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! cellCollectionViewCell
         
            
            cell.lable1.text = tims[indexPath.row]
         return cell
           
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! cellCollectionViewCell
        cell.lable2.text = days[indexPath.row]
    
               return cell
    }
   
    
   
    


    
    
    
    func APIreq2(completed: @escaping () ->()){
        
        
        URLSession.shared.dataTask(with: url!){
                (data,respone, error) in
                if error == nil{
                    do{
                   let re:APIRespose = try JSONDecoder().decode(APIRespose.self, from: data!)
                        print("ooooooooooooooo")
                        print(re.weather[0].main)
                        print(re.weather[0].description)
                        print(re.main.temp_min)
                        print(re.main.temp_max)
                        print(re.main.temp)
                        print(re.main.feels_like)
                        
                        self.maxTmpText = "\(re.main.temp_max)"
                        self.avgTmpText = "\(re.main.temp)"
                        self.minTmpText = "\(re.main.temp_max)"
                        self.feelsLikeText = "\(re.main.feels_like)"
                        self.humidityText = "\(re.main.humidity)"
                        self.windSpeedText = "\(re.wind.speed)"
                        
                      
                        print("ooooooooooooooo")
    //
                            
                            
                        
                        
                        
                        DispatchQueue.main.sync {
                            completed()
                        }
                        
                    }catch{
                        print("json error")
                    }
                }
            }.resume()
            
            
            
            
        }
    

}

struct APIRespose:Decodable{
    let name:String
    let main:APIMain
    let weather:[APIWeather]
    let wind:Speed
}
struct APIMain:Decodable {
    let temp:Double
   let temp_max:Double
   let temp_min:Double
let feels_like:Double
    let humidity:Int
}
struct Speed:Decodable{
    let speed:Double
}
struct APIWeather:Decodable{

    let description:String
   let icon:String
    let main:String


}



//{
//"coord":{
//    "lon":46.7219,"lat":24.6877},"weather":[
//        {
//            "id":800,"main":"Clear","description":"clear sky","icon":"01n"
//
//        }
//    ],"base":"stations","main":{
//        "temp":289.23,"feels_like":287.76,"temp_min":289.23,"temp_max":289.23,"pressure":1021,"humidity":33,"sea_level":1021,"grnd_level":951
//
//    },"visibility":10000,"wind":{"speed":5.77,"deg":8,"gust":9.48
//
//    },"clouds":{
//        "all":0
//
//    },"dt":1640114175,"sys":{
//        "type":1,"id":7424,"country":"SA","sunrise":1640057585,"sunset":1640095754
//
//    },"timezone":10800,"id":108410,"name":"Riyadh","cod":200
//
//}
