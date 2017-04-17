

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var myContents: UITextView!
    @IBOutlet weak var myTitle: UITextField!
    @IBOutlet weak var myDate: UITextField!
    
    //datePickerが乗るView(下に隠しておく)
    let baseView:UIView = UIView(frame: CGRect(x:0, y:720, width:200, height:250))
    
    let diaryDatePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: 10, y:20, width:300, height:220))
    
    //datePicker隠すためのボタン
    let closeBtnDP:UIButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //datePickerのmodeを日付のみに設定
        diaryDatePicker.datePickerMode = UIDatePickerMode.date
        
        //datePIckerの日付が選択された時に発動するイベントを追加
           //順番は後
        diaryDatePicker.addTarget(self, action: #selector(showDateSelected(sender:)), for: .valueChanged)
        //#順番を指定できる
        
        //baseViewにdatePickerを配置
        baseView.addSubview(diaryDatePicker)
        
    //closeBtnDPを配置
        //位置、大きさを決定
        closeBtnDP.frame = CGRect(x: self.view.frame.width - 60, y:  0, width:  50, height: 20)
        
        //タイトルの設定
        closeBtnDP.setTitle("Close", for: .normal)
        
        //イベントの追加
        //TODO:後ほど
        closeBtnDP.addTarget(self, action: #selector(closeDatePicker(sender:)), for: .touchUpInside)
        
        //baseViewにcloseBtnDPを配置
        baseView.addSubview(closeBtnDP)
        
        
        //baseViewを下にぴったり配置、横幅ぴったりの大きさにしておく
        baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height)
        baseView.frame.size = CGSize(width: self.view.frame.size.width, height: baseView.frame.height)
        
        //baseViewに背景色をつける
        baseView.backgroundColor = UIColor.gray
        
        //元の画面に追加
        self.view.addSubview(baseView)
        
    
    }
    //タグ1,2つける
    //カーソルが当たった時と判別する為

    @IBAction func tapClose(_ sender: UIButton) {
        
        myContents.resignFirstResponder()
    }
 
    //タイトルのキーボードでリターンが押された時
    @IBAction func tapReturn(_ sender: UITextField) {
    }
    
    //テキストフィールド入力開始
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        print("textFieldShouldBeginEditing")
        
        print(textField.tag)
        
        switch textField.tag{
        case 1:
            //タイトルのtextfield
            //キーボードを表示する(通常表示)
            return true
        case 2:
            //日付のtextfield
            //baseViewの表示
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                
                self.baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height - self.baseView.frame.height)
                
            })
            //キーボードを出さないようにする
            return false
        default:
            return true

        }
        
        return true
        //if文が作れるよ
    }
    
    //DatePickerで選択してる日付を変えた時、日付のTextFieldに値を表示
    func showDateSelected(sender:UIDatePicker){
        
        //フォーマットを設定
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        //"yyyy-MM-dd" also ok
        
        //日付を文字列に変換
        let strSelectedDate =  df.string(from: sender.date)
        
        //TextFieldに値を表示
        myDate.text = strSelectedDate
        
    
    }
    
    //DatePickerが乗ったviewを隠す
    func closeDatePicker(sender:UIButton){
        UIView.animate(withDuration: 0.5, animations: {()
            -> Void in self.baseView.frame.origin = CGPoint(x: 0, y: self.view.bounds.height)
    
            
            })
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }


}

