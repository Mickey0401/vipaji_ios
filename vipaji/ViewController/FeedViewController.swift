//
//  HomeViewController.swift
//  vipaji
//
//  Created by Mickey on 1/29/18.
//  Copyright © 2018 Mickey. All rights reserved.
//

import UIKit
import AVFoundation

class FeedViewCell: UITableViewCell {
    @IBOutlet weak var AuthorView: UIStackView!
    @IBOutlet weak var AuthorImageView: UIImageView!
    @IBOutlet weak var AuthorLabel: UILabel!
    @IBOutlet weak var PlayerView: UIPlayerView!
    @IBOutlet weak var CommentView: UIStackView!
    @IBOutlet weak var ShareView: UIStackView!
    @IBOutlet weak var DescriptionTextView: UITextView!
    @IBOutlet weak var SwipeView: SwipeRateView!
    @IBOutlet weak var VotesLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CommentCountLabel: UILabel!
    @IBOutlet weak var ShareCountLabel: UILabel!
    
    public var authorID: String!
    public var postID: String!
    public var postURL: URL!
    public var parentController: FeedViewController!
    
    public var isPlaying: Bool = false
    public var isFullscreen: Bool = false
    
    private var hasArrow: Bool = false
    private var arrowLayer: CALayer!
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Style user image
        AuthorImageView.layer.cornerRadius = AuthorImageView.frame.width/2
        AuthorImageView.clipsToBounds = true
        
        // Configure description text view
        DescriptionTextView.textContainer.lineFragmentPadding = 0
        DescriptionTextView.textContainerInset = .zero
        
        // Add tap gesture to video player
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.togglePlayback))
        PlayerView.addGestureRecognizer(tapGesture)
        
        // Add double tap gesture to video player
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.enterFullscreenDisplay))
        doubleTapGesture.numberOfTapsRequired = 2
        PlayerView.addGestureRecognizer(doubleTapGesture)
        tapGesture.require(toFail: doubleTapGesture)
        
        // Add tap gesture to authorView
        let authorTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserProfile))
        AuthorView.addGestureRecognizer(authorTapGestureRecognizer)
        
        // Add tap gesture to commentsView
        let commentsTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showPostComments))
        CommentView.addGestureRecognizer(commentsTapGestureRecognizer)
    }
    
    override func layoutSubviews() { //should this be here?
        // Create player and player layer
        player = AVPlayer(url: postURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer!.frame = PlayerView.bounds
        PlayerView.layer.addSublayer(playerLayer!)
        
        // Add play arrow
        if !hasArrow {
            arrowLayer = CALayer()
            arrowLayer.frame = CGRect(x: UIScreen.main.bounds.width/2 - 16, y: PlayerView.bounds.height/2 - 16, width: 32, height: 32)
            arrowLayer.contents = UIImage(named: "Play")?.cgImage
            PlayerView.layer.addSublayer(arrowLayer)
            hasArrow = true
        }
        
        super.layoutSubviews()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        //Configure swipe view
        SwipeView.parentCell = self
        SwipeView.postID = postID
//
//        UserManager.votes(forPost: postID, finished: { (votes) in
//            self.SwipeView.currentVotes = votes
//            self.SwipeView.reloadVotes()
//        })
    }
    
    // MARK: - Playback
    @objc func togglePlayback() {
        if isPlaying {
            pauseVideo()
        } else {
            playVideo()
        }
    }
    
    func playVideo() {
        if !isPlaying {
            // Stop all other videos
            //parentController.stopAllVideos()
            
            // Enable looping
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem, queue: nil, using: { (_) in
                DispatchQueue.main.async {
                    self.player?.seek(to: kCMTimeZero)
                    self.player?.play()
                }
            })
            
            // Begin playback
            arrowLayer.isHidden = true
            player!.play()
            isPlaying = true
        }
    }
    
    public func pauseVideo() {
        arrowLayer.isHidden = false
        player?.pause()
        isPlaying = false
    }
    
    // MARK: - Handle Buttons
    @objc public func showUserProfile() {
        // Prepare selected user profile
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let userProfileVC = storyboard.instantiateViewController(withIdentifier: "Profile") as! NewProfileViewController
//        userProfileVC.userID = authorID
//
//        // Present user profile
//        parentController.navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
    @objc public func showPostComments() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let commentsVC = storyboard.instantiateViewController(withIdentifier: "Comments") as! CommentsViewController
//        commentsVC.postID = postID
//        parentController.navigationController?.pushViewController(commentsVC, animated: true)
    }
    
    // MARK: - Toggle Fullscreen
    
    @objc func enterFullscreenDisplay() {
//        let window = UIApplication.shared.keyWindow!
//
//        let fullScreenView = FullscreenView(contentLayer: playerLayer!)
//        fullScreenView.tag = 1
//        fullScreenView.backgroundColor = UIColor.black
//
//        window.addSubview(fullScreenView)
//        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
//        fullScreenView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
//        fullScreenView.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
//        fullScreenView.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
//        fullScreenView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
//
//        // Add tap gesture to video player
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.togglePlayback))
//        fullScreenView.addGestureRecognizer(tapGesture)
//
//        // Add double tap gesture to video player
//        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(removeFullScreenView))
//        doubleTapGesture.numberOfTapsRequired = 2
//        fullScreenView.addGestureRecognizer(doubleTapGesture)
//        tapGesture.require(toFail: doubleTapGesture)
//
//        /*
//         let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(removeFullScreenView))
//         doubleTapGesture.numberOfTapsRequired = 2
//         fullScreenView.addGestureRecognizer(doubleTapGesture)
//         */
//
//        playVideo()
//
//        // Enable rotation
//        (UIApplication.shared.delegate as! AppDelegate).isRotationAllowed = true
    }
    
    @objc func removeFullScreenView() {
        let window = UIApplication.shared.keyWindow!
        window.viewWithTag(1)?.removeFromSuperview()
        
        // This allows us to make changes to layers without implicit animations
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        
        playerLayer?.frame = PlayerView.bounds
        PlayerView.layer.addSublayer(playerLayer!)
        PlayerView.layer.addSublayer(arrowLayer)
        CATransaction.commit()
        
        // Disable rotation
//        (UIApplication.shared.delegate as! AppDelegate).isRotationAllowed = false
    }
    
    func rotatePlayerLayer() {
        playerLayer?.frame = viewWithTag(1)!.bounds
    }
    
    override func prepareForReuse() {
        // Reset dynamic components
        hasArrow = false
        AuthorImageView.image = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
        player = nil
        
        super.prepareForReuse()
    }
}
class FeedViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Style nav bar
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + 128)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Futura", size: 28.0)!, NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


