//: [Previous](@previous)

import UIKit
import RxSwift


//: [Next](@next)
//SubjectにはPublishSubject, BehaviorSubject, ReplaySubject の３つ
/*
 Observableと同じように観察可能である
 イベントを取得してそれを購入者に伝える
 */

//let publishSubject = PublishSubject<String>()
//
//publishSubject.onNext("Issue 1")//String型のイベントのみ//publishSubjectの場合、サブスクする方がいないと呼ばれることはない
//
//publishSubject.subscribe { event in
//    print(event)
//}
//publishSubject.onNext("Issue 2")
//publishSubject.onNext("Issue 3")
//
////publishSubject.dispose() 此処で川が止められるから↓は呼ばれない
//publishSubject.onCompleted() //此処で完了してる
//publishSubject.onNext("Issue 4")

//BehaviorSubjectは初期値が必要！
//let behaviorSubject = BehaviorSubject(value: "Initial value")
//
////でも、購入者に使われる前に初期値の値は書き換える事ができる
//behaviorSubject.onNext("Valor inicial real")
//behaviorSubject.onNext("Last Issue")
//
////購入者
//behaviorSubject.subscribe { event in
//    print(event)
//}
//behaviorSubject.onNext("Issue 1")
//behaviorSubject.onNext("Issue 2")
//
//print("*************************************************")

//購入者によって最後からbufferSize分を所得する事ができる
let replaySubject = ReplaySubject<String>.create(bufferSize: 1)

replaySubject.onNext("Issue 1")
replaySubject.onNext("Issue 2")
replaySubject.onNext("Issue 3")

//publishSubjectとは違うサブスクしなくても呼ばれてるbufferSizeで指定があるけど↑でbufferSizeの最後↓は何個も
replaySubject.subscribe {
    print($0)
}

replaySubject.onNext("Issue 4")
replaySubject.onNext("Issue 5")
replaySubject.onNext("Issue 6")

print("[サブスクリプション 2]")

replaySubject.subscribe {
    print($0)
}

//
