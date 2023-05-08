fun main() {

    // INTEGER (INT)
    var number: Int = 22

    // Will get maximum value that Int can store
    val maxIntegerValue: Int = Int.MAX_VALUE
    // will get minimum value that Int can store
    val minIntegerValue: Int = Int.MIN_VALUE
    println("Integer Max: $maxIntegerValue")
    println("Integer Min: $minIntegerValue")

    /*
Maximum Value that Int can contain is 2147483647,
Minimum Value that Int can contain is -2147483648

number = 2147483648 -> Will result error
*/

    //BYTE
    val myMaxByteValue: Byte = Byte.MAX_VALUE
    val myMinByteValue: Byte = Byte.MIN_VALUE
    println("Byte Max: $myMaxByteValue")
    println("Byte Min: $myMinByteValue")

    /*
Maximum Value that Byte can contain is 127,
Minimum Value that Byte can contain is -128

number = 128 -> Will result error
*/

    //Short
    val myMaxShortValue: Short = Short.MAX_VALUE
    val myMinShortValue: Short = Short.MIN_VALUE
    println("Short Max: $myMaxShortValue")
    println("Short Min: $myMinShortValue")

    /*
Maximum Value that Short can contain is 32767,
Minimum Value that Short can contain is -32768

number = 32768 -> Will result error
*/

    //Long
    val myMaxLongValue: Long = Long.MAX_VALUE
    val myMinlongValue: Long = Long.MIN_VALUE
    println("Short Max: $myMaxLongValue")
    println("Short Min: $myMinlongValue")

    /*
Maximum Value that long can contain is 9223372036854775807,
Minimum Value that Long can contain is -9223372036854775808

number = 9223372036854775807 -> Will result error
*/

    // Default Data Type is Integer, and other Data Type should be stated clearly

    //THIS IS HOW TO STATE

    val longNumber = 28L
    //will become Long
    /* Or you can just input initial input with the number,
    and the IDE will infer it's on the lowest data type that actually
    could hold it.

    Like this constant below:
    */

    val secondLongNumber = 29999999999


}