#include <string>
#include <iostream>
#include <thread>
#include <future>
#include <math.h>
using namespace std;

double bigTask(double x, double z)
{
    return(x*x + z*z);
}

int main()
{
    int DataLength = 30,
        ThreadNum = 10;

    double StoredData[DataLength],
           InData[DataLength][2];
    future<double> WorkerThreads[ThreadNum];

    for(int iter = 0;iter< DataLength;iter++ ){
       StoredData[iter] = 0;
       InData[iter][0] = iter;
       InData[iter][1] = -1.5*iter;
    }

    cout << "before: ";
    for(int iter = 0;iter< DataLength;iter++ ){
        cout << StoredData[iter] << " ";
    }
    cout << "\n";

    int Check1 = 0;
    int step = 0;
    for(int iter = 0;iter< floor(DataLength/ThreadNum);iter++ ){

        for(int ThreadIter = 0;ThreadIter < ThreadNum;ThreadIter++ ){
            step = Check1 + ThreadIter;
            WorkerThreads[ThreadIter] =
async(launch::async,bigTask,InData[step][0],InData[step][1]);
        }
        step = 0;

        for(int ThreadIter = 0;ThreadIter < ThreadNum;ThreadIter++ ){
            step = Check1 + ThreadIter;
            StoredData[step] = WorkerThreads[ThreadIter].get();
            //cout << step << " " << StoredData[step] << "\n";
        }
        Check1 = step+1;
        step = 0;
    }

    step = 0;
    for(int iter = Check1;iter < DataLength;iter++ ){
         if( step > ThreadNum ){ cout << "Error 1\n"; }
         WorkerThreads[step] =
async(launch::async,bigTask,InData[iter][0],InData[iter][1]);
         step++;
    }

    step = 0;
    for(int iter = Check1;iter < DataLength;iter++ ){
        if( step > ThreadNum ){ cout << "Error 1\n"; }
        StoredData[iter] = WorkerThreads[step].get();
        step++;
        //cout << iter << " " << StoredData[iter] << "\n";
    }

    cout << "after: ";
    for(int iter = 0;iter< DataLength;iter++ ){
        cout << StoredData[iter] << " ";
    }
    cout << "\n";

    return(0);
}


