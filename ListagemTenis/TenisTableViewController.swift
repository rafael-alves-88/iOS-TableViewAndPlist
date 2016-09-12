//
//  TenisTableViewController.swift
//  ListagemTenis
//
//  Created by Thales Toniolo on 10/4/15.
//  Copyright © 2015 Flameworks. All rights reserved.
//
import UIKit

class TenisTableViewController: UITableViewController {

	var tenisArr: [AnyObject]?

    override func viewDidLoad() {
        super.viewDidLoad()

		if let plistPath = NSBundle.mainBundle().pathForResource("ListaTenis", ofType: "plist") {
			self.tenisArr = NSArray(contentsOfFile: plistPath)! as [AnyObject]
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDelegate / UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tenisArr!.count
    }

	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 160.0
	}

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath)

		let dic: [String:AnyObject] = self.tenisArr![indexPath.row] as! [String:AnyObject]
		cell.textLabel?.text = dic["Nome"] as? String
		let valor: Double = dic["Valor"] as! Double
		cell.detailTextLabel?.text = "R$ \(valor)"
		cell.imageView?.image = UIImage(named: dic["Imagem"] as! String)
		cell.accessoryType = UITableViewCellAccessoryType.None
		if (NSUserDefaults.standardUserDefaults().objectForKey(dic["Nome"] as! String) != nil) {
			cell.accessoryType = UITableViewCellAccessoryType.Checkmark
		}

        return cell
    }

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let cell = tableView.cellForRowAtIndexPath(indexPath)
		let cellKey = cell?.textLabel?.text!
		if (cell?.accessoryType == UITableViewCellAccessoryType.None) {
			cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
			NSUserDefaults.standardUserDefaults().setValue("S", forKey: cellKey!)
		} else {
			cell?.accessoryType = UITableViewCellAccessoryType.None
			NSUserDefaults.standardUserDefaults().removeObjectForKey(cellKey!)
		}
		// Efetiva as operacoes no userdefaults
		NSUserDefaults.standardUserDefaults().synchronize()
		// Desmarca a celula selecionada
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
}
