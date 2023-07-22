
import java.util.Scanner;
public class Main {
    public static void main(String[] args) throws Exception {
        Scanner input = new Scanner(System.in);
        System.out.println("Please, give number of Philosophers");
        int size = input.nextInt();
        Philosopher[] philosophers = new Philosopher[size];
        Object[] spoons = new Object[size];

        for (int i = 0; i < size; i++) {spoons[i] = new Object();}
        
        for (int i = 0; i < size; i++) {
            Object leftspoon = spoons[i];
            Object rightspoon = spoons[(i + 1) % spoons.length];

            // The last philosopher picks up the right spoon first
            if (i == size - 1) {philosophers[i] = new Philosopher(rightspoon, leftspoon);} 
            else {philosophers[i] = new Philosopher(leftspoon, rightspoon);}

            Thread t = new Thread(philosophers[i], "Philosopher " + (i + 1));
            t.start();
        }
    }
}

class Philosopher implements Runnable {
    // The spoons on either side of this Philosopher
    private Object leftspoon, rightspoon;

    public Philosopher(Object leftspoon, Object rightspoon) {
        this.leftspoon = leftspoon;
        this.rightspoon = rightspoon;
    }

    private void doAction(String action) throws InterruptedException {
        System.out.println(Thread.currentThread().getName() + " " + action);
        Thread.sleep(((int) (Math.random() * 100)));
    }

    public void run() {
    try {
        while (true) {
            // thinking
            doAction(": Thinking");
            synchronized (leftspoon) {
                doAction(": Picked up left spoon");
                synchronized (rightspoon) {
                    doAction(": Picked up right spoon, now he is eating");
                    doAction(": Put down right spoon");
                }
                // Back to thinking
                doAction(": Put down left spoon, Back to thinking.");
            }
        }
    } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return;
        }
    }
}