//
//  CustomCollectionViewLayoutPrototcol.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 21/06/23.
//

import UIKit

protocol CustomCollectionViewLayoutPrototcol: AnyObject  {
    func collectionView(_ collectionView: UICollectionView, widthForProgramAtIndexPath indexPath: IndexPath) -> CGFloat
}
