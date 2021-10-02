# Transductive-SVM-and-Semi-definite-programming

Abstract
Our main objective is to learn the Kernel matrix from the Dataset which start with transductive approach and conclude it with inductive approach it is possible but computaional expensive unless we figure out iterative SDP solver.


Motivation for Problem

Kernel Method have changed the era of machine learning due to their capability of working with linear inference models and identifying nonlinear relationships among input data.These method can be applied to both Regresssion and Classification problem.
It was interesting problem for pre machine learning era to obtain method which are good enough to classfy non linear data and have ability to work with heterogenous data.Multi-layer percepton was another method which was in line with Kernel method.
Deep learning era have changed the scientific community significanlty due to their unexplainable performnace.Some people found them as black box which is generating the result based on Universal Approximation Theorem.Deep Learning is still more of Research tool rather than workhorse of market.People still try to first find the solution in Machine learning due to their computational efficiency.They have built on more rigorous mathematics. So people have started looking into it again How can we take advantages of kernel method in this deep Learning era. To understand and make our Neural network robust.

Conclusion

Started with basic SVM which provide good accuracy, when we have large no of labeled dataset.To get more insight about the classfied data. we should use ν-SVM.
If we have large partially labelled dataset. Transduction is the correct approach because we have the test data in our hand. So we can utilise it to learn the classfier.
I have found two Optimization technique to deal the Non convexity in Transduction problem:
1:Deterministic Annealing
2:Label Switching Heuristic
Another approach is to Learn the Kernel Matrix by con- training it to subset of positive semidefinite cone. Here we need to solve the SDP problem.We can generalize this to online learning case(where data is come one by one,In every iteration Size of kernel matrix increase by one ) If we able to solve the SDP problem iteratively than only we can make it computationally efficient.
