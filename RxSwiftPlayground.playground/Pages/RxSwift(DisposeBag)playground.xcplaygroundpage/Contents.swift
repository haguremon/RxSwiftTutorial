import UIKit
import RxSwift


//DisposeBagを使って観察者を削除する事ができる
let disposeBag = DisposeBag()

Observable.of("A","B","C")
    .subscribe {
        print($0)//全ての処理が終わった後にdisposedする
    }.disposed(by: disposeBag)

//createを使って観察者を作成する

Observable<String>.create { obserber in
    obserber.onNext("A")
    obserber.onCompleted()//ここでCompletedされるので↓から呼ばれることはない
    obserber.onNext("?")
    return Disposables.create()
}.subscribe(onNext: {print($0)}, onError: {print($0)}, onCompleted: {print("Completed")}, onDisposed: {print("Disposed")}).disposed(by: disposeBag)

    
//subject
