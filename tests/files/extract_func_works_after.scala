class Foo {
  private def baz(a: P, b: P, x: Int): Unit = {
    val c = a + b
    println(c)
    x + c
  }

  def bar(x: Int): Int = {
    val a = 1
    val b = 2
    baz(a, b, x)
  }
}
