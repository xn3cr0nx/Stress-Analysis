from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis
from sklearn.metrics import classification_report,confusion_matrix
import numpy as np

dataset = np.genfromtxt('dataset_random.csv',delimiter=',')

X = dataset[:, 0:2]
y = dataset[:, 3]

print X[0:10]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33)
print 'X_train, X_test, y_train, y_test correttamente splittati'

##############################################
scaler = StandardScaler()
# Fit only to the training data
scaler.fit(X_train)
print 'Dati scalati correttamente'

##############################################
# Now apply the transformations to the data:
X_train = scaler.transform(X_train)
X_test = scaler.transform(X_test)
print 'Trasformazione applicata ai dati correttamente'

###############################################
# Next we create an instance of the model
clf = QuadraticDiscriminantAnalysis()
print 'LDA creato correttamente'

###############################################
print 'Fit dei dati in corso'
# Fit the training data to our model
clf.fit(X_train,y_train)
print 'Train eseguito con successo'
#print mlp

##################################################
predictions = clf.predict(X_test)
#print predictions
##################################################
print(confusion_matrix(y_test,predictions))


print(classification_report(y_test,predictions))

####################################################
#print len(mlp.coefs_)
#print len(mlp.coefs_[0])

#print len(mlp.intercepts_[0])
###################################################