import java.util.concurrent.Semaphore;

public class assignment {
    static int trains = 5;
    static int sections = 18;
    static int signals = 8;
    
    static boolean[] isFree;
    static Train train[] = new Train[trains];
    static Section section[] = new Section[sections];
    static Thread trainThread[] = new Thread[trains];

    public static class Section {
		
		private Semaphore mutex = new Semaphore(1);

		boolean isFree(){
			int x = mutex.availablePermits();
			return (x >= 1);
		}

		void aquireSection(){
			try { mutex.acquire(); } catch(Exception e) {}
		} 

		void leaveSection() {
			try { mutex.release(); } catch(Exception e) {
                System.out.println("red light on!");
            }
		}
	}

    public static class Train implements Runnable {
        public int direction, sectionId, trainId;

        public synchronized void trainUpdate() {
            int[] pos = new int[2];
            pos[0] = -1;
            pos[1] = -1;
            if(direction == 1 && (sectionId == 16 || sectionId == 17)) {
                direction = -1;
                return;
            }

            if(direction == -1 && (sectionId == 0 || sectionId == 1)) {
                direction = 1;
                return;
            }
            if(direction==1) {
                if(sectionId % 2 == 0) {
                    pos[0] = sectionId + 2;
                    pos[1] = sectionId + 3;
                } else {
                    pos[0] = sectionId + 1;
                    pos[1] = sectionId + 2;
                }
            }
            else  {
                if(sectionId % 2 == 0) {
                    pos[0] = sectionId - 2;
                    pos[1] = sectionId - 1;
                } else {
                    pos[0] = sectionId - 3;
                    pos[1] = sectionId - 2;
                }
            }

            for(int i = 0; i < 2; ++i) {
                int curr=pos[i], adj;
                if(curr%2==1) adj=curr-1;
                else adj=curr+1;
                int mn=-1;
                if(adj<curr) mn=adj; 
                else mn=curr;
                //DEADLOCK detection
                if(mn>=2 && direction==-1 && (!section[adj].isFree() && !section[mn-2].isFree() && !section[mn-1].isFree())) {
                    System.out.println("[Deadlock Avoided]");
                    break;
                }
                if(mn<=15 && direction==1 && (!section[adj].isFree() &&!section[mn+2].isFree() && !section[mn+3].isFree())) {
                    System.out.println("[Deadlock Avoided]");
                    break;
                }

                if(section[pos[i]].isFree()) {
                    section[pos[i]].aquireSection();
                    section[sectionId].leaveSection();
                    System.out.println("[Time:" + System.nanoTime() + "] " + "Train: " + trainId + " moved from [section " + sectionId + ", station " + (sectionId/4 + 1) +"] " + " to [section " + pos[i] + ", station " + (pos[i]/4 + 1)+"]");
                    sectionId = pos[i];
                    break;
                }
            }
        }

        public void run() {
            while(true) {
                trainUpdate();
                try { Thread.sleep(1000); } catch (Exception e) {}
            }
        }
    }

    public static void main(String argv[]) {
        for(int i = 0; i < sections; ++i) {
            section[i] = new Section();
        }

        for(int i = 0; i < trains; ++i) {
            train[i] = new Train();
            train[i].direction = (i == 0 ? 1 : -1);
            train[i].sectionId = (4 * i + 1);
            train[i].trainId = i;
        
            trainThread[i] = new Thread(train[i]);
        }

        for(int i = 0; i < trains; ++i) {
            trainThread[i].start();
        }
    }
}

/* Section IDS
0 2 4 6 8 10 12 14 16
1 3 5 7 9 11 13 15 17
*/