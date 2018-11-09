//
//  APIRequests.swift
//  
//
//  Created by Sepand Yadollahifar on 7/12/18.
//  Copyright © 2018 3p. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import MapKit

class APIRequests {
    
    private var baseURL = ""
    private let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    
    private func isInternetConnectionAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    private func sendGetRequest(in viewController: UIViewController, to baseURL: String?, withEndpoint urlString: String, shouldDisplayActivityIndicator showActivityIndicator: Bool, token: String?, completionHandler: @escaping ([String: Any]?) -> Void) {
        
        if !self.isInternetConnectionAvailable() {
            
            let Alert = UIAlertController(title: "خطا", message: "از دسترسی اپ به اینترنت اطمینان حاصل فرمایید.", preferredStyle: UIAlertController.Style.alert)
            Alert.addAction(UIAlertAction(title: "باشه", style: UIAlertAction.Style.default, handler: { (action) in
                switch action.style {
                case .default:
                    return
                case .cancel:
                    print("cancel")
                    return
                case .destructive:
                    print("destructive")
                    return
                }
            }))
            viewController.present(Alert, animated: true) {
                print("informed user of no connection to the internet state")
            }
            
            return
        } else {
            
            var bURL = self.baseURL
            
            if let _ = baseURL {
                
                bURL = baseURL!
            }
            
            
            var activityIndicator = UIView()
            
            if showActivityIndicator {
                
                activityIndicator = UIViewController.displayActivityIndicator(onView: viewController.view)
            }
            
            let Url = URL(string: "\(bURL)\(urlString)")
            var request = URLRequest(url: Url!)
            
            if let authenticationToken = token {
                
                request.addValue("Bearer \(authenticationToken)", forHTTPHeaderField: "Authorization")
            }
            
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in
                
                DispatchQueue.main.async {
                    
                    if showActivityIndicator {
                        
                        UIViewController.removeActivityIndicator(activityIndicator: activityIndicator)
                    }
                    
                    guard let data = data, error == nil else {
                        // check for fundamental networking error
                        print("error=\(error.debugDescription)")
                        
                        let Alert = UIAlertController(title: "خطا", message: "موفق به ارسال درخواست شما نشدیم لطفا بعد از چند لحظه مجددا تلاش کنید.", preferredStyle: UIAlertController.Style.alert)
                        Alert.addAction(UIAlertAction(title: "باشه", style: UIAlertAction.Style.default, handler: { (action) in
                            switch action.style {
                            case .default:
                                return
                            case .cancel:
                                print("cancel")
                                return
                            case .destructive:
                                print("destructive")
                                return
                            }
                        }))
                        viewController.present(Alert, animated: true) {
                            print("informed user of no connection to the internet state")
                        }
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                        // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response.debugDescription)")
                    }
                    
                    let responseString = String(data: data, encoding: .utf8)
                    print("API -> \(urlString): responseString = \(responseString.debugDescription)")
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        completionHandler(json)
                    } catch {
                        print("error trying to convert data to JSON")
                        //print(error)
                        completionHandler(nil)
                    }
                }
                
            })
            task.resume()
        }
    }
    
    private func sendPostRequest(in viewController: UIViewController, to baseURL: String?, toEndPoint urlString: String, with postString: String, shouldDisplayActivityIndicator showActivityIndicator: Bool, token: String?, completionHandler: @escaping ([String: Any]?) -> Void) {
        
        if !self.isInternetConnectionAvailable() {
            
            let Alert = UIAlertController(title: "خطا", message: "از دسترسی اپ به اینترنت اطمینان حاصل فرمایید.", preferredStyle: UIAlertController.Style.alert)
            Alert.addAction(UIAlertAction(title: "باشه", style: UIAlertAction.Style.default, handler: { (action) in
                switch action.style {
                case .default:
                    return
                case .cancel:
                    print("cancel")
                    return
                case .destructive:
                    print("destructive")
                    return
                }
            }))
            viewController.present(Alert, animated: true) {
                print("informed user of no connection to the internet state")
            }
            
            
            return
        } else {
            
            var bURL = self.baseURL
            
            if let _ = baseURL {
                
                bURL = baseURL!
            }
            
            var activityIndicator = UIView()
            if showActivityIndicator {
                
                activityIndicator = UIViewController.displayActivityIndicator(onView: viewController.view)
            }
            let Url = URL(string: "\(bURL)\(urlString)")
            var request = URLRequest(url: Url!)
            request.httpMethod = "POST"
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            if let authenticationToken = token {
                
                request.addValue("Bearer \(authenticationToken)", forHTTPHeaderField: "Authorization")
            }
            
            request.httpBody = postString.data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in
                
                DispatchQueue.main.async {
                    
                    if showActivityIndicator {
                        
                        UIViewController.removeActivityIndicator(activityIndicator: activityIndicator)
                    }
                    guard let data = data, error == nil else {
                        // check for fundamental networking error
                        print("error=\(error.debugDescription)")
                        
                        let Alert = UIAlertController(title: "خطا", message: "موفق به ارسال درخواست شما نشدیم لطفا بعد از چند لحظه مجددا تلاش کنید.", preferredStyle: UIAlertController.Style.alert)
                        Alert.addAction(UIAlertAction(title: "باشه", style: UIAlertAction.Style.default, handler: { (action) in
                            switch action.style {
                            case .default:
                                return
                            case .cancel:
                                print("cancel")
                                return
                            case .destructive:
                                print("destructive")
                                return
                            }
                        }))
                        viewController.present(Alert, animated: true) {
                            print("informed user of no connection to the internet state")
                        }
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                        // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response.debugDescription)")
                    }
                    
                    let responseString = String(data: data, encoding: .utf8)
                    print("API -> \(urlString): responseString = \(responseString.debugDescription)")
                    
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        completionHandler(json)

                    } catch {
                        print("error trying to convert data to JSON")
                        //print(error)
                        completionHandler(nil)
                    }
                }
            })
            task.resume()
        }
    }
    
    
}
