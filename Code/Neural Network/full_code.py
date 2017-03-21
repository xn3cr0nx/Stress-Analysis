import random
import numpy as np
import first_neural_network as network

def vectorized_result(j):
    """Return a 3-dimensional unit vector with a 1.0 in the jth
    position and zeroes elsewhere.  This is used to convert a value
    (1...3) into a corresponding desired output from the neural
    network."""
    e = np.zeros((3, 1))
    e[int(j)-1] = 1.0
    return e

data = np.genfromtxt ('dataRandom.csv', delimiter=',')

# TODO: shuffle di 'data', cosi ogni volta training e test sono diversi

n_data = len(data[:,0])
HR = data[:,0]
GSR = data[:,1]
labels = data[:,3]

# Il vettore di input deve essere 2x1.
# Il vettore di output deve essere 3x1 per il training, 1x1 per il test

training_inputs = [np.reshape(x, (2,1)) for x in zip(HR, GSR)]
training_results = [vectorized_result(y) for y in labels]
training_data = zip(training_inputs, training_results)[:65000]
test_data = zip(training_inputs, labels)[65000:]


# migliori learning_rate: 1.2, 0.9
# migliori mini batch size: 70, 20
# migliori nodi hidden layer1: 350, 200
epochs = 37
mini_batch_size = 70
learning_rate = 1.2
filename = "hidden_layer(2).csv"
with open(filename, 'w') as log:
    log.write("NUMBER OF NODS,ACCURACY\n")


for i in xrange(17):
    
    print "NUMBER OF NODS:", 150+i*50
    # TODO: distruggere l'oggetto "net" in ogni ciclo
    net = network.Network([2, 350, 150+i*50, 3])
    net.SGD(training_data, epochs, mini_batch_size, learning_rate)
    results, n_test, accuracy = net.test_network(test_data)
    print "\n{0} / {1} \nAccuracy: {2}%".format(results, n_test, accuracy)
    with open(filename, 'a') as log:
        log.write("%i,%f\n" % (150+i*50,accuracy))

