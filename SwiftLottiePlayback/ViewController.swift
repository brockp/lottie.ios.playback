import UIKit
import Lottie

class ViewController: UIViewController {

    var animation: Animation!
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var frameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create CADisplayLink to display frame, progress and time
        displayLink = CADisplayLink(target: self, selector: #selector(animationCallback))
        displayLink?.add(to: .current, forMode: RunLoop.Mode.default)
        
        // Create Animation object
        let jsonName = "titchenerIllusion"
        animation = Animation.named(jsonName)
        
        // Print out animation's total frame count
        print(animation.endFrame)

        // Print out animation's frame rate
        print(animation.framerate)
            
        // Set animation to AnimationView
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        let opacityValueProvider = FloatValueProvider(CGFloat(100))
        let dotOpacityKeyPath = AnimationKeypath(keypath: "large-circle.large-circle-4.large-circle-4.Opacity")
        animationView.setValueProvider(opacityValueProvider, keypath: dotOpacityKeyPath)
        animationView.loopMode = .playOnce
        animationView.play()
        animationView.logHierarchyKeypaths()
        
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        animationView.stop()
        
        timeLabel.text = "1"
        progressLabel.text = "0"
        frameLabel.text = "0"
        
        animationView.forceDisplayUpdate()
    }
    
    @IBAction func pauseButtonTapped(_ sender: Any) {
        animationView.pause()
    }
    
    @IBAction func removeOneDotButtonTapped(_ sender: Any) {
        
        let opacityValueProvider = FloatValueProvider(CGFloat(0))
        let dotOpacityKeyPath = AnimationKeypath(keypath: "large-circle.large-circle-4.large-circle-4.Opacity")
        animationView.setValueProvider(opacityValueProvider, keypath: dotOpacityKeyPath)
        animationView.play()
    }
    
    @IBAction func themeAndReverseButtonTapped(_ sender: Any) {
        let bioticPink = Color(r: (200/255), g: (11/255), b: (202/255), a: 1)
        let bioticPinkColorProvider = ColorValueProvider(bioticPink)
        let keyPath = AnimationKeypath(keypath: "**.Color")
        animationView.setValueProvider(bioticPinkColorProvider, keypath: keyPath)
        
        animationView.play(fromFrame: 93,
                           toFrame: 0,
                           loopMode: .loop)
    }
    
    @objc func animationCallback() {
        if animationView.isAnimationPlaying {
            // Display animation frame, time and progress in realtime
            progressLabel.text = "\(animationView.realtimeAnimationProgress)"
            frameLabel.text = "\(animationView.realtimeAnimationFrame)"
            timeLabel.text = "\(animationView.realtimeAnimationFrame / CGFloat(animation.framerate) / animationView.animationSpeed)"
        }
    }
    
}

