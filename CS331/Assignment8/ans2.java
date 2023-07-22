import java.util.Scanner;

class Main {
    public static void main(String argv[]) {
        int timeslot = 0;
        int[] currentFloor = new int[2];
        int[] direction = new int[2];
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter number of floors: ");
        String data = sc.nextLine();
        System.out.println("");
        int N = Integer.parseInt(data);
        currentFloor[0] = 0; currentFloor[1] = N - 1;
        direction[0] = 1; direction[1] = -1; 
        int cnt = 0;
        int[][] requests = new int[N][N];
        for(int i = 0; i < N; ++i) {
            for(int j = 0; j < N; ++j) {
                requests[i][j] = 0;
            }
        }

        while(true) {
            System.out.println("\nTimeslot no: " + timeslot);
            
            if(direction[0]==1){
            System.out.println("Lift No: " + 1 + ", Current floor: " + currentFloor[0] + ", Going Up");
            }
            else{
            System.out.println("Lift No: " + 1 + ", Current floor: " + currentFloor[0] + ", Going Down ");
            }
            
            if(direction[1]==1){
            System.out.println("Lift No: " + 2 + ", Current floor: " + currentFloor[1] + ", Going Up");
            }
            else{
            System.out.println("Lift No: " + 2 + ", Current floor: " + currentFloor[1] + ", Going Down ");
            }
            
            while(true) {
                System.out.print("Enter the starting floor and destination floor: ");
                data = sc.nextLine();
                if(data.charAt(0) == '-') {
                    break;
                }
                data += ' ';
                int arr[] = new int [2];
                int index = 0;
                String temp = "";
                for(int i = 0; i < data.length(); ++i) {
                    if(data.charAt(i) == ' ' && index < 2) {
                        arr[index] = Integer.parseInt(temp);
                        index++;
                        temp = "";
                    } else {
                        temp += data.charAt(i);
                    }
                }
                if(requests[arr[0]][arr[1]] == 0) {
                    cnt++;
                }
                requests[arr[0]][arr[1]] = 1;
            }

            if(currentFloor[0] == 0) {
                direction[0] = 1;
                direction[1] = -1;
            }

            if(currentFloor[0] == N - 1) {
                direction[0] = -1;
                direction[1] = 1;
            }

            if(cnt == 0 && (currentFloor[0] == 0 || currentFloor[0] == N - 1)) {
                System.out.println("All requests are satisfied");
                break;
            }

            int up = -1, down = -1;
            if(direction[0] == 1) {
                up = currentFloor[0];
                down = currentFloor[1];
            } else {
                up = currentFloor[1];
                down = currentFloor[0];
            }

            for(int i = up + 1; i < N; ++i) {
                if(requests[up][i] == 1) {
                    requests[up][i] = 0;
                    cnt--;
                }
            }

            for(int i = down - 1; i >= 0; --i) {
                if(requests[down][i] == 1) {
                    requests[down][i] = 0;
                    cnt--;
                }
            }

            timeslot++;
            if(direction[0] == 1) {currentFloor[0]++;currentFloor[1]--;} 
            else {currentFloor[0]--; currentFloor[1]++;}
        }
        sc.close();
    }
}