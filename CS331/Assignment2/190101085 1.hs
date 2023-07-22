--Siddharth Charan 190101085
-- For, n>100 function is simple and straight forward. We will recursively define this function for n<=100. Althought it is very easy to notice that for integers less than equals to 100, function will always produce 91.
f n
  | n <= 100   = f $ f $ n + 11
  | otherwise = n-10