//
//  TabController.swift
//  vipaji
//
//  Created by Mickey on 1/29/18.
//  Copyright © 2018 Mickey. All rights reserved.
//

import UIKit

class RootTabViewController: UIViewController {

    @IBOutlet var ButtonTabs: [UIButton]!
    
    var homeViewController : UIViewController!
    var discoverViewController : UIViewController!
    var uploadViewController : UIViewController!
    var bellViewController : UIViewController!
    var pofileViewController : UIViewController!
    
    @IBOutlet weak var contentView: UIView!
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let discoverStoryboard = UIStoryboard(name: "Discover", bundle: nil)
        let uploadStoryboard = UIStoryboard(name: "Upload", bundle: nil)
        let bellStoryboard = UIStoryboard(name: "Bell", bundle: nil)
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        
        homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
        discoverViewController = discoverStoryboard.instantiateViewController(withIdentifier: "DiscoverViewController")
        uploadViewController = uploadStoryboard.instantiateViewController(withIdentifier: "UploadViewController")
        bellViewController = bellStoryboard.instantiateViewController(withIdentifier: "BellViewController")
        pofileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileViewController")
        
        viewControllers = [homeViewController, discoverViewController, uploadViewController, bellViewController, pofileViewController]
        
        ButtonTabs[selectedIndex].isSelected = true
        didPressTab(ButtonTabs[selectedIndex])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressTab(_ sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        ButtonTabs[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)
        
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        
        vc.didMove(toParentViewController: self)
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
