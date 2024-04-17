//
//  APIProperties.swift
//  TestTaskIntersvyaz
//
//  Created by Вадим Игнатенко on 15.04.24.
//

import Foundation


struct APIProperties {
    
    private static let server = "https://jsonplaceholder.typicode.com/"
    private static let photosPath = server + "photos"
    static let photosURL = URL(string: photosPath)
}
