Course Project Code Book
========================

Study Design
------------

The raw data comes from University of California at Irvine's Machine Learning Repository. Specifically, it's from Human Activity Recognition Using Smartphones Data Set, which can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Code Book
---------

The first two columns of the tidy data are the Subject and Activity respectively. The dataset had 30 subjects (so the range of the Subject column is 1-30), and there were six activities recorded. Specifically, the activites recorded were "Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", and "Laying". The rest of the columns were the following (note that the measurements are normalized and therefore unitless):

* Mean and standard deviation of time domain body acceleration in X,Y,Z directions
	* TBodyAccMeanX           
	* TBodyAccMeanY
	* TBodyAccMeanZ            
	* TBodyAccStdX            
	* TBodyAccStdY             
	* TBodyAccStdZ             
* Mean and standard deviation of time domain gravitational acceleration in X,Y,Z directions
	* TGravityAccMeanX        
	* TGravityAccMeanY         
	* TGravityAccMeanZ         
	* TGravityAccStdX         
	* TGravityAccStdY          
	* TGravityAccStdZ
* Mean and standard deviation of time domain body jerk acceleration in X,Y,Z directions          
	* TBodyAccJerkMeanX       
	* TBodyAccJerkMeanY        
	* TBodyAccJerkMeanZ        
	* TBodyAccJerkStdX        
	* TBodyAccJerkStdY         
	* TBodyAccJerkStdZ
* Mean and standard deviation of time domain body gyration in X,Y,Z directions            
	* TBodyGyroMeanX          
	* TBodyGyroMeanY           
	* TBodyGyroMeanZ           
	* TBodyGyroStdX           
	* TBodyGyroStdY            
	* TBodyGyroStdZ     
* Mean and standard deviation of time domain body jerk gyration in X,Y,Z directions            
	* TBodyGyroJerkMeanX      
	* TBodyGyroJerkMeanY       
	* TBodyGyroJerkMeanZ       
	* TBodyGyroJerkStdX       
	* TBodyGyroJerkStdY        
	* TBodyGyroJerkStdZ
* Mean and standard deviation of the magnitude of the time domain body accelaration
	* TBodyAccMagMean         
	* TBodyAccMagStd
* Mean and standard deviation of the magnitude of the time domain gravitational accelaration
	* TGravityAccMagMean       
	* TGravityAccMagStd       
* Mean and standard deviation of the magnitude of the time domain jerk accelaration
	* TBodyAccJerkMagMean      
	* TBodyAccJerkMagStd
* Mean and standard deviation of the magnitude of the time domain gyration
	* TBodyGyroMagMean        
	* TBodyGyroMagStd         
* Mean and standard deviation of the magnitude of the time domain jerk gyration
	* TBodyGyroJerkMagMean     
	* TBodyGyroJerkMagStd
* Mean and standard deviation of frequency domain body acceleration in X,Y,Z directions                 
	* FBodyAccMeanX            
	* FBodyAccMeanY            
	* FBodyAccMeanZ           
	* FBodyAccStdX             
	* FBodyAccStdY             
	* FBodyAccStdZ
* Mean and standard deviation of frequency domain body jerk acceleration in X,Y,Z directions                 
	* FBodyAccJerkMeanX        
	* FBodyAccJerkMeanY        
	* FBodyAccJerkMeanZ       
	* FBodyAccJerkStdX         
	* FBodyAccJerkStdY         
	* FBodyAccJerkStdZ
* Mean and standard deviation of frequency domain body gyration in X,Y,Z directions                         
	* FBodyGyroMeanX           
	* FBodyGyroMeanY           
	* FBodyGyroMeanZ          
	* FBodyGyroStdX            
	* FBodyGyroStdY            
	* FBodyGyroStdZ
* Mean and standard deviation of the magnitude of the frequency domain body accelaration           
	* FBodyAccMagMean          
	* FBodyAccMagStd
* Mean and standard deviation of the magnitude of the frequency domain jerk accelaration           
	* FBodyBodyAccJerkMagMean 
	* FBodyBodyAccJerkMagStd
* Mean and standard deviation of the magnitude of the frequency domain gyration  
	* FBodyBodyGyroMagMean     
	* FBodyBodyGyroMagStd    
* Mean and standard deviation of the magnitude of the frequency domain jerk gyration 
	* FBodyBodyGyroJerkMagMean 
	* FBodyBodyGyroJerkMagStd	