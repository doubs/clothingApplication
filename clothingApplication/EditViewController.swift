//
//  EditViewController.swift
//  clothingApplication
//
//  Created by User on 2017/02/14.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit
import CoreData
import Photos
class EditViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate{

    @IBOutlet weak var editImage: UIImageView!
    
    @IBOutlet weak var dateField: UITextField!
    
    @IBOutlet weak var clotheField: UITextField!
    
    @IBOutlet weak var categoryField: UITextField!
    
    @IBOutlet weak var blandField: UITextField!
    
    @IBOutlet weak var sizeField: UITextField!
    
    @IBOutlet weak var priceField: UITextField!
    
    @IBAction func tapBack(_ sender: UIButton) {
        let next = storyboard!.instantiateViewController(withIdentifier: "ViewController")
        self.present(next,animated: true, completion: nil)
        
    }
    
   
    
    //セグエ遷移(横から画面が出る)
    @IBAction func tapBackSegue(_ sender: UIButton) {
        performSegue(withIdentifier: "ViewController", sender: nil)
        
    }
    
    var selectedImg: String!
    var strURL: String!
    var photlist:[NSDictionary] = NSArray() as! [NSDictionary]
    var selectedCD: String!
    var selectedDate: NSDate = NSDate()
    
    
    @IBOutlet weak var formView: UIView!
    
    //datePickerを載せるView
    let baseView:UIView = UIView(frame: CGRect(x:0,y:720,width:200,height:250))
    
    //datePicker(日付編集時)
    let diaryDatePicker:UIDatePicker = UIDatePicker(frame: CGRect(x:10,y:20, width:300,height:250))
    
    //datePickerを隠すためのボタン
    let closeBtnDatePicker:UIButton = UIButton(type: .system)
    
    var photList = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photList = [["phot":"noimages.png"],["clothename":"黒パーカー"],["size":"S"],["blandname":"ユニクロ"],["date":"2017/02/21"],["category":"パーカー"],["price":"1200"]]
        
        
        //日付が変わったときのイベントをdatePickerに設定
        diaryDatePicker.addTarget(self, action: #selector(showDateSelected(sender:)), for: .valueChanged)
        
        //baseViewにdatePickerを配置
        baseView.addSubview(diaryDatePicker)
        
        //位置、大きさを決定
        closeBtnDatePicker.frame = CGRect(x:self.view.frame.width - 60,y:0 ,width:50,height: 20)
        //タイトルの設定
        closeBtnDatePicker.setTitle("close",for: .normal)
        //イベントの追加
        closeBtnDatePicker.addTarget(self,action: #selector(closeDatePickerView),for: .touchUpInside)
        //viewに追加
        baseView.addSubview(closeBtnDatePicker)
        //下にぴったり配置、横幅ぴったりの大きさにしておく
        //位置
        baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)
        //横幅
        baseView.frame.size = CGSize(width: self.view.frame.width, height: baseView.frame.height)
        
        //背景色Grayにセット
        baseView.backgroundColor = UIColor.gray
        
        //画面に追加
        self.view.addSubview(baseView)
        
        //キーボードの上に「閉じる」ボタンを配置
        //ビューを作成
        let upView = UIView()
        upView.frame.size.height = 60//高さ配置
        upView.backgroundColor = UIColor.lightGray
        
        //閉じるボタンを作成
        let closeButton = UIButton(frame: CGRect(x: self.view.bounds.width - 70,y:0,width: 70,height: 50))
        closeButton.setTitle("閉じる", for: .normal)
        
        //閉じるボタンにイベントを設定
        closeButton.addTarget(self ,action: #selector(closeKeyboad(sender:)), for: .touchUpInside)
        
        //ビューに閉じるボタンを追加
        upView.addSubview(closeButton)
        //キーボードのアクセサリービューを設定する
        blandField.inputAccessoryView = upView
        clotheField.inputAccessoryView = upView
        sizeField.inputAccessoryView = upView
        priceField.inputAccessoryView = upView
        
       
        
        read()
    }
    
    //textFieldにカーソルが当たったとき(入力開始)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing 発動された")
        print(textField.tag)
        
        //TODO:キーボード、日付のViewを閉じる
        //キーボード
        blandField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
        })
        
        clotheField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
        })
        
        sizeField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
        })
        
        priceField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
        })



        
        //日付のview
        hideDatePickerView()
       switch textField.tag{
       case 1:
           //タイトル
            //キーボード表示
            return true
       case 2:
            return true
       case 3:
            return true
       case 4:
            return true
        
       case 5:
        disprayDatePickerView()
            return false
      // case 6: return false
        
        default:
            return true
            }
        
        return true
    }
    
    //DatePickerのviewを隠す
    func hideDatePickerView(){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y: self.view.frame.size.height)},completion:{finished in print("DatePickerを隠しました")})
    }
    
    //DatePickerのviewを表示する
    @IBAction func enterDate(_ sender: UITextField) {
    }
    func disprayDatePickerView(){
        UIView.animate(withDuration: 0.5,animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y: self.view.frame.size.height - self.baseView.frame.height)},completion:{finished in print("DatePickerが現れました")})
        
    }
    
    //DatePickerが載ったviewを隠す
    func closeDatePickerView(_sender:UIButton){UIView.animate(withDuration: 0.5,animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y: self.view.frame.size.height)
    },completion:{finished in print("DatePickerを隠しました")})
    }

    
    //DatePickerで選択している日付を変えたとき、日付用のTextFieldに値を表示
    func showDateSelected(sender:UIDatePicker){
        //フォーマット設定
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        //日付を文字列に変換
        var strSelectedDate = df.string(from:sender.date)
        //dateFieldに値を表示
        dateField.text = strSelectedDate
        
    }
    //キーボードを閉じる
    func closeKeyboad(sender:UIButton){
        blandField.resignFirstResponder()
        clotheField.resignFirstResponder()
        sizeField.resignFirstResponder()
        priceField.resignFirstResponder()
    
    }
    
    //すでに存在するデータの読み込み処理
    func read(){
        //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        //どのエンティティからdataを取得してくるか設定
       // let query: NSFetchRequest<UserDate> = UserDate.fetchRequest()
        
        do{
            //データを一括取得
            let query:NSFetchRequest<UserDate> = UserDate.fetchRequest()
            query.predicate = NSPredicate(format:"date = %@", selectedCD)
            let fetchResults = try viewContext.fetch(query)
            print("selectedCD=\(selectedCD)")
            //一旦配列を空にする(初期化)
            photlist = NSArray() as! [NSDictionary]
            for result : AnyObject in fetchResults{
                var photDate: String? = result.value(forKey: "phot") as? String
                var clothenameDate: String? = result.value(forKey: "clothename") as? String
                var sizeDate: String? = result.value(forKey:"size") as? String
                var blandDate: String? = result.value(forKey:"blandname") as? String
                var dateDate: String? = result.value(forKey:"date") as? String
                var categoryDate: String? = result.value(forKey:"category") as? String
                var changeDate: String? = result.value(forKey:"created_at") as? String
               // var priceDate: Int16? = result.value(forKey: "price") as? Int16
                
              photlist.append(["phot":editImage.image,"clothename":clotheField.text,"size":sizeField.text,"blandname":blandField.text,"date":dateField,"category":categoryField,])
           
                print("dateDate=\(dateDate)")
           //NewEditの登録内容読み込み
            dateField.text = "\(dateDate!)"
            clotheField.text = "\(clothenameDate!)"
            sizeField.text = "\(sizeDate!)"
        
                var AImage: UIImage!
                if photDate != nil{
                    
                    let url = URL(string: photDate as String!)
                    let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
                    let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
                    let manager: PHImageManager = PHImageManager()
                    manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                        AImage = image
                        self.strURL = photDate!
                    }
                    editImage.image = AImage
            }
            }
        }catch{
            
        }

    
    }
    
    
    
    

    @IBAction func tapImage(_ sender: UITapGestureRecognizer) {
    
    
       // 画像タップでライブラリを呼び出す
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            let picker = UIImagePickerController()
            picker.modalPresentationStyle = UIModalPresentationStyle.popover
            picker.delegate = self // UINavigationControllerDelegate と　UIImagePickerControllerDelegateを実装する
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            //トリミング
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
        }
    
        
    }
    
         //ライブラリで写真を選んだ後
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
        
        let strURL:String = assetURL.description
        
        print(strURL)
        
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        
        // データを書き込んで
        myDefault.set(strURL, forKey: "selectedPhotoURL")


        
        // 即反映させる
        myDefault.synchronize()
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
        
        if strURL != nil{
            
            let url = URL(string: strURL as String!)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                self.editImage.image = image
                
            }
            
        }

    }

    
    
    func launchCamera(_ sender: UIBarButtonItem) {
        //カメラかどうか判別するための情報を取得
        let camera = UIImagePickerControllerSourceType.camera
        //このアプリが起動されているデバイスにカメラ機能がついているかどうか判定
        if UIImagePickerController.isSourceTypeAvailable(camera){
            let picker = UIImagePickerController()
            picker.sourceType = camera
            
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.camera

            self.present(picker,animated: true, completion: nil)
        }
        //UserDefaultから取り出す
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        
        // データを取り出す
        let strURL = myDefault.string(forKey: "selectedPhotoURL")
        
        if strURL != nil{
            
            let url = URL(string: strURL as String!)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                self.editImage.image = image
            }
            
        }
        
    }
    
    //保存ボタンタップで追加
    @IBAction func tapBtn(_ sender: UIButton) {
        
        //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        //UserDateエンティティオブジェクトの作成
        let userDate = NSEntityDescription.entity(forEntityName:"UserDate",in:viewContext)
        
        
        //UserDefaultから取り出す
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        
        // データを取り出す
        let strURL = myDefault.string(forKey: "selectedPhotoURL")

        
//        if (dateField.text == "")&&(strURL == ""){
//            let alertController = UIAlertController(title: "保存", message: "保存しますか？", preferredStyle: .alert)
//            //OKボタンを追加
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.namePicOK() }))
//            //アラートを表示する（重要）
//            present(alertController, animated: true, completion: nil)
//        }else if strURL == ""{
//            let alertController = UIAlertController(title: "画像選択", message: "画像を選択して下さい。", preferredStyle: .alert)
//            //OKボタンを追加
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.picOK() }))
//            //アラートを表示する（重要）
//            present(alertController, animated: true, completion: nil)
//        }else if dateField.text == "" {
//            let alertController = UIAlertController(title: "日付入力", message: "日付を入力して下さい。", preferredStyle: .alert)
//            //OKボタンを追加
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.nameOK() }))
//            //アラートを表示する（重要）
//            present(alertController, animated: true, completion: nil)
//        }
        
//        if (dateField.text != "")&&(strURL != "" ){
//            
//           // let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//            //et viewContext = appDelegate.persistentContainer.viewContext
//          //  let userDate = NSEntityDescription.entity(forEntityName: "UserDate", in: viewContext)
            let date = Date()
            let df = DateFormatter()
           // df.timeZone = TimeZone.current
            df.dateFormat = "yyyy/MM/dd HH:mm:ss"
            let selectedDate = df.string(from: date)
            let changeDate = df.date(from: selectedDate)
//           // if (switchFlag){
//                //Update
                let request: NSFetchRequest<UserDate> = UserDate.fetchRequest()
                let strSavedDate: String = df.string(from: date)
                let savedDate :Date = df.date(from: strSavedDate)!
            do {
                  let namePredicte = NSPredicate(format: "created_at = %@", savedDate as CVarArg)
                   request.predicate = namePredicte
                   let fetchResults = try viewContext.fetch(request)
                    //登録された日付を元に1件取得　新しい値を入れる
                    for result: AnyObject in fetchResults {
                        let record = result as! NSManagedObject
       
                  //値のセット
        record.setValue(strURL, forKey: "phot") as? String
        record.setValue(clotheField.text, forKey: "clothename")
        record.setValue(sizeField.text, forKey: "size")
        record.setValue(blandField.text, forKey: "blandname")
        record.setValue(selectedDate, forKey: "date") as? String
        record.setValue(categoryField.text, forKey: "category")
        record.setValue(changeDate, forKey: "created_at") as? String
        //  newRecord.setValue(priceField.text, forKey: "price") as? Int16
                    }
            //レコードの即時保存
            try viewContext.save()
        }catch{
            
       }
    
        //CoreDateからdateを読み込む処理
        read()
            }
    
    
//    func nameOK(){
//        
//    }
//
//    func picOK(){
//        
//    }
//    func namePicOK(){
//        
//    }
    
    
    @IBAction func tapCancel(_ sender: UIButton) {
        //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<UserDate> = UserDate.fetchRequest()
        
            //削除するdateを取得
            let namePredicte = NSPredicate(format: "date = %@",selectedCD)
            request.predicate = namePredicte

            let fetchResults = try! viewContext.fetch(request)
            for result: AnyObject in fetchResults {
                let record = result as! NSManagedObject

                viewContext.delete(record)
                do{
                
                    try viewContext.save()}catch{
                }
        
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print(selectedDate)
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

