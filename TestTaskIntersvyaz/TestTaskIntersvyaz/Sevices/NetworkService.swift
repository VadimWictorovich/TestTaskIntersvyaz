//
//  NetworkService.swift
//  TestTaskIntersvyaz
//
//  Created by Вадим Игнатенко on 15.04.24.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

 
final class NetworkService {
    
    static func fetchPhotos(callback: @escaping (_ result: [PhotoModel]?, _ error: Error?) -> ()) {
        guard let url = APIProperties.photosURL else { return }
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .response { response in
                var value: [PhotoModel]?
                var err: Error?
                
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(value, err)
                        return }
                    do {
                        value = try JSONDecoder().decode([PhotoModel].self, from: data)
                    } catch (let decoderError) {
                        callback(value, decoderError)
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
            }
    }
    
     
     static func getThumbnail(thumbnailURL: String, callback: @escaping (_ result: UIImage?, _ error: AFError?) -> ()) {
         if let image = CacheManager.shared.imageCache.image(withIdentifier: thumbnailURL) {
             callback(image, nil)
         } else {
             AF.request(thumbnailURL).responseImage { response in
                 switch response.result {
                 case .success(let image):
                     CacheManager.shared.imageCache.add(image, withIdentifier: thumbnailURL)
                     callback(image, nil)
                 case .failure(let error):
                     callback(nil, error)
                 }
             }
         }
     }
     

     static func downloadImage(from url: URL, callback: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
         getData(from: url) { data, response, error in
             if let data, let image = UIImage(data: data) {
                 callback(image, nil)
             } else {
                 callback(nil, error)
             }
         }
    }
    
    
    static func getData(from url: URL, complition: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: complition).resume()
    }
}
