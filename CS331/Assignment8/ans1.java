import java.util.Scanner;

class Main {
    public static void main(String argv[]) {
        int timeslot = 0, currentFloor = 0, floorToReach = -1, direction = 1;
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter number of floors: ");
        String data = sc.nextLine();
        System.out.println("");
        int N = Integer.parseInt(data);
        int cnt = 0;
        int[][] requests = new int[N][N];
        for(int i = 0; i < N; ++i) {
            for(int j = 0; j < N; ++j) {
                requests[i][j] = 0;
            }
        }
        while(true) {
            System.out.println("\nTime: " + timeslot);
            if(direction== 1){System.out.println("Going Up");}
            else {System.out.println("Going Down");}
            System.out.println("Current floor: " + currentFloor);
            while(true) {
                System.out.print("Enter the starting floor and destination floor: ");
                data = sc.nextLine();
                if(data.charAt(0) == '-') { break;}
                
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
                if(requests[arr[0]][arr[1]] == 0) {cnt++;}
                requests[arr[0]][arr[1]] = 1;
            }

            if(cnt == 0 && currentFloor == floorToReach) {
                System.out.println("All requests are satisfied");
                break;
            }

            if(currentFloor == N - 1 && direction == 1) {
                direction = -1;
                floorToReach = N - 1;
            }

            if(currentFloor == 0 && direction == -1) {
                direction = 1;
                floorToReach = -1;
            }

            if(direction == 1) {
                for(int i = currentFloor + 1; i < N; ++i) {
                    if(requests[currentFloor][i] == 1) {
                        cnt--;
                        if(cnt == 0) {
                            floorToReach = i;
                        }
                        requests[currentFloor][i] = 0;
                        floorToReach = Math.max(floorToReach, i);
                    }
                }
            } else {
                for(int i = currentFloor - 1; i >= 0; --i) {
                    if(requests[currentFloor][i] == 1) {
                        cnt--;
                        if(cnt == 0) {floorToReach = i;}
                        
                        requests[currentFloor][i] = 0;
                        floorToReach = Math.min(floorToReach, i);
                    }
                }
            }

            timeslot++;
            if(direction == 1) {currentFloor++;}
            else {currentFloor--;}
        }
        sc.close();
    }
}