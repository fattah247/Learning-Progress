import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

//MARK: -OBSERVABLE
//
//let observable1 = Observable.just(1)
//let observable2 = Observable.of(1,2,3)
//let observable3 = Observable.of([1,2,3])
//let observable4 = Observable.from([1,2,3,4])
///*
// Of means it'll function on that of (),
// While from, it will take what on that particular (), on each element of it
//
// That's why observable3 is an array, and observable 4 is an integer
// */

//MARK: 1.Subscriptions
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
//
////OnNext
///*
// Will get the actual value without containing -- and easier
// */
//
//observable4.subscribe(onNext: {element in
//  print(element)
//})

//MARK: Dispossing and Terminating
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

//MARK: Another Way for Disposing
//
////Responsible for disposing
//let disposeBag = DisposeBag()
//
//
////MARK: Way 1
///*
// Observable below doesn't have any way to dispose itself. So We create the disposeBag to dispose.
//
// function of .disposed(by:) will be able to use the disposeBag
// */
//Observable.of("A","B","C")
//  .subscribe{
//    print($0)
//  }.disposed(by: disposeBag)
//
////MARK: Way 2
///*
//.create()
//Another function to create a subscription
// */
//Observable<String>.create { observer in
//  observer.onNext("A")
//  observer.onCompleted()
//  observer.onNext("?") //It won't be run, bcs it ha been completed above, and the function is already been diposed
//
//  ///* When you create disposable function, you should return  it like this:
//  return Disposables.create()
//  //It's an empty disposible just like disposeBag above.
//
//}.subscribe(onNext: {print($0)}, onError: {print($0)}, onCompleted: {print("Completed!")}, onDisposed: {print("Disposed!")})
//  .disposed(by: disposeBag)


//MARK: -SUBJECT
///*
// Subject will get event from someone (or something), and will forward the result to its subscriber.
// */
//let disposeBag = DisposeBag()
//
////MARK: Publish Subject
//let subject = PublishSubject<String>()
///*
// It's basically a subject that we can subscribe and also it can emit event.
//
// It doesn't need any initial values to begin with.
// */
//
//subject.onNext("Issue 1") //Event Will not be run, if there is no one subscribes to it.
//
//subject.subscribe { event in
//  print(event)
//}  //Event will be run after it's subscribed.
//
//subject.onNext("Issue 2")
//subject.onNext("Issue 3")
//
//subject.onCompleted()
//subject.dispose() //If it's disposed, event below the disposed function will not be called
//
//subject.onNext("Issue 4")
///*
// Subject is something special, because it is something that can emit values, and also observe it.
//
// It is both the subsrciber and the observer.
// */

//MARK: Behavior Subject
//let subject = BehaviorSubject<String>(value: "Initial Value")
///*
// Pretty similar to Publish Subject,
// but Behavior subject need to pass initial value to initiate
//
// Reason to pass the value first:
// - When It's subscribed, it'll give all value, or initial value, or the last value.
// */
//
//subject.onNext("Last Issue")
///*
// It'll be still printed first,
// according to its order.
// */
//
//subject.subscribe { event in
//  //The event that would be received is actually the last value it had, or the initial value
//  print(event)
//  //Will print the last value that is available.
//}
//
//subject.onNext("Issue 1")
//subject.onNext("Issue 2")

//MARK: Replay subject
//let subject = ReplaySubject<String>.create(bufferSize: 2)
///*
// Replay Subject will replay the event based on the buffer size that is set.
//
// Buffer size means, whenever new subscriber subscribe the subject,
// they'll automatically replay the last two values that were ommited by the subject
//*/
///*
// Without subscription, this issue will be emitted, but it will not shown
//
// Because it seems like, issues are posted, but no one listen to it.
//*/
//subject.onNext("Issue 1")
//subject.onNext("Issue 2")
//subject.onNext("Issue 3")
//
//subject.subscribe {
//  print($0) // $0 is the event
//  /*
//   It will replay as much as the Buffer Size number has been given.
//
//   So because the buffersize value is 2, So it'll replay 2 lsat event.
//  */
//}
//
//
////The same as above, but the event is different, with different subscription of events.
//subject.onNext("Issue 4")
//subject.onNext("Issue 5")
//subject.onNext("Issue 6")
//
//print("[Subscription 2]")
//subject.subscribe {
//  print($0) //Will print the last 2 events, which are issues 5 and 6
//}

//MARK: Variables (BehaviorSubject has deprecated)
////Successor chosen is Behavior Relay
//let variable = Variable([String]())
///*
// Variable Wraps behavior subject and stores its value in a state,
// and we can using the value with value property.
//
// Since it's using behavior subject, it needs sort of initial value to a variable.
// Initial value that we use is, an array, that we can append the data below.
// */
//
//variable.value.append("Item 1")
//
//variable.asObservable()
//  .subscribe {
//    print($0)
//}
//
//variable.value.append("Item 2") // It's added to the array
//
///*
// So Variable subscription, after converting it into observable, will actually fired again and again whenever the value of the variable is changed.
// It's useful because we often change the array on iOS application
//*/

//MARK: Behavior Relay
//let relay = BehaviorRelay<Array>(value: ["item 1"])
////It has to have an initial value.
//
////To Append the array, instead of replacing items every '.accpet()'
//var value = relay.value
//value.append("Item 2")
//value.append("Item 3")
////.accept() is mutable variable, that made us able to add item on array
//relay.accept(value)
//
//
//////Another way to do it.
//////relay.accept(relay.value + ["Item 2"] + ["Item 3"])
//
//relay.asObservable()
//  .subscribe {
//    print($0)
//  }


//MARK: -FILTERING OPERATORS

//MARK: Ignore Operator
///*
// .ignoreElements() will ignore all the elements. Although the element is ignored, the complete event is actually triggered
// */
//
////Publish event that contains String
//let strikes = PublishSubject<String>()
//
////Subscription
//strikes
//  .ignoreElements().subscribe { _ in
//    print("[Subscription is called]")
//  }.disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//strikes.onNext("C")
//
//strikes.onCompleted()
////It will be the only thing that is called here, due to .ignoreElements()

//MARK: Element At
///*
// Elemen At operator is used to call subscription when the index is already reaching the index number at the element that the operator stated.
// */
//
//let strikes = PublishSubject<String>()
//
//strikes.element(at: 2)
//  .subscribe(onNext: { _ in
//    print("You are out!")
//  }).disposed(by: disposeBag)
//
//strikes.onNext("X")
//strikes.onNext("X")
//strikes.onNext("X")

//MARK: Filter
///*
// Operator that can be used to filter element (especially a sequence), according to the rule that has been given to the filter.
// */
//
//Observable.of(1,2,3,4,5,6,7)
//  .filter { $0 % 2 == 0} //The Filter
//  .subscribe(onNext: {
//    print($0)
//  }).disposed(by: disposeBag)

//MARK: Skip
///*
// Skipping element on the Subscription as much as the number that has been stated on this operator.
// */
//Observable.of("A","B","C","D","E","F")
//  .skip(4).subscribe(onNext: { print($0)
//  }).disposed(by: disposeBag)

//MARK: Skip While
///*
// Skip While operator will skipping element, until the condition that is stated is NOT met.
// After the state condition NOT met, the state will be granted to be part of the sequence
//
// ->It's updated operator
// */
//Observable.of(2,2,3,4,4)
//  .skip(while: { $0 % 2 == 0} ).subscribe(onNext: {print($0)
//  }).disposed(by: disposeBag)

//MARK: Skip Until
///*
// This operator will wait the triger, until the triger has been met, the subscriber will get the next event (not the trigger)
// */
//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject.skip(until: trigger)
//  .subscribe(onNext: {print($0)
//  }).disposed(by: disposeBag)
//
////Will be ignored because there is no trigger yet.
//subject.onNext("A")
//subject.onNext("B")
//
////Triggering the subscriber.
//trigger.onNext("X")
//
//subject.onNext("C")

//MARK: Take
///*
// This operator will take the item of the sequence as much as the value that is assigned to .take()
// */
//Observable.of(1,2,3,4,5,6)
//  .take(3).subscribe(onNext: {
//    print($0)
//  }).disposed(by: disposeBag)

//MARK: Take While
///*
// This Operator will take  the value of the event that is matched with the filter take(while:)
//
// -> Updated version takeWhile
// */
//Observable.of(2,4,6,7,8,10)
//  .take(while: {
//    return $0 % 2 == 0
//  }).subscribe(onNext: {
//    print($0)
//  }).disposed(by: disposeBag)

//MARK: Take Until
///*
// This operator will select the value of the event until the trigger condition is trigger.
//
// So if it's triggered, th
// */
//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject.take(until: trigger).subscribe(onNext: {
//    print($0)
//  }).disposed(by: disposeBag)
//
//subject.onNext("1")
//subject.onNext("2")
//
//trigger.onNext("X")
//
//subject.onNext("3")


//MARK: -TRANSFORMING OPERATORS
/*
 Allow us to change the observable data into a new sequence, transform it into a sequence that we are looking for.
 
 -> Could be prepping from data which is coming from an observable that we may need to bind to a collection view or a table view.
 -> Could be data that is coming from a Web Service and we want to transform it into a different form
 */

//MARK: To Array
///*
// Transform particular sequence into an array that contains the sequence's elements.
// */
//Observable.of(1,2,3,4,5)
//.toArray()
//.subscribe(onSuccess: {
//  //To get the value, rather than using onNext, it can use onSuccess
//        print($0)
//    }).disposed(by: disposeBag)

//MARK: Map
///*
// Map will go through on each element of the sequence, and perform operation we want on each element.
// It will create a new other sequence.
// */
//Observable.of(1,2,3,4,5)
//  .map {
//    return $0 * 2
//  }.subscribe(onNext: {
//    print($0)
//  }).disposed(by: disposeBag)

//MARK: Flat Map
///*
// Flat Map will project and transform an observable value and then flattens it down to a target observable
// */
//
//struct Student {
//  var score: BehaviorRelay<Int>
//}
//
//let john = Student(score: BehaviorRelay(value: 75))
//let mary = Student(score: BehaviorRelay(value: 95))
//
//let student = PublishSubject<Student>()
//
//student.asObservable()
//  .flatMap { $0.score.asObservable()}
//  .subscribe(onNext: {print($0)
//  }).disposed(by: disposeBag)
//
//student.onNext(john)
//john.score.accept(100) //Changing the Score
//
//student.onNext(mary)
//
//john.score.accept(80) //Changing the Score
//john.score.accept(43) //Changing the Score
//
///*
// When the values changes, it will fire the subscription.
//
// FlatMap  keeps tracking all things again and again <- this is what it means to "flattend down to a target observable"
// -> Even though it's tracking mary, it also keeps tracking john
//
// -> Great for changing the internal observable and  flattening it out and returning an observable.
// */
//

//MARK: Flat Map Latest
///*
// FlatMap Latest will only observes to the latest observable
// */
//
//struct Student {
//  var score: BehaviorRelay<Int>
//}
//
//let john = Student(score: BehaviorRelay(value: 75))
//let mary = Student(score: BehaviorRelay(value: 95))
//
//let student = PublishSubject<Student>()
//
//student.asObservable()
//  .flatMapLatest{
//    $0.score
//      .asObservable()
//  }.subscribe(onNext: {
//    print($0)
//  }).disposed(by: disposeBag)
//
//student.onNext(john)
//john.score.accept(100)
//
//student.onNext(mary)
//john.score.accept(45)


//MARK: -COMBINING OPERATORS

//MARK: Starts With

//let numbers = Observable.of(2,3,4)
//
//let observable = numbers.startWith(1)
//observable.subscribe(onNext: {
//  print($0)
//}).disposed(by: disposeBag)

//MARK: Concat
//let first = Observable.of(1,2,3)
//let second = Observable.of(4,5,6)
//
//let observable = Observable.concat([first,second])
//
//observable.subscribe(onNext: {
//  print($0)
//}).disposed(by: disposeBag)

//MARK: Merge
//let left = PublishSubject<Int>()
//let right = PublishSubject<Int>()
//
//let source = Observable.of(left.asObservable(),right.asObservable())
//
//let observable = source.merge()
//observable.subscribe(onNext: {
//  print($0)
//}).disposed(by: disposeBag)
//
//left.onNext(5)
//left.onNext(3)
//right.onNext(2)
//right.onNext(1)
//left.onNext(99)

//MARK: Combine Latest
//let left = PublishSubject<Int>()
//let right = PublishSubject<Int>()
//
//
//let observable = Observable.combineLatest(left,right,resultSelector: {
//  lastLeft, lastRight in "\(lastLeft) \(lastRight)"
//})
//
//let disposable = observable.subscribe(onNext: {
//  value in print(value)
//})
//
//left.onNext(45)
//right.onNext(1)
//left.onNext(30)
//right.onNext(99)
//right.onNext(2)

//MARK: With Latest From
//
//let button = PublishSubject<Void>()
//let textField = PublishSubject<String>()
//
//let observable = button.withLatestFrom(textField)
//let disposable = observable.subscribe(onNext: {
//  print($0)
//})
//
//textField.onNext("Sw")
//textField.onNext("Swif")
//textField.onNext("Swift")
//textField.onNext("Swift Rocks!")
//
//button.onNext(())
//button.onNext(())

//MARK: Reduce
//
//let source = Observable.of(1,2,3)
//
//source.reduce(0,accumulator: +)
//  .subscribe(onNext: {
//    print($0)
//  }).disposed(by: disposeBag)
//
//source.reduce(0,accumulator: {
//  summary, newValue in
//  return summary + newValue
//}).subscribe(onNext: {
//  print($0)
//}).disposed(by: disposeBag)

//MARK: Scan
//
//let source = Observable.of(1,2,3,5,6)
//
//source.scan(0,accumulator: +)
//  .subscribe(onNext: {
//    print($0)
//  }).disposed(by: disposeBag)


//MARK: - ERROR HANDLING

//MARK: Throwing Erros

//MARK: Handle Errors with Catch

//MARK: Retrying Error

