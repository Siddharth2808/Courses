
import java.math.BigInteger;
import java.util.*;

public class Main{
    public static BigInteger Checkroot(BigInteger k, BigInteger n) {
        BigInteger val1 = BigInteger.ONE, k1 = k.subtract(val1), s = n.add(val1), u = n;

        while (u.compareTo(s) == -1) {
            s = u;
            u = ((n.divide(u.pow(k1.intValue()))).add(u.multiply(k1))).divide(k);
        }
        return s;
    }

    public static void main(String[] args) {
        System.out.println("Please enter your BIG number");
        Scanner in = new Scanner(System.in);
        BigInteger n = in.nextBigInteger();
        in.close();

        int op = 0;
        for (int i = 2; i <= 4000; i++) {
            BigInteger I = BigInteger.valueOf(i);
            boolean b = (Checkroot(I, n).pow(I.intValue())).equals(n);
            if (b) {
                op = 1;
                break;
            }
        }

        if (op==1) { System.out.println("Yes, The number is of the form a^b!");} 
        else {System.out.println("No, The number is not of the form a^b!");}

    }
}