import java.io.*;

class random {
    public static void main (String args[]) throws IOException {
        int N=Integer.parseInt(args[1]);
        try{

            float sumofdisks1=0;
            float sumofdisks2=0;
            java.util.Random random = new java.util.Random();
            for (int x=1; x<=10;x++) {
                String fakelos= N +"_"+ x+".txt";
                File file = new File(args[0]+"\\"+fakelos);
                file.createNewFile();
                FileWriter fw = new FileWriter(file);
                BufferedWriter writer = new BufferedWriter(fw);
                for (int j = 0; j < N; j++) {
                    writer.write((Integer.toString(random.nextInt(1000001))));
                    writer.write("\n");
                }
                writer.close();

                System.out.println("file number "+x);

                BufferedReader br = new BufferedReader(new FileReader(file));
                MaxPQ diskoi=new MaxPQ();
                String st;


                int[] pinakas=new int[0];
                while ((st = br.readLine()) != null){
                    //Edw diavazetai kathe stoixeio kai ginetai elegxos  sto if , wste ean dothhke kati panw apo 1TB , na termatistei to programma
                    int memory=Integer.parseInt(st);
                    if (memory>1000000){
                        System.out.println("Memory need must be less than 1TB");
                        System.exit(0);
                    }else{
                        int[] temppinakas=new int[pinakas.length+1];
                        System.arraycopy(pinakas, 0, temppinakas, 0, pinakas.length);
                        pinakas=temppinakas;
                        pinakas[pinakas.length-1]=memory;
                    }
                }


                int metrhthskey=0;
                for (int i=0;i<pinakas.length;i++){

                    if (diskoi.size()>0 && diskoi.peek().folders.getFreeSpace()>=pinakas[i]){
                        Disk temp=diskoi.getMax();
                        temp.folders.put(pinakas[i]);
                        diskoi.add(temp);
                    }else{
                        Disk temp=new Disk(metrhthskey);
                        temp.folders.put(pinakas[i]);
                        diskoi.add(temp);
                        metrhthskey++;
                    }
                }


                long sum=0;
                for (int i=0;i<diskoi.size();i++){
                    sum=sum+(1000000-diskoi.getDisk(i).folders.getFreeSpace());
                }




                System.out.println("Sum of all folders =  "+(sum/1000000)+" TB ");
                System.out.println("Total number of disks used = " + (diskoi.size()));
                sumofdisks1+=diskoi.size();








                pinakas=Sort.mergesort(pinakas,0,(pinakas.length-1));
                System.out.println("Sorted");
                MaxPQ newdiskoi=new MaxPQ();
                diskoi=newdiskoi;
                metrhthskey=0;
                for (int i=0;i<pinakas.length;i++){
                    if (diskoi.size()!=0 && diskoi.peek().folders.getFreeSpace()>=pinakas[i]){
                        Disk temp=diskoi.getMax();
                        temp.folders.put(pinakas[i]);
                        diskoi.add(temp);
                    }else{
                        Disk temp=new Disk(metrhthskey);
                        temp.folders.put(pinakas[i]);
                        diskoi.add(temp);
                        metrhthskey++;
                    }
                }


                sum=0;
                for (int i=0;i<diskoi.size();i++){
                    sum=sum+(1000000-diskoi.getDisk(i).folders.getFreeSpace());
                }

                System.out.println("file number "+x);
                System.out.println("Sum of all folders =  "+(sum/1000000)+" TB ");
                System.out.println("Total number of disks used = " + (diskoi.size()));
                System.out.println();
                sumofdisks2+=diskoi.size();
            }

            System.out.println("Average number of disks in the fist algorithm : "+ sumofdisks1/10);
            System.out.println("Average number of disks in the second algorithm : "+ sumofdisks2/10);

        } catch (IOException e) {
            throw new IOException();
        }
    }
}
