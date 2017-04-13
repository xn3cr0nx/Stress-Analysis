from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import classification_report,confusion_matrix
from sklearn.model_selection import LeaveOneOut
import numpy as np

dataset_folder = '../../Dataset/'
dataset_path = dataset_folder + 'raw-dataset-with-features-and-zeros.csv'

dataset = np.genfromtxt(dataset_path,delimiter=',')

X = dataset[:, 0:31]
y = dataset[:, 32]

X_split = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],]
y_split = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],]

zeroindex = [4927, 12906, 15510, 20170, 23064, 24571, 31558, 36136, 42541, 47454, 54397, 56842, 60199, 65633, 71554, 77065]

#Split data chunk LOO
first = 0
for i in range(16):
	X_split[i] = X[first:zeroindex[i]-1]
	y_split[i] = y[first:zeroindex[i]-1]
	first = zeroindex[i]+1
print "Data Chunked"


mlp = MLPClassifier(hidden_layer_sizes=(100, 100, 100))
print "MLP created"

scaler = StandardScaler()

for i in range(15):
	X_train = X_split[i+1]
	y_train = y_split[i+1]
	for j in range(16):
		if j != i and j != i+1:
			X_train = np.concatenate((X_train, X_split[j])) 
			y_train = np.concatenate((y_train, y_split[j]))
	X_test = X_split[i]
	y_test = y_split[i]
	scaler.fit(X_train)
	X_train = scaler.transform(X_train)
	X_test = scaler.transform(X_test)
	print "fit in progress"
	mlp.fit(X_train,y_train)
	print "prediction"
	predictions = mlp.predict(X_test)
	print confusion_matrix(y_test,predictions)
	print classification_report(y_test,predictions, digits=4)



# X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33)
# print 'X_train, X_test, y_train, y_test correttamente splittati'

# ##############################################
# scaler = StandardScaler()
# # Fit only to the training data
# scaler.fit(X_train)
# print 'Dati scalati correttamente'

# ##############################################
# # Now apply the transformations to the data:
# X_train = scaler.transform(X_train)
# X_test = scaler.transform(X_test)
# print 'Trasformazione applicata ai dati correttamente'

# ###############################################
# # Next we create an instance of the model
# mlp = MLPClassifier(hidden_layer_sizes=(100, 100, 100))
# print 'MLP creato correttamente'

# ###############################################
# print 'Fit dei dati in corso'
# # Fit the training data to our model
# mlp.fit(X_train,y_train)
# print 'Train eseguito con successo'
# #print mlp

# ##################################################
# predictions = mlp.predict(X_test)
# #print predictions
# ##################################################
# print(confusion_matrix(y_test,predictions))


# print(classification_report(y_test,predictions, digits=4))

# ####################################################
# #print len(mlp.coefs_)
# #print len(mlp.coefs_[0])

# #print len(mlp.intercepts_[0])
# ###################################################
