
import UIKit
import RxSwift
/*
 public enum Event<Element> {
     case Next(Element)
     case Error(ErrorType)
     case Completed
 }
 */
let disposeBag = DisposeBag()
//Observable

let observable1 = Observable.just(1)//１だけ
let observable2 = Observable.of(1,2,3) //1,2,3全て
let observable3 = Observable.of([1,2,3])//Observable<[Int]>配列全てが対象
let observable4 = Observable.from([1,2,3,4,5])// Observable<Int>で配列の要素が監視対象

//サブスクライブしてみる

observable4.subscribe { event in
   // print(event)// print(event)だけではちゃんと値を取得する事ができない next(1)nextイベントに入ってるため 監視可能な値が全て終わった時に completedしてる
    //実際に値を取り出すには
    //nextで次の値があるかわからないから？アンラップかな？
    if let element = event.element {
        print(element)
    }
}.disposed(by: disposeBag)

observable3.subscribe { event in
    //print(event)//next([1, 2, 3]) completed
    if let element = event.element {
        print(element)//配列全体にサブスクできてる
    }
}.disposed(by: disposeBag)
//↑まではアンラップしてアクセスする事ができてるが oNnextを使うとアンラップしなくてもいい
/*
 onNext: { [weak object] in
     guard let object = object else { return }
     onNext?(object, $0)
 },
 */
observable4.subscribe(onNext: { element in
    print(element)
}).disposed(by: disposeBag)
