## Using TvOSCustomizableTableViewCell programmatically

TvOSCustomizableViewCell is a subclass of UITableViewCell, so it can be created and used as a regular TvOSCustomizableViewCell.

Example:
```swift
class ViewController: UIViewController, UITableViewDataSource {

    private var tableView: UITableView!
    var dataSource: UITableViewDataSource

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TvOSCustomizableTableViewCell

        cell.textLabel?.text = "Item \(indexPath.row)"
        cell.focusedTitleColor = .black
        cell.focusedBackgroundColor = .white
        cell.focusedScaleFactor = 1.05

        return cell
    }

    // MARK: Private

    private func setUpTableView() {
        tableView = UITableView()
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(TvOSCustomizableTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
}
```

