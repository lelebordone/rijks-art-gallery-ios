import UIKit

class RijksLoadingView: UIView {
    private let loadingImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "spinner"))
        view.isHidden = true
        view.tintColor = RijksColors.brand
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 24).isActive = true
        view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = RijksTitleLabel(textAlignment: .center,
                                    fontSize: 18,
                                    fontWeight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RijksColors.brand
        label.numberOfLines = 0
        return label
    }()
    
    private let animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.isRemovedOnCompletion = false
        animation.toValue = .pi * 2.0
        animation.duration = 0.8
        animation.isCumulative = true
        animation.repeatCount = Float.infinity
        return animation
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingImageView)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            loadingImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            messageLabel.bottomAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(transperentBackground: Bool,
                   message: String?) {
        let backgroundColor = transperentBackground ? UIColor.systemBackground.withAlphaComponent(0.85) : UIColor.systemBackground
        self.backgroundColor = backgroundColor
        startRefreshing()
        messageLabel.text = message
        centerElementsVertically()
    }
    
    private func centerElementsVertically() {
        guard messageLabel.text != nil else {
            loadingImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            messageLabel.removeFromSuperview()
            return
        }
        addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            loadingImageView.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16)
        ])
    }
    
    func startRefreshing() {
        loadingImageView.isHidden = false
        loadingImageView.layer.add(animation, forKey: "rotationAnimation")
    }
    
    func endRefreshing() {
        loadingImageView.layer.removeAllAnimations()
        loadingImageView.isHidden = true
    }
}

// MARK: - Public interface
protocol Loadable {
    var loadingView: RijksLoadingView { get }
}

extension Loadable {
    func showLoading(on view: UIView? = nil,
                     transperentBackground: Bool = true,
                     message: String? = nil) {
        loadingView.isHidden = false
        if view == nil {
            let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
            keyWindow?.addContentView(loadingView)
        } else {
            view?.addContentView(loadingView)
        }
        loadingView.configure(transperentBackground: transperentBackground,
                              message: message)
    }
    
    func hideLoading() {
        loadingView.endRefreshing()
        loadingView.removeFromSuperview()
    }
}
