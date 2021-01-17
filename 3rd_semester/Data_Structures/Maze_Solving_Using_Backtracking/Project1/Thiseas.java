//package com.company;
import java.io.*;
import java.util.Scanner;
import java.util.NoSuchElementException;


public class Thiseas {
    public static void main(String[] args) throws IOException {
        boolean noerrors=true;    //ginetai false an vrethei error sta stoixeia
        int arxikhs=-1;           //pairnei thn arxikh grammh
        int arxikhg=-1;           //pairnei thn arxikh sthlh
        int sthles=0;             //pairnei tis sthles tou pinaka
        int grammes=0;            //pairnei tis grammes tou pinaka
        StringQueueImpl queue=new StringQueueImpl();  //edw mpainoun arxika ta stoixeia pou diavazontai apo to txt
        try {
            File file = new File(args[0]);

            BufferedReader br = new BufferedReader(new FileReader(file));
            int counter=0;
            String st;

            while ((st = br.readLine()) != null){
                System.out.println(st);
                String[] arrOfStr = st.split(" ");

                for (String a : arrOfStr){
                    queue.put(a);
                    counter++;
                }
            }

            if (counter<8){
                System.out.println("There are not enough elements in the txt(less than 8)");
                noerrors=false;
            }else{
                grammes=Integer.parseInt(queue.get());
                sthles=Integer.parseInt(queue.get());
                arxikhg=Integer.parseInt(queue.get());
                arxikhs=Integer.parseInt(queue.get());
                if (queue.size()!=grammes*sthles){
                    noerrors=false;
                    System.out.println("the txts elements size is not equal to length*width");
                }
            }

        }
        catch (FileNotFoundException e) {
            throw new FileNotFoundException();
        }
        String [][] maze =new String[grammes][sthles];

        if (noerrors){
        int count1=0;
        int count0=0;
        int counte=0;
        for(int i=0;i<grammes;i++){
            for (int j=0;j<sthles;j++){
                maze[i][j]=queue.get();
                if (maze[i][j].equals("0")){
                    count0++;
                }else if(maze[i][j].equals("1")){
                    count1++;
                }else if(maze[i][j].equals("E")||maze[i][j].equals("Ε")){
                    counte++;
                }
            }
        }

        if (maze[arxikhg][arxikhs]=="0"||maze[arxikhg][arxikhs]=="1"){
            System.out.println("The given entrance is wrong") ;
            noerrors=false;
        }
        else if (counte>1){
            System.out.println("There are more than one entrances");
            noerrors=false;
        }else if ((count1+count0+counte)!=grammes*sthles){
            System.out.println("The elements are incorrect");
            noerrors=false;
        }
        }

        if (noerrors){

            StringStackImpl stack =new StringStackImpl();
            solution(maze,grammes,sthles,arxikhg,arxikhs,stack);
        }
    }


    //elegxei an vriskomaste ektos oriwn
    private static boolean isSafe(String[][] maze, int x, int y, int grammes, int steiles)
    {
        // if out of boundaries or maze[x][y]=="1" return false
        return (x >= 0 && x < grammes && y >= 0 && y < steiles && maze[x][y].equals( "0"));
    }



//Auto to void vriskei th lysh tou lavyrinthou, ean yparxei.


    private static void solution(String[][] maze, int grammes, int sthles, int startm, int startn, StringStackImpl stack) {

        int x = startm;
        int y = startn;
        if (isSafe(maze, x + 1, y, grammes, sthles)) {
            x++;
        } else if (isSafe(maze, x - 1, y, grammes, sthles)) {
            x--;
        } else if (isSafe(maze, x, y + 1, grammes, sthles)) {
            y++;
        } else if (isSafe(maze, x, y - 1, grammes, sthles)) {
            y--;
        }else{
            System.out.println("There is no solution");
        }
        stack.push(Integer.toString(startm));
        stack.push(Integer.toString(startn));



        boolean solved=false;
        while (!solved){



            if (isSafe(maze, x + 1, y, grammes, sthles)&& (haventbeenthere( stack, x+1, y))) {
                stack.push(Integer.toString(x));
                stack.push(Integer.toString(y));
                x++;
            } else if (isSafe(maze, x - 1, y, grammes, sthles)&&(haventbeenthere( stack, x-1, y))) {
                stack.push(Integer.toString(x));
                stack.push(Integer.toString(y));
                x--;
            } else if (isSafe(maze, x, y + 1, grammes, sthles)&&(haventbeenthere( stack, x, y+1))) {
                stack.push(Integer.toString(x));
                stack.push(Integer.toString(y));
                y++;
            } else if (isSafe(maze, x, y - 1, grammes, sthles)&&(haventbeenthere( stack, x, y-1))) {
                stack.push(Integer.toString(x));
                stack.push(Integer.toString(y));
                y--;
            }else{
                maze[x][y]="1";
                y=Integer.parseInt(stack.pop());
                x=Integer.parseInt(stack.pop());
            }

            if (x+1==grammes||y+1==sthles){
                solved=true;
            }

        }


        if (x!=startm&&y!=startn) {
            System.out.println("The end of the maze is "+x+","+y);
        }else{
            System.out.println("There is no solution");
        }
    }

    //auto to void xrhsimopoieitai gia na elegxoume ean h kinhsh pou skopevoume na kanoume tha mas paei sto shmeio pou hmastan prin
    static boolean haventbeenthere(StringStackImpl stack,int x,int y){
        int k=Integer.parseInt(stack.pop());
        int l=Integer.parseInt(stack.peek());
        stack.push(Integer.toString(k));
        return !(k==(y) && l==x);

    }
}