//
//  main.swift
//  211009_optional_exception
//
//  Created by 이승재 on 2021/10/09.
//

import Foundation

var budget: Int = 2000
var productsList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]
let price: Int = 1000
let numberOfProduct = productsList.count
//MARK:- 1번

// 1. 옵셔널 바인딩 (guard)

//func printProductsList() {
//    for index in 0..<productsList.count {
//        guard let product = productsList[index] else { return }
//        print("\(index)번 상품은 \(product)입니다.")
//
//    }
//}

// 2. 닐 병합 연산자

func printProductsList() {
    for index in 0..<numberOfProduct {
        let product = productsList[index] ?? "nil"
            print("\(index)번 상품은 \(product)입니다.")

    }
}

// 3. 강제추출

//func printProductsList() {
//    for index in 0..<productsList.count {
//        let product: String = productsList[index]!
//        print("\(index)번 상품은 \(product)입니다.")
//
//    }
//}

// 4. implicitly unwrapping

//func printProductsList() {
//    for index in 0..<productsList.count {
//        let product : String! = productsList[index]
//        print("\(index)번 상품은 \(product)입니다.")
//
//    }
//}

//printProductsList()

//MARK:- 2번



enum shopError: Error {
    case soldout
    case insufficientBudget
    case invalidInput
}

func buy(input: String) -> Result<Int, shopError> {
    guard let validInput: Int = Int(input), validInput > 0, validInput < numberOfProduct else { return .failure(shopError.invalidInput) }
    switch validInput {
    case 0...5:
        guard productsList[validInput] != nil else { return .failure(shopError.soldout) }
        guard budget - price >= 0 else { return .failure(shopError.insufficientBudget) }
        budget -= price
        productsList[validInput] = nil
        return .success(validInput)
    default:
        return .failure(shopError.invalidInput)
    }
}

func goShop()  {
    print("구매하실 상품의 번호를 입력해 주세요. 야곰아카데미 샵을 나가시려면 9번을 입력해 주세요.\n")
    printProductsList()
    print("입력: ", terminator: "")
    guard let selectedNumber = readLine(), selectedNumber != "9" else { return }
    let result = buy(input: selectedNumber)
    
    switch result {
    case .success(let number):
        print("\(number)번 상품을 구매했습니다.")
        print("남은 예산은 \(budget)입니다.")
    case .failure(shopError.insufficientBudget):
        print("예산이 부족합니다.")
    case .failure(shopError.soldout):
        print("재고가 없는 상품입니다.")
    case .failure(shopError.invalidInput):
        print("잘못된 입력입니다.")
    }
    
    goShop()
}


goShop()
