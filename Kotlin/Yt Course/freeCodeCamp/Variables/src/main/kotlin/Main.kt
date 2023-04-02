fun main() {

    /*
    Var = Variable
    will be able to be changed later on "variable"
     */

    var userName: String = "Fattah"
    val age: Int = 22

    //Changing Variable
    userName = "MAFattah"

    /*
    Val = Constant
    will not be able to be changed later on "variable"
    */
    val otherNameConstant: String = "Astrid"

    /*
    Kotlin is type inference,
    which means it can infer type from what is assigned on the variable,
    and it's still working perfectly
     */
    var fattahfavouriteThing = "Kucing"

    /*
    Kotlin is Statically Typed,
    which means will check the variable at compile time, not at run time
     */

    //userName = 5 //It will give error directly.
    println("$userName ($age)love $otherNameConstant")
}