:timer.tc(fn ->
  for a <- 1..10,
      b <- 1..10,
      c <- 1..10,
      a * a + b * b == c * c,
      do: IO.inspect([a, b, c])
end)
|> IO.inspect()
