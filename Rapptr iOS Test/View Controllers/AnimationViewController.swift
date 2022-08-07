//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import AVFoundation
import Gifu

class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     */
    
    @IBOutlet weak var fadeButton: CustomButton!

    @IBOutlet var logoImage: UIImageView!
    private var initialCenter: CGPoint = .zero
    var faded = false
    
    @IBOutlet var gifView: GIFImageView!
    var player: AVAudioPlayer?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"

        fadeButton.cornerRadius = 8
                                
        self.navigationController?.navigationBar.topItem?.title = " "
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white,
                                                            .font : UIFont.systemFont(ofSize: 17.0, weight: .semibold)]
        
        logoImage.isUserInteractionEnabled = true
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        logoImage.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        if faded {
            fadeIn()
        } else {
            fadeOut()
        }
    }
    
    func fadeOut(){
        gifView.animate(withGIFNamed: "wow.gif", loopCount: 1, preparationBlock: { [self] in
            playWow()
        }, animationBlock: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut, animations: { [self] in
            logoImage.alpha = 0
        }, completion: { [self]_ in
            faded = true
            fadeButton.setTitle("Fade In", for: .normal)
        })
    }
    
    func fadeIn(){
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut, animations: { [self] in
            logoImage.alpha = 1
        }, completion: { [self]_ in
            faded = false
            fadeButton.setTitle("Fade Out", for: .normal)
        })
    }

    func playWow() {
        guard let url = Bundle.main.url(forResource: "wow", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            initialCenter = logoImage.center
        case .changed:
            let translation = sender.translation(in: self.view)
            
            logoImage.center = CGPoint(x: initialCenter.x + translation.x,
                                          y: initialCenter.y + translation.y)
        case .ended, .cancelled:
            break
        default:
            break
        }
    }

}
