//
//  RankService.swift
//  Network
//
//  Created by Junho Lee on 2022/12/03.
//  Copyright © 2022 SOPT-Stamp-iOS. All rights reserved.
//

import Foundation
import Combine

import Alamofire
import Moya

public typealias DefaultRankService = BaseService<RankAPI>

public protocol RankService {
  func fetchRankingList(isCurrentGeneration: Bool) -> AnyPublisher<[RankingEntity], Error>
  func fetchRankDetail(userName: String) -> AnyPublisher<RankDetailEntity, Error>
  func fetchPartRanking() -> AnyPublisher<[PartRankingEntity], Error>
  func fetchRankingListInPart(part: String) -> AnyPublisher<[RankingEntity], Error>
}

extension DefaultRankService: RankService {
  public func fetchRankingList(isCurrentGeneration: Bool) -> AnyPublisher<[RankingEntity], Error> {
    requestObjectInCombine(isCurrentGeneration ? RankAPI.currentRank : RankAPI.rank)
  }

  public func fetchRankDetail(userName: String) -> AnyPublisher<RankDetailEntity, Error> {
    requestObjectInCombine(RankAPI.rankDetail(userName: userName))
  }

  public func fetchPartRanking() -> AnyPublisher<[PartRankingEntity], Error> {
    requestObjectInCombine(.rankPart)
  }

  public func fetchRankingListInPart(part: String) -> AnyPublisher<[RankingEntity], Error> {
    requestObjectInCombine(.currentRankInPart(partName: part))
  }
}
