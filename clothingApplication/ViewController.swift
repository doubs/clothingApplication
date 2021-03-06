//
//  ViewController.swift
//  clothingApplication
//
//  Created by User on 2017/02/20.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // インスタンス配列
    var controllerArray : [UIViewController] = []
    var pageMenu : CAPSPageMenu?
    
    // サイト情報
    let category:[Dictionary<String,String>] = [
        
        ["title":"トップス","storyboardID":"topsViewController"],
        ["title":"パンツ","storyboardID":"pantsViewController"],
        ["title":"ジャケット","storyboardID":"jktViewController"],
        ["title":"アウター","storyboardID":"outerViewController"],
        ["title":"シューズ","storyboardID":"outerViewController"],
        ["title":"キャップ","storyboardID":"capViewController"],
        ["title":"その他","storyboardID":"komonoViewController"]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        for site in category {
            
            let storyboardID:String = site["storyboardID"]!
            switch storyboardID{
            
            case "topsViewController":
                let controller:TopsViewController = self.storyboard?.instantiateViewController(withIdentifier: "topsViewController") as! TopsViewController
                
                controller.title = site["title"]!
                controllerArray.append(controller)
            case "pantsViewController":
                let controller:PantsViewController = self.storyboard?.instantiateViewController(withIdentifier: "pantsViewController") as! PantsViewController
                controller.title = site["title"]!
                controllerArray.append(controller)
            case "jktViewController":
                let controller:jktViewController = self.storyboard?.instantiateViewController(withIdentifier: "jktViewController") as! jktViewController
                
                controller.title = site["title"]!
                controllerArray.append(controller)

            case "outerViewController":
                let controller:outerViewController = self.storyboard?.instantiateViewController(withIdentifier: "outerViewController") as! outerViewController
                
                controller.title = site["title"]!
                controllerArray.append(controller)
                
            case "shoesViewController":
                let controller:shoesViewController = self.storyboard?.instantiateViewController(withIdentifier: "shoesViewController") as! shoesViewController
                
                controller.title = site["title"]!
                controllerArray.append(controller)
                
            case "capViewController":
                let controller:capViewController = self.storyboard?.instantiateViewController(withIdentifier: "capViewController") as! capViewController
                
                controller.title = site["title"]!
                controllerArray.append(controller)
    
                
            case "komonoViewController":
                let controller:komonoViewController = self.storyboard?.instantiateViewController(withIdentifier: "komonoViewController") as! komonoViewController
                
                controller.title = site["title"]!
                controllerArray.append(controller)
                


            default:
                let controller :ContentsViewController = ContentsViewController(nibName: "ContentsViewController", bundle: nil)
                controller.title = site["title"]!
                
                controller.webView = UIWebView(frame : self.view.bounds)
                //controller.webView.delegate = controller
                controller.view.addSubview(controller.webView)
                //let req = URLRequest(url: URL(string:controller.siteUrl!)!)
                // controller.webView.loadRequest(req)
                controllerArray.append(controller)
                
                
            }
            
            //controller.siteUrl = site["url"]!
            
            
            
        }
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.black),
            .viewBackgroundColor(UIColor.white),
            .bottomMenuHairlineColor(UIColor.white),
            .selectionIndicatorColor(UIColor.blue),
            .menuItemFont(UIFont(name: "HelveticaNeue", size: 20.0)!),
            .centerMenuItems(true),
            .menuItemWidthBasedOnTitleTextWidth(true),
            .menuMargin(10),
            .selectedMenuItemLabelColor(UIColor.blue),
            .unselectedMenuItemLabelColor(UIColor.white)
            
        ]
        
        // Initialize scroll menu
        
        let rect = CGRect(origin: CGPoint(x: 0,y :60), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: rect, pageMenuOptions: parameters)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParentViewController: self)
        
    }
    

    
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
