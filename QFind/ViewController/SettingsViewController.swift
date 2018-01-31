//
//  SettingsViewController.swift
//  QFind
//
//  Created by Exalture on 22/01/18.
//  Copyright © 2018 QFind. All rights reserved.
//

import Alamofire
import UIKit

class SettingsViewController: MirroringViewController,SearchBarProtocol,BottomProtocol,predicateTableviewProtocol {

    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var arabicButton: UIButton!
    @IBOutlet weak var arabicButtonLabel: UILabel!
    @IBOutlet weak var settingsSearchBar: SearchBarView!
    @IBOutlet weak var settingsBottomBar: BottomBarView!
    @IBOutlet weak var selectLanguageLabel: UILabel!
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsLoadingView: LoadingView!
    var controller = PredicateSearchViewController()
    
    @IBOutlet weak var englishButtonLabel: UILabel!
    var predicateSearchKey = String()
    var predicateSearchArray : [PredicateSearch]? = []
    override func viewDidLoad() {
        super.viewDidLoad()

        setUILayout()
         setRTLSupportForSttings()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        setLocalizedVariablesForSettings()
        settingsBottomBar.favoriteview.backgroundColor = UIColor.white
        settingsBottomBar.historyView.backgroundColor = UIColor.white
        settingsBottomBar.homeView.backgroundColor = UIColor.white
        settingsSearchBar.searchText.text = ""
    }
    func setUILayout()
    {
        self.englishButton.layer.masksToBounds = false;
        self.englishButton.layer.shadowOffset = CGSize(width: -1, height: 15)
        self.englishButton.layer.shadowRadius = 5;
        self.englishButton.layer.shadowOpacity = 0.5;
        
        self.arabicButton.layer.masksToBounds = false;
        self.arabicButton.layer.shadowOffset = CGSize(width: -1, height: 15)
        self.arabicButton.layer.shadowRadius = 5;
        self.arabicButton.layer.shadowOpacity = 0.5;
        
        
        settingsSearchBar.searchDelegate = self
        settingsBottomBar.bottombarDelegate = self
         controller  = (storyboard?.instantiateViewController(withIdentifier: "predicateId"))! as! PredicateSearchViewController
    }
    func setRTLSupportForSttings()
    {
        if #available(iOS 9.0, *) {
            let attribute = view.semanticContentAttribute
            let layoutDirection = UIView.userInterfaceLayoutDirection(for: attribute)
            if layoutDirection == .leftToRight {
                
                settingsSearchBar.searchText.textAlignment = .left
            }
            else{
                
                settingsSearchBar.searchText.textAlignment = .right
            }
        } else {
            // Fallback on earlier versions
        }
        
        
        
    }
    func setLocalizedVariablesForSettings()
    {
         self.settingsLabel.text = NSLocalizedString("Settings", comment: "Settings Label in the Settings page").uppercased()
        self.selectLanguageLabel.text = NSLocalizedString("Select_language", comment: "Select_language Label in the Settings page")
        self.englishButtonLabel.text = NSLocalizedString("ENGLISH", comment: "ENGLISH BUTTON LABEL in the Settings page")
         self.arabicButtonLabel.text = NSLocalizedString("Arabic", comment: "Arabic button label in the Settings page")
        
    }
    @IBAction func didTapEnglish(_ sender: UIButton) {
        if ((LocalizationLanguage.currentAppleLanguage()) == "en") {

            let alert = UIAlertController(title: "Alert", message: "Sorry. current language is English", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
        else {
            LocalizationLanguage.setAppleLAnguageTo(lang: "en")
            languageKey = 1
            if #available(iOS 9.0, *) {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                 self.dismiss(animated: false, completion: nil)
            } else {
                // Fallback on earlier versions
            }
            
        }
       

    }
    
    @IBAction func didTapArabic(_ sender: UIButton) {
        if ((LocalizationLanguage.currentAppleLanguage()) == "en") {
        LocalizationLanguage.setAppleLAnguageTo(lang: "ar")
            languageKey = 2
            if #available(iOS 9.0, *) {
                                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                self.dismiss(animated: false, completion: nil)
                            } else {
                                // Fallback on earlier versions
                            }
    }
    else {
   // LocalizationLanguage.setAppleLAnguageTo(lang: "en")
            let alert = UIAlertController(title: "Alert", message: "Sorry. current language is Arabic", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
       
    }
    func favouriteButtonPressed() {
        settingsBottomBar.favoriteview.backgroundColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        let historyVC : HistoryViewController = storyboard?.instantiateViewController(withIdentifier: "historyId") as! HistoryViewController
        
        historyVC.pageNameString = PageName.favorite
        self.present(historyVC, animated: false, completion: nil)
    }
    func homebuttonPressed() {
      
        settingsBottomBar.homeView.backgroundColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    func historyButtonPressed() {
        settingsBottomBar.historyView.backgroundColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        
        let historyVC : HistoryViewController = storyboard?.instantiateViewController(withIdentifier: "historyId") as! HistoryViewController
        
        historyVC.pageNameString = PageName.history
        self.present(historyVC, animated: false, completion: nil)
    }
     //MARK:Searchbar
    func searchButtonPressed() {
        controller.view.removeFromSuperview()
        let historyVC : HistoryViewController = storyboard?.instantiateViewController(withIdentifier: "historyId") as! HistoryViewController
        
        historyVC.pageNameString = PageName.searchResult
        self.present(historyVC, animated: false, completion: nil)
    }
    func textField(_ textField: UITextField, shouldChangeSearcgCharacters range: NSRange, replacementString string: String) -> Bool {
        
        
        
        predicateSearchKey = textField.text! + string
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92){
            predicateSearchKey = String(predicateSearchKey.characters.dropLast())
            
        }
        
        if ((predicateSearchKey.count) >= 2)
        {
            
            
            controller.view.tag = 1
            
            controller.predicateProtocol = self
            self.controller.view.frame = CGRect(x: self.settingsSearchBar.searchInnerView.frame.origin.x, y:self.settingsSearchBar.searchInnerView.frame.origin.y+self.settingsSearchBar.searchInnerView.frame.height+20, width: self.settingsSearchBar.searchInnerView.frame.width, height: CGFloat((self.predicateSearchArray?.count)!*50))
            addChildViewController(controller)
            view.addSubview((controller.view)!)
            controller.didMove(toParentViewController: self)
            
            
            getPredicateSearchFromSettings()
            
            
        }
        else{
            controller.view.removeFromSuperview()
        }
        return true
    }
    
    //MARK:TableView
    func tableView(_ tableView: UITableView, numberOfSearchRowsInSection section: Int) -> Int {
        return (predicateSearchArray?.count)!
    }
    func tableView(_ tableView: UITableView, cellForSearchRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PredicateCell = tableView.dequeueReusableCell(withIdentifier: "predicateCellId") as! PredicateCell!
        let predicatedict = predicateSearchArray![indexPath.row]
        cell.setPredicateCellValues(cellValues: predicatedict)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectSearchRowAt indexPath: IndexPath) {
        let predicatedict = predicateSearchArray![indexPath.row]
        settingsSearchBar.searchText.text = predicatedict.search_name
        controller.view.removeFromSuperview()
          let historyVC : HistoryViewController = storyboard?.instantiateViewController(withIdentifier: "historyId") as! HistoryViewController
        
        historyVC.pageNameString = PageName.searchResult
        historyVC.predicateSearchdict = predicatedict
        self.present(historyVC, animated: false, completion: nil)
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    func getPredicateSearchFromSettings()
    {
        
        
        if let tokenString = tokenDefault.value(forKey: "accessTokenString")
        {
            
            Alamofire.request(QFindRouter.getPredicateSearch(["token": tokenString,
                                                              "search_key": predicateSearchKey , "language" :languageKey]))
                .responseObject { (response: DataResponse<PredicateSearchData>) -> Void in
                    switch response.result {
                        
                    case .success(let data):
                        
                        self.predicateSearchArray = data.predicateSearchData
                        self.controller.predicateSearchTable.reloadData()
                        self.controller.view.frame = CGRect(x: self.settingsSearchBar.searchInnerView.frame.origin.x, y:self.settingsSearchBar.searchInnerView.frame.origin.y+self.settingsSearchBar.searchInnerView.frame.height+20, width: self.settingsSearchBar.searchInnerView.frame.width, height: CGFloat((self.predicateSearchArray?.count)!*50))
                        
                        
                    case .failure(let error):
                        self.settingsLoadingView.isHidden = false
                        self.settingsLoadingView.stopLoading()
                        self.settingsLoadingView.noDataView.isHidden = false
                    }
                    
            }
            
        }
    }
   

}
