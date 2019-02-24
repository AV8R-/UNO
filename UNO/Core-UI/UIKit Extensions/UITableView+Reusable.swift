import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: Header/Footer
public extension UITableView {
    func registerHeaderFooter<HeaderFooter>(type: HeaderFooter.Type)
    where HeaderFooter: UITableViewHeaderFooterView & Reusable
    {
        register(type, forHeaderFooterViewReuseIdentifier: HeaderFooter.reuseIdentifier)
    }


    func dequeueHeaderFooter<HeaderFooter>() -> HeaderFooter
    where HeaderFooter: UITableViewHeaderFooterView & Reusable
    {
        return dequeueReusableHeaderFooterView(withIdentifier: HeaderFooter.reuseIdentifier) as! HeaderFooter
    }

    func dequeueAndRegisterHeaderFooter<HeaderFooter>() -> HeaderFooter
    where HeaderFooter: UITableViewHeaderFooterView & Reusable
    {
        let identifier = HeaderFooter.reuseIdentifier
        if let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? HeaderFooter {
            return headerFooter
        } else {
            register(HeaderFooter.self, forHeaderFooterViewReuseIdentifier: identifier)
            return dequeueReusableHeaderFooterView(withIdentifier: identifier) as! HeaderFooter
        }
    }
}

//MARK: - Cells
public extension UITableView {
    func registerCell<Cell>(type: Cell.Type)
    where Cell: UITableViewCell & Reusable
    {
        register(type, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    func dequeueCell<Cell>() -> Cell
    where Cell: UITableViewCell & Reusable
    {
        return dequeueReusableCell(withIdentifier: Cell.reuseIdentifier) as! Cell
    }

    func dequeueCellForIndexPath<Cell>(indexPath: IndexPath) -> Cell
    where Cell: UITableViewCell & Reusable
    {
        return dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }

    func dequeueAndRegisterCell<Cell>() -> Cell
    where Cell: UITableViewCell & Reusable
    {
        if let cell = dequeueReusableCell(withIdentifier: Cell.reuseIdentifier) as? Cell {
            return cell
        } else {
            register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
            return dequeueReusableCell(withIdentifier: Cell.reuseIdentifier) as! Cell
        }
    }

    func dequeueAndRegisterCell<Cell>(indexPath: IndexPath) -> Cell
    where Cell: UITableViewCell & Reusable
    {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        return dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }
}

