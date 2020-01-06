# Detecting-presence-and-absence-of-CVD-diseases
We wish to predict the presence or absence of cardiovascular diseases in patients’ body on the basis of available parameters
The dataset taken in consideration for this project is based on Cardiovascular disease (CVD) detection, which contains 70,000 records of patient’s data in 12 features, such gender, systolic blood pressure, diastolic blood pressure, etc.  The target variable is denoted by ‘cardio’ which is binary as ‘0’ represents absence of the CVD and ‘1’ represents presence of CVD.
The input features are divided into three categories:
1.	Objective: Describes factual information.
2.	Examination: Describes the result of medical examination.
3.	Subjective: Describes the information obtained by patients
In this project, we started with data selection with respect to CVD. Further we have preprocessed data in order to be more precise and accurate while running through model. We started with creating data dictionary and storing the data into same. 
In next step we performed data cleaning by removing the unwanted, NA and duplicate data values, which finally resulted in removal of approximately 12,000 rows out of total 70,000. 
After performing data cleaning, we performed various method like descriptive and inferential statistics to check if the data set is standardized or not. Moving on we scaled the data by bring down the mean to 0 and standard deviation to 1 and normalization which resulted the range of values between 0 and 1.  
As an add-on we have performed data featuring by adding additional feature of BMI in order to enhance the accuracy of our models. For predicting the presence or absence of CVD we have implemented 3 different models namely Naïve Bayes, Random forest and XGBoost. We were able to achieve 70% of accuracy after performing naïve Bayes and 73% with Random Forest which gave the output in the form of confusion matrix. 
After implementing and running 3rd model which is XGBoost we were able to achieve the maximum accuracy of 80%. Finally, on an average we have implemented our project with average accuracy of 70%. 
This project can be used to provide early notifications based on the data collected from patients and other monitoring devices used for medical examinations. 
By using the model, we can detect the presence of CVD among the patients in less time and this can lead to improved medical support and further required treatment. For future scope our model results can be improved by using cross-validation for testing model and performing hyper tuning the parameter of models by using different methods like grid random search
