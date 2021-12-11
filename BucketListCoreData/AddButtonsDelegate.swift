//
//  AddButtonsDelegate.swift
//  BucketList
//
//  Created by Hell on 11/12/2021.
//

import Foundation

protocol AddButtonsDelegate : class {
    func cancelButtonPressed(by controller:AddItemViewController)
    func saveButtonPressed(by controller:AddItemViewController, with text:String, indexPath:IndexPath?)
}
