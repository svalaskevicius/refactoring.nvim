class Foo {
  def bar(): Unit = {
    val x = 42
    val y = 10
    // __PRINT_EXP_START
    println(s"┆Foo#bar┆ ╎x + y╎ ┊1┊: ${x + y}")// __PRINT_EXP_END
    println(x + y)
  }
}