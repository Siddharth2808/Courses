-- 190101085, Siddharth Charan
-- Type ghc 190101085.hs in terminal to run the script
-- Then , type 190101085 and you are in the game.
-- Then in ghci terminal type play(Call play function)
-- We assume that the initial list supplied has all entries > 0
-- Each number is entered in a separate line
import Data.Char

-- Obtain target list, it takes list provided by player 1 as input and gives equal size list filled with 0s as output.
getTargetList ls = do {
    return [0 | _ <- [1..length ls]];
}

-- replace nth element of a list
replaceNth _ _ [] = []
replaceNth n val (x:xs)
    | (n==0) = val:xs
    | otherwise = x:(replaceNth (n-1) val xs)



--These 3 functions take care of validiy checking while taking input
takeInput endChar = do x <- getChar
                       if x == endChar then
                         return []
                       else
                         do y <- takeInput endChar
                            return (x:y)

takeInputNumber endOfNum = do xs <- takeInput endOfNum
                              if all (isDigit) xs then
                                return (sum [first*second | (first,second) <- zip (reverse ( map digitToInt xs ))  (iterate (*10) 1) ] , True)
                              else
                                return (0,False)

takeInputList = do (num, isValidNum) <- takeInputNumber '\n'
                   if isValidNum == False then
                     return []
                   else
                     do nums <- takeInputList
                        return (num:nums)

-- play the game between two players
playAMove ls player target
    | (ls == target) = do{
        if (player == 0) then
            putStrLn "Game over, Player-2 wins!!";
        else
            putStrLn "Game Over, Player-1 wins!!";
    }
    | otherwise = do{
        if (player == 1) then
            putStrLn "Player-2 your turn now..";
        else
            putStrLn "Player-1 your turn now..";
         
        putStrLn "Please enter move number (1 for reduce / 2 for split):";
        move <- getLine;
        if move=="1" then
            do{
                putStrLn "Enter the index of element you want to reduce";
                (index, isVaildPos)  <- takeInputNumber '\n';
                if isVaildPos == False then
                  do putStrLn "Error: Position should be a number between 1 and length of list."
                     playAMove ls player target; 
                else 
                  if (index >=1 && index<=(length ls)) == False then
                  do  putStrLn "Invalid input! Please enter input again. Your index should be from 1 to listSize."
                      playAMove ls player target;
                  else do
                      let v = ls !! (index-1);
                      putStr "Enter the value by which you want to reduce ";
                      putStrLn(show(v));
                      (val, isVaildval)  <- takeInputNumber '\n';
                      if isVaildval == False then
                         do putStrLn "Hi Ha Ha, what are you doing? Error: Reduce value should be a number."
                            playAMove ls player target; 
                      else
                         if val<=0 || val>v then do
                            putStrLn "Invalid input! Please enter input again."
                            playAMove ls player target;
                         else do
                            let newLs = replaceNth (index-1) (v-val) ls;
                            print("The modified list is:" ++ show(newLs));
                            playAMove newLs (1-player) target;  
            }
        else if move=="2" then
            do{
                putStrLn "Enter the index of element you want to split";
                (index, isVaildPos)  <- takeInputNumber '\n';
                if isVaildPos == False then
                  do putStrLn "Error: Position should be a number between 1 and length of list."
                     playAMove ls player target; 
                else
                   if  (index >=1 && index<=(length ls)) == False then do
                       putStrLn "Invalid input! Please enter input again. Your index should be from 1 to listSize"
                       playAMove ls player target;
                   else do
                       let v = ls !! (index-1);
                       putStr "Split number ";
                       putStr(show(v));
                       putStrLn " into 2 parts such that both are positive";
                       (x, isValidx)  <- takeInputNumber '\n';
                       (y, isValidy)  <- takeInputNumber '\n';
                       if isValidx == False || isValidy == False then
                         do putStrLn "Error: split values should be a number."
                            playAMove ls player target; 
                       else 
                          if (y+x /= v) then
                              do{
                                  print("Try again, sum of input numbers is not equals to element you want to spilt");
                                  playAMove ls player target;
                              }
                          else if (x<=0) then
                              do{
                                  print("Oh no!!!, Invalid input(num1<=0)!! Try again");
                                  playAMove ls player target;
                              }
                          else if (y<=0) then
                              do{
                                  print("Pay attention, Invalid input(num2<=0)!! Try again");
                                  playAMove ls player target;
                              }
                          else do
                              let ts = replaceNth (index-1) x ls;
                              let (z,z') = splitAt (index-1) ts;
                              let xs = z ++ [y] ++ z';
                              print("The modified list is:" ++ show(xs));
                              target <- getTargetList xs;
                              playAMove xs (1-player) (target); 
                        
            }
        else do
            putStrLn "Invalid move number, please enter either 1/2";
            playAMove ls player target;

    } 

--Main function which allow you toplay a game
play = do
    putStrLn "Welcome"
    putStrLn "Game Rules:"
    putStrLn "1. 2 players will be playing this game."
    putStrLn "2. Valid inputs are integers only."
    putStrLn "3. List will be entered by the player-1 before beginning the game." 
    putStrLn "4. You can either split or reduce the list"
    putStrLn "5. Use 2 for split and 1 for reduce."
    putStrLn "6. Inputs are taken as 1 indexed."
    putStrLn "7. Game ends when all elements of list are 0\n"
    putStrLn "Player-1, please enter elements, each in a new Line. Empty line will be considered 0."
    putStrLn "After entering all the number enter negative number or any character to terminate the list.";
    ls <- takeInputList;
    if null ls then do
      putStrLn "Empty List given as input. Exiting...\n";
    else do
      print("The initial list is: " ++show(ls));
      target <- getTargetList ls;
      if(target == ls) then do
          print("Player-1, this is against the spirit of the game, don't given list with only 0s.");
      else do
          playAMove ls 1 target;


main = do{
          play;
}