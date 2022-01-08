import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()
//BehaviorRelayは初期値が必要
//let behaviorRelay = BehaviorRelay(value: "initial value")
//
//behaviorRelay.asObservable()
//    .subscribe {  print($0) } //サブスクすると前でプリントが変わる
//
////behaviorRelay.value = "Hello worid" 値を変更しようとするとエラーが発生 //valueは読み取り専用のために　不変的であるためにエラーが発生した
//behaviorRelay.accept("new initial Value")//accept関数を使うことによって新しい値を代入する事ができる


//配列の場合はどうなるか

let behaviorRelayArray = BehaviorRelay(value:["item1"])


behaviorRelayArray.accept( behaviorRelayArray.value + ["Item2"]) //valueは読み取り専用なので　初期値　+  ["Item2"]になって　appendみたいになってる

//これでも上のようにappendできる
var value = behaviorRelayArray.value
value.append("Item3")
value.append("Item4")

behaviorRelayArray.accept(value)

behaviorRelayArray.subscribe { print($0) }
//behaviorRelayArray.value.append("item 1") これも同じくエラー

behaviorRelayArray.accept(["Item3"])
