class Foo {
  def bar(): Unit = {
    val x = 42
    // __PRINT_VAR_START
    println(s"┆Foo#bar┆ ╎x╎ ┊1┊: ${x}")// __PRINT_VAR_END
    println(x)
  }
}