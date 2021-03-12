import Foundation

public protocol KSScrollPerformanceDetectorDelegate: NSObjectProtocol {
    func framesDropped(count: Int, cumulativeCount: Int, cumulativeEventsCount: Int)
}

public class KSScrollPerformanceDetector: NSObject {

    public private(set) var currentFrameDropCount: Int
    public private(set) var currentFrameDropEventCount: Int
    public weak var delegate: KSScrollPerformanceDetectorDelegate?
    internal var lastTimestamp: CFTimeInterval
    internal var workerQueue: DispatchQueue

    internal lazy var displayLink: CADisplayLink = {
        let link = CADisplayLink(target: self, selector: #selector(displayLinkTriggered(_:)))
        link.isPaused = true
        link.add(to: RunLoop.main, forMode: .common)
        return link
    }()

    public override init() {
        self.lastTimestamp = 0
        self.workerQueue = DispatchQueue(label: "com.frame-rate-reporter.worker", qos: .userInitiated, attributes: .concurrent)
        self.currentFrameDropCount = 0
        self.currentFrameDropEventCount = 0
        super.init()
        self.registerLifecyleNotifications()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        self.displayLink.isPaused = true
        self.displayLink.invalidate()
    }

    // Mark: init helpers
    internal func registerLifecyleNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyActivate(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyDeactivate(_:)), name: UIApplication.willResignActiveNotification, object: nil)
    }

    // Mark: Public methods
    public func resume() {
        self.displayLink.isPaused = false
    }

    public func pause() {
        self.displayLink.isPaused = true
    }

    public func clearFrameRate() {
        self.workerQueue.async { [weak self] in
            guard let self = self else { return }
            self.currentFrameDropCount = 0
            self.currentFrameDropEventCount = 0
        }
    }

    //Mark: private methods

    @objc internal func displayLinkTriggered(_ sender: CADisplayLink) {
        self.workerQueue.async {
            guard sender.duration != 0 else { return }
            defer { self.lastTimestamp = sender.timestamp }
            guard self.lastTimestamp != 0 else { return }
            let numberOfFramesDouble = round((sender.timestamp - self.lastTimestamp)/sender.duration)
            assert(numberOfFramesDouble <= Double(Int.max) && numberOfFramesDouble >= Double(Int.min))
            let numberOfFrames = Int(numberOfFramesDouble)
            self.calculateFrameDrop(for: numberOfFrames)
        }
    }

    internal func calculateFrameDrop(for numberOfFrames: Int) {
        let droppedFrameCount = numberOfFrames - 1 > 0 ? numberOfFrames : 0 // pretty sure that could just be max(numberOfFrames, 0)
        guard droppedFrameCount > 0 else { return }
        self.currentFrameDropCount += droppedFrameCount
        self.currentFrameDropEventCount += 1
        self.delegate?.framesDropped(count: droppedFrameCount, cumulativeCount: self.currentFrameDropCount, cumulativeEventsCount: self.currentFrameDropEventCount)
    }

    @objc internal func notifyActivate(_ notification: NSNotification) {
        self.resume()
        self.lastTimestamp = 0
    }

    @objc internal func notifyDeactivate(_ notification: NSNotification) {
        self.pause()
    }
}
