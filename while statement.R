 x <- 1
 while (x < 5 ) {
   x <- x + 1
   print(x)
 }
 
 # Using while statement with break
 y <-  1
 while (x < 10) {
   print(y)
   y <-  y + 1
   if (y == 6) {
     break
   }
 }
 
 # using while statement with next (next is just like continue in python)
 z <-  2
 while (z < 10) {
   z <- z + 1
   if (z == 8) {
     next
   }
   print(z)
 }