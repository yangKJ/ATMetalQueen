//
//  C7ColorMatrix4x4.swift
//  Harbeth
//
//  Created by Condy on 2022/2/21.
//

import Foundation

public struct C7ColorMatrix4x4: C7FilterProtocol {
    
    /// Color offset for each channel, from -255 to 255.
    public var offset: C7RGBAColor = .zero
    /// The degree to which the new transformed color replaces the original color for each pixel, default 1
    public var intensity: Float = 1.0
    private let matrix: Matrix4x4
    
    public var modifier: Modifier {
        return .compute(kernel: "C7ColorMatrix4x4")
    }
    
    public var factors: [Float] {
        return [intensity] + offset.toFloatArray()
    }
    
    public func setupSpecialFactors(for encoder: MTLCommandEncoder, index: Int) {
        let computeEncoder = encoder as! MTLComputeCommandEncoder
        var factor = matrix.to_matrix_float4x4()
        computeEncoder.setBytes(&factor, length: Matrix4x4.size, index: index + 1)
    }
    
    public init(matrix: Matrix4x4) {
        self.matrix = matrix
    }
}
