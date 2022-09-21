import UIKit
import RxSwift

//
//let observable1 = Observable.just(1)
//let observable2 = Observable.of(1,2,3)
//let observable3 = Observable.of([1,2,3])
//let observable4 = Observable.from([1,2,3,4])
///*Of means it'll function on that of (),
// While from, it will take what on that particular (), on each element of it
//
// That's why observable 3 is an array, and observable 4 is an integer
// */
//
////MARK: - 1.Subscriptions
///*
// will get access to the value above (To Obeservable we observing)
// */
//
//observable4.subscribe { event in
//  //event is something that will happen
//  print(event)
//
//  //and if we do this, it will take the actual value of the event.
//  if let element = event.element {
//    //element here is the actual value.
//    print (element)
//  }
//}
//
//observable3.subscribe { event in
//  if let element = event.element{
//    print(element)
//    /*
//     It will print the entire array, because it's using 'of' which means will print all of the event.
//     */
//  }
//}
//
////OnNext
///*
// Will get the actual value without containing -- and easier
// */
//
//observable4.subscribe(onNext: {element in
//  print(element)
//})
//
////MARK: - Dispossing an Terminating
///*
// Subscription will always observing,
// that's why we should have "Disposing" to stop this subscription observing, and prevent memory leak.
//
// */
//
//let subscription4 = observable4.subscribe(onNext: {element in
//  print(element)
//})
//
////Disposing
//subscription4.dispose()
///*
// But sometimes people are forget to dispose.,
//
// So that's why we have Another disposing methode, here:
// */
//
//

//MARK: - Another Way for Disposing

//Responsible for disposing
let disposeBag = DisposeBag()


//MARK: Way 1
/*
 Observable below doesn't have any way to dispose itself. So We create the disposeBag to dispose.

 function of .disposed(by:) will be able to use the disposeBag
 */
Observable.of("A","B","C")
  .subscribe{
    print($0)
  }.disposed(by: disposeBag)

//MARK: Way 2
/*
.create()
Another function to create a subscription
 */
Observable<String>.create { observer in
  observer.onNext("A")
  observer.onCompleted()
  observer.onNext("?") //It won't be run, bcs it ha been completed above, and the function is already been diposed

  ///* When you create disposable function, you should return  it like this:
  return Disposables.create()
  //It's an empty disposible just like disposeBag above.

}.subscribe(onNext: {print($0)}, onError: {print($0)}, onCompleted: {print("Completed!")}, onDisposed: {print("Disposed!")})
  .disposed(by: disposeBag)
