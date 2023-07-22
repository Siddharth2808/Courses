import java.util.*;

public class Main {
    public static void main(String args[]) {
        System.out.println("Please put the string first in below line and hit enter after that put integer and hit enter to get desired output.");
        Scanner scn = new Scanner(System.in);
        String str = scn.nextLine(), tmpStr = "";
        int n = scn.nextInt(), size = str.length();;
        scn.close();
        
        System.out.println("The generated strings are:");

        HashMap<String, Integer> map = new HashMap<>();
        for(int i= size-1;i>=0;i--)
        { String c= String.valueOf(str.charAt(i));
            if (!map.containsKey(c)) {tmpStr= c+tmpStr;map.put(c, 1);}
        }
        for(int i=n;i>=0;i--) {
            str+=tmpStr;
             System.out.println(str);
        }
    }
}