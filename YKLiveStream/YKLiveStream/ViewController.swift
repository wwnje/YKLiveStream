//
//  ViewController.swift
//  YKLiveStream
//
//  Created by wwnje on 2017/4/15.
//  Copyright © 2017年 orvnge. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    //上个页面传来的数据
    
    var live:YKCell!
    
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var btn_gift: UIButton!
    
    @IBOutlet weak var btn_like: UIButton!
    
    
    @IBAction func btn_Back(_ sender: UIButton) {
        
        ijkPlayer.shutdown()
        
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @IBAction func tap_LIke(_ sender: UIButton) {
        
        let heart = DMHeartFlyView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        heart.center = CGPoint(x: btn_like.frame.origin.x, y: btn_like.frame.origin.y)
        
        view.addSubview(heart)
        heart.animate(in: view)
        
        //爱心按钮 由小变大
        let btnAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        
        btnAnim.values = [1.0, 0.9, 0.8, 0.7,0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.0]
        btnAnim.keyTimes = [0.0, 0.1, 0.2, 0.3,0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
        btnAnim.duration = 0.2
        sender.layer.add(btnAnim, forKey: "SHOW")
        
    }
   
    @IBAction func tap_GIft(_ sender: UIButton) {
        let duration = 3.0
        let car = UIImageView(image: #imageLiteral(resourceName: "porsche"))
        
        car.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(car)
        
        let widthCar: CGFloat = 250
        let heightCar: CGFloat = 125
        
        UIView.animate(withDuration: duration) { 
            car.frame = CGRect(x: self.view.center.x  - widthCar/2, y: self.view.center.y - heightCar/2, width: widthCar, height:heightCar)
        }
        
        //延时消失
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { 
            UIView.animate(withDuration: duration, animations: { 
                car.alpha = 0
            }, completion: { (completed) in
                car.removeFromSuperview()
            })
        }
        
        //烟花
        let layerFw = CAEmitterLayer()
        view.layer.addSublayer(layerFw)
        emmitParticles(from: sender.center, emitter: layerFw, in: view)
        
        //延时消失
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) {
            layerFw.removeFromSuperlayer()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dump(live)
        setBg()
        
        Play()
        
        bringBtnToFront()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !self.ijkPlayer.isPlaying(){
            ijkPlayer.prepareToPlay()
        }
    }
    
    var playView: UIView!
    var ijkPlayer: IJKMediaPlayback!
    
    //播放
    func Play(){
        self.playView = UIView(frame: view.bounds)
        view.addSubview(self.playView)
        
        ijkPlayer = IJKFFMoviePlayerController(contentURLString: live.url, with: nil)
        
        let pv = ijkPlayer.view!
        
        pv.frame = playView.bounds
        pv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        playView.insertSubview(pv, at: 1)
        ijkPlayer.scalingMode = .aspectFill
    }
    
    //设置背景图
    func setBg() {
        let imgUrl = URL(string: live.portrait)
        
        imgBack.kf.setImage(with: imgUrl)
        
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = imgBack.bounds
        imgBack.addSubview(effectView)
    }
    
    func bringBtnToFront() {
        view.bringSubview(toFront: btn_like)
        view.bringSubview(toFront: btn_back)
        view.bringSubview(toFront: btn_gift)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

