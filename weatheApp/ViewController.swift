//
//  ViewController.swift
//  weatheApp
//
//  Created by لمياء فالح الدوسري on 17/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    let url = "https://api.openweathermap.org/data/2.5/weather?q=riyadh&appid=b89dd02047e82447ca0a27b9c0e1ec03"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(from:url)
    }

    
    func getData(from url:String){
URLSession.shared.dataTask(with: URL(string: url)!, completionHandler:{data,response,error in
                guard let data = data, error == nil   else {
                    print("somthing wint wrong")
                    return}
    
    var result: APIRespose?
    do{
        result=try JSONDecoder().decode(APIRespose.self, from: data)
    }catch{
        print("faild to convert \(error.localizedDescription)")
    }
    guard let json = result else{
        return
    }
    print(json.weather)
    print(json.name)
    print(json.weather.description)

    print(json.main.temp)
    print(json.main.temp_max)
    print(json.main.temp_min)

}).resume()
    }

}

struct APIRespose:Decodable{
    let name:String
    let main:APIMain
    let weather:[APIWeather]
}
struct APIMain :Decodable{
    let temp:Double
   let temp_max:Double
   let temp_min:Double
}

struct APIWeather:Decodable{
    
    let descripion:String
    let iconName:String
    
    enum CodingKeys:String,CodingKey{
        case descripion
        case iconName = "mian"
    }
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
