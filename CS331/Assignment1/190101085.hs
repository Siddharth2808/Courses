--Kindly see the screenshot attached given in second file's exercise 2.1, for output.
-- To run this script first type "ghc (file_name)" in command prompt, then an exe file will be created , then type "file_name" again in terminal, you will able to see the output
--For question 1

double x = x + x
quadruple x = double (double x)
factorial n = product [1..n]
average ns = sum ns `div` length ns

-- For question 4
-- We can reverse the list and reversed list's head will give us desired tail

last1 xs = head (reverse xs)

-- Or we can drop all the elements of list ecept head and thatlist's head is our desired tail 

last2 xs = head (drop (length xs - 1) xs)


-- For question 5
-- We can use reverse to reverse the list, then tail function will remove the first element of that reversed list. Finally we can use reverse function again to get desired list

init1 xs = reverse (tail (reverse xs))

-- Else, we can recurisevly also do the same, note that empty list is giving error, base case's answer is empty list and recursive definition is self-explonatry

init2 [] = error "list should not be empty"
init2 [x] = []
init2 (x:xs) = x : init2 xs


main = do
    --Code for question 1
    print("This is the question 1 part of the code:")
    print("double 2 = " ++ show(double 2))
    print("factorial 10 = " ++ show(factorial 10))
    print("average [1,2,3,4,5] = " ++ show(average [1,2,3,4,5]))
    print("quadruple 2 = " ++ show(quadruple 2))
    print("2+3*4 = " ++ show(2+3*4))
    print("sqrt (3^2 + 4^2) = " ++ show(sqrt (3^2 + 4^2)))
    print("head[1,2,3,4,5] = " ++ show(head[1,2,3,4,5]))
    print("tail [1,2,3,4,5] = " ++ show(tail [1,2,3,4,5]))
    print("[1,2,3,4,5] !! 2 = " ++ show([1,2,3,4,5] !! 2))
    print("take 3 [1,2,3,4,5] = " ++ show(take 3 [1,2,3,4,5]))
    print("drop 3 [1,2,3,4,5] = " ++ show(drop 3 [1,2,3,4,5]))
    print("length [1,2,3,4,5] = " ++ show(length [1,2,3,4,5]))
    print("sum [1,2,3,4,5] = " ++ show(sum [1,2,3,4,5]))
    print("product [1,2,3,4,5] = " ++ show(product [1,2,3,4,5]))
    print("[1,2,3] ++ [4,5] = " ++ show([1,2,3] ++ [4,5]))
    print("reverse [1,2,3,4,5] = " ++ show(reverse [1,2,3,4,5]))
    
    --Code for question 4
    print("This is the question 4 part of the code:")
    print("For Question 4 we are taking input as [1,2,3,4,5] answer should be 5")
    print ("using function1 we get") 
    print (last1 [1,2,3,4,5])
    print ("using function2 we get") 
    print (last2 [1,2,3,4,5])
    print ("Hence using both functions we are getting right answers.")
    
    --Code for question 5
    print("This is the question 5 part of the code:")
    print("For Question 5 we are taking input as [1,2,3,4,5] answer should be [1,2,3,4]")
    print ("using function1 we get") 
    print (init1 [1,2,3,4,5])
    print ("using function2 we get") 
    print (init2 [1,2,3,4,5])
    print ("Hence using both functions we are getting right answers.")