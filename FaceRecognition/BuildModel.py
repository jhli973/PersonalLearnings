#from __future__ import print_function
#import random
#import numpy as np

from keras.preprocessing.image import ImageDataGenerator
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation, Flatten
from keras.layers import Convolution2D, MaxPooling2D
from keras.optimizers import SGD
from keras.optimizers import Adagrad
from keras.optimizers import Adam
from keras.utils import np_utils
from keras.models import load_model
from keras import backend as K
from keras import callbacks

class Model(object):

    FILE_PATH = r'C:\Users\dbsnail\ImageProject\model_sgd.h5'

    def __init__(self):
        self.model = None

    def build_model(self, dataset, nb_classes=2):
        self.model = Sequential()

        self.model.add(Convolution2D(32, 3, 3, border_mode='same', activation = 'relu', input_shape=dataset.X_train.shape[1:]))
        self.model.add(Convolution2D(32, 3, 3, border_mode='same', activation = 'relu'))
        self.model.add(MaxPooling2D(pool_size=(2, 2)))
        self.model.add(Dropout(0.25))

        self.model.add(Convolution2D(64, 3, 3, border_mode='same', activation = 'relu'))
        self.model.add(Convolution2D(64, 3, 3, border_mode='same', activation = 'relu'))
        self.model.add(MaxPooling2D(pool_size=(2, 2)))
        self.model.add(Dropout(0.25))
        
        self.model.add(Convolution2D(96, 3, 3, border_mode='same', activation = 'relu'))
        self.model.add(Convolution2D(96, 3, 3, border_mode='same', activation = 'relu'))
        self.model.add(MaxPooling2D(pool_size=(2, 2)))
        self.model.add(Dropout(0.25))        

        self.model.add(Flatten())
        self.model.add(Dense(960))
        self.model.add(Activation('relu'))
        self.model.add(Dropout(0.5))
        self.model.add(Dense(nb_classes))
        self.model.add(Activation('softmax'))

        self.model.summary()
     
    def train(self, dataset, batch_size=65, nb_epoch=30, data_augmentation=True):
        
        # let's train the model using SGD + momentum (how original).
        #sgd = SGD(lr=0.01, decay=1e-6, momentum=0.9, nesterov=True) #acc: 99.58%
        #adagrad = Adagrad(lr=0.01, epsilon=1e-08, decay=0.0)  #acc: 55.86%
        adam = Adam(lr=0.001, beta_1=0.9, beta_2=0.999, epsilon=1e-08, decay=0.0) #acc: 99.63
        self.model.compile(loss='categorical_crossentropy', ##'binary_crossentropy'
                           optimizer=adam, #
                           metrics=['accuracy'])  #['precision']) #
        earlyStopping= callbacks.EarlyStopping(monitor='val_acc', patience=0, verbose=0, mode='auto')                   
                           
        if not data_augmentation:
            print('Not using data augmentation.')
            self.model.fit(dataset.X_train, dataset.Y_train,
                           batch_size=batch_size,
                           nb_epoch=nb_epoch, callbacks=earlyStopping, 
                           validation_data=(dataset.X_valid, dataset.Y_valid),
                           shuffle=True)
        else:
            print('Using real-time data augmentation.')

            # This will do preprocessing and realtime data augmentation
            datagen = ImageDataGenerator(
                featurewise_center=False,             # set input mean to 0 over the dataset
                samplewise_center=False,              # set each sample mean to 0
                featurewise_std_normalization=False,  # divide inputs by std of the dataset
                samplewise_std_normalization=False,   # divide each input by its std
                zca_whitening=False,                  # apply ZCA whitening
                rotation_range=0.,                    # randomly rotate images in the range (degrees, 0 to 180)
                width_shift_range=0.,                 # randomly shift images horizontally (fraction of total width)
                height_shift_range=0.,                # randomly shift images vertically (fraction of total height)
                channel_shift_range=0.2,
                fill_mode = 'nearest',        # Points outside the boundaries of the input are filled according to the given mode.
                horizontal_flip=False,                 # randomly flip images
                vertical_flip=True)                  # randomly flip images

            # compute quantities required for featurewise normalization
            # (std, mean, and principal components if ZCA whitening is applied)
            datagen.fit(dataset.X_train)

            # fit the model on the batches generated by datagen.flow()
            self.model.fit_generator(datagen.flow(dataset.X_train, dataset.Y_train,
                                                  batch_size=batch_size),
                                     samples_per_epoch=dataset.X_train.shape[0],
                                     nb_epoch=nb_epoch, callbacks=[earlyStopping], 
                                     validation_data=(dataset.X_valid, dataset.Y_valid))

    def save(self, file_path=FILE_PATH):
        print('Model Saved.')
        self.model.save(file_path)

    def load(self, file_path=FILE_PATH):
        print('Model Loaded.')
        self.model = load_model(file_path)

    def predict(self, image):
        image = image.reshape((1, 80, 80, 3))
        image = image.astype('float32')
        image /= 255
        result = self.model.predict_proba(image)
        print(result)
        result = self.model.predict_classes(image)

        return result[0]

    def evaluate(self, dataset, batch_size=20):
        score = self.model.evaluate(dataset.X_test, dataset.Y_test, batch_size = batch_size, verbose=0)
        print("%s: %.2f%%" % (self.model.metrics_names[1], score[1] * 100))