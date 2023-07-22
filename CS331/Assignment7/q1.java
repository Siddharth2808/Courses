import java.util.*;

public class Main{
    public static void main(String args[]) {
        HashMap<String, Integer> map = new HashMap<>();
        
        Scanner sc= new Scanner(System.in);
        System.out.print("Enter the string: ");  
        String str= sc.nextLine();
        sc.close();
        System.out.print("We are considering undirected edges, hence edges a-b and b-a are counted 1 time only.\n");
        System.out.print("These edges are part of alternating graphs :\n");
        int opp = 1, n = str.length();
        for(int i=0;i<n;i++) {
            for(int j=i+1;j<n;j++) {
                if(i==j) continue;
                String edge1 = String.valueOf(str.charAt(i)) + String.valueOf(str.charAt(j)),
                       edge2 = String.valueOf(str.charAt(j)) + String.valueOf(str.charAt(i));
                
                if(map.containsKey(edge1) || map.containsKey(edge2) ) continue;
                String tmp = "";
                for(int k=0;k<n;k++) {
                    if(str.charAt(k)==str.charAt(i) || str.charAt(k)==str.charAt(j)) {
                        tmp+=str.charAt(k);
                    }
                }
                int op = 1;
                for(int k=1;k<tmp.length();k++) {
                    if(tmp.charAt(k)==tmp.charAt(k-1)) {
                        op = 0; break;
                    }
                }
                if(op==1) {
                    System.out.println(edge1);
                    map.put(edge1, 1);
                }
            }
        }
        System.out.print("Hence, Number of edges are : "+ map.size());
    }
}