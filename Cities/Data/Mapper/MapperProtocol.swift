//
//  MapperProtocol.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


protocol MapperProtocol {
    associatedtype T
    associatedtype U
    func adapt(apiResponse: T) -> U
}
