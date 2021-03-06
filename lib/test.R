######################################################
### Fit the classification model with testing data ###
######################################################

### Author: Wanting Cheng
### Project 2
### ADS Spring 2018

test <- function(model_spec, test_data, test.GBM = F, 
                 test.RF = F, test.NN = F, test.Ada = F, 
                 test.SVM = F, test.XGB = F){
  
  ### Fit the classfication model with testing data
  
  ### Input: 
  ###  - the fitted classification model using training data
  ###  -  processed features from testing images 
  ### Output: prediction
  
  ### load libraries
  
  if(test.GBM){
    library("gbm")
    
    pred <- predict(model_spec$model, test_data, n.trees = model_spec$params)
    pred <- ifelse((pred > 0.5),1,0)
    return(pred)
  }
  
  if(test.RF){
    pred <- predict(model_spec, test_data)
    return(pred)
  }
  
  if(test.NN){
    testx <- data.matrix(test_data, rownames.force = NA)
    testx <- unname(testx, force = FALSE)
    n <- ncol(testx)
    
    pred <- model_spec%>%
      predict_classes(testx)
    return(pred)
    
  }
  if(test.SVM){
    pred <- predict(model_spec, test_data)
    return(pred)
    
  }
  
  if(test.Ada){
    pred <- predict(model_spec$model, test_data, n.trees = model_spec$params)
    pred <- ifelse((pred > 0),1,0)
    return(pred)
  }
  if(test.XGB){
    pred <- predict(model_spec, data.matrix(test_data))
    pred <- ifelse((pred > 0.5),1,0)
    return(pred)
  }
  
}

