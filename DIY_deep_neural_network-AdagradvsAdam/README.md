DIY neural network with one hidden layer. Comparison between training with Adagrad and Adam optimization algorithms in solving a classification problem.
I used the 'Avila' data set which consists of 20867 data instances with 10 attributes each.

The program runs on calling 'train' function

Benchmark : 
| epoch | AdaGrad accuracy | Adam accuracy    |
| ----- | -------------    | ---------------- |
| 20    | 63.30%           | 73.43%           |
| 50    | 66.30%           | 78.18%           |
| 100   | 68.69%           | 80.91%           |
| 150   | 70.36%           | 83.03%           |
| 250   | 72.36%           | 85.85%           |

The training and testing data can be found here :

https://archive.ics.uci.edu/ml/datasets/Avila#

