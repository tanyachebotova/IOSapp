import UIKit

final class ViewController: UIViewController {

    // MARK: - Constants

    private enum Constant {
        enum HelloLabel {
            static let width: CGFloat = 100.0
        }
    }

    // MARK: - Subviews

    private var helloLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.addAction(
            UIAction { [weak self] _ in
                self?.showPrevious()
            },
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        button.addAction(
            UIAction { [weak self] _ in
                self?.showNext()
            },
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Properties

    private let items: [(title: String, imageName: String)] = [
        ("Suzume", "car1"),
        ("Rapid GT X", "car2")
    ]

    private var currentIndex: Int = 0

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        showCurrentItem()
    }

    // MARK: - Methods

    private func configureView() {
        view.backgroundColor = .white

        view.addSubview(helloLabel)

        NSLayoutConstraint.activate([
            helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            helloLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            helloLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        view.addSubview(leftButton)
        view.addSubview(rightButton)

        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            leftButton.heightAnchor.constraint(equalToConstant: 44),
            leftButton.widthAnchor.constraint(equalToConstant: 44),

            rightButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            rightButton.heightAnchor.constraint(equalToConstant: 44),
            rightButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func showCurrentItem() {
        let item = items[currentIndex]
        helloLabel.text = item.title
        imageView.image = UIImage(named: item.imageName)
    }

    private func showPrevious() {
        currentIndex = (currentIndex - 1 + items.count) % items.count
        showCurrentItem()
    }

    private func showNext() {
        currentIndex = (currentIndex + 1) % items.count
        showCurrentItem()
    }
}
