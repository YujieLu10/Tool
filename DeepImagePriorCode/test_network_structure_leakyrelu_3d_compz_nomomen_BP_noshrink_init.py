from __future__ import division, print_function, absolute_import
#import tensorflow as tf,tqdm
import tensorflow as tf
import matplotlib.pyplot as plt
from tensorflow.contrib.layers import batch_norm

import numpy as np
#from PIL import Image
#import matplotlib.pyplot as plt
import os.path
import math
from collections import OrderedDict
#from pylab import *
import os
import sys
#from IPython import display
#get_ipython().magic(u'matplotlib inline')
def lrelu(x, leak=0.2, name="lrelu"):
    with tf.variable_scope(name):
        f1 = 0.5 * (1 + leak)
        f2 = 0.5 * (1 - leak)
        return f1 * x + f2 * abs(x)


def corrupt(x):
    return tf.multiply(x, tf.cast(tf.random_uniform(shape=tf.shape(x),
                                               minval=0,
                                               maxval=2,
                                               dtype=tf.int32), tf.float32))


def batch_relu( x, phase, scope):
    return tf.contrib.layers.batch_norm(x, is_training= phase, decay=0.9, zero_debias_moving_mean=True,
                                        center=False, updates_collections=None, scope=scope)
#########################################################################
def weight_variable( shape, name):
    #initial = tf.truncated_normal(shape, stddev=stddev)
    n_input=shape[2]
    initial= tf.random_uniform(shape,-1.0 / math.sqrt(n_input),1.0 / math.sqrt(n_input),name = name + 'initial')
    return tf.get_variable(name = name, initializer = initial)

def weight_variable_devonc( shape, name):
    #return tf.Variable(tf.truncated_normal(shape, stddev=stddev))
    n_input=shape[2]
    initial= tf.random_uniform(shape,-1.0 / math.sqrt(n_input),1.0 / math.sqrt(n_input), name = name + 'initial')
    return tf.get_variable(name = name, initializer = initial)

def bias_variable( shape, name):
    initial = tf.constant(0.00001, shape=shape)
    return tf.get_variable(name = name, initializer = initial)

def conv2d( x, W,keep_prob_, name):
    return tf.nn.conv2d(x, W, strides=[1, 1, 1, 1], padding='SAME', name = name)

def conv2d_stride( x, W,keep_prob_, name):
    return tf.nn.conv2d(x, W, strides=[1, 2, 2, 1], padding='SAME', name = name)

def deconv2d( x, W,stride, name):
    x_shape = tf.shape(x,name = name + 'x_shape')
    output_shape = tf.stack([x_shape[0], x_shape[1]*2, x_shape[2]*2,  x_shape[3]//2], name = name + 'out_shape')
    return tf.nn.conv2d_transpose(x, W, output_shape, strides=[1, stride, stride, 1], padding='VALID', name = name)


# In[ ]:

#########################################################################
##### Parameters
#########################################################################
def testnetwork(fname_a, fname_b, fname_c, fname_d):
    s1=128
    s2=128
    depth = 112
    depth_short = 112
    channels=1
    layers=5
    filter_size=3
    pool_size=2
    features_root=16
    keep_prob=1.0
    n_class=1

    learning_rate = 1e-3
    batch_size =112
    n_epochs =100
    display_step = 1
    n_examples = 10
    num_axisslice = depth
    np.random.seed(0)

    # tf Graph input (only pictures)
    X = tf.placeholder("float", [1, depth,s1,s2,channels],name='X')
    Y = tf.placeholder("float", [1, depth,s1,s2, 1],name='Y')
    phase = tf.placeholder(tf.bool,name='phase')
    corruption=False

    # Optionally apply denoising autoencoder
    if corruption:
        current_input = corrupt(current_input)
    # Build the encoder
    weights = []
    biases = []
    convs = []
    pools = OrderedDict()
    deconv = OrderedDict()
    dw_h_convs = OrderedDict()
    up_h_convs = OrderedDict()
    in_size = 3000
    size = in_size
    in_node=X
    y_tensor=Y

    for layer in range(0, layers):
        features = 2**layer*features_root    
        conv1 = tf.layers.conv3d(in_node, features, filter_size, padding='same', name='conv1_%d'%layer)
        batchn =batch_norm(inputs=conv1, center=False, decay = 0.9,
                        updates_collections=None, zero_debias_moving_mean=True,
                        is_training=phase,scope='bn%d_1'%(layer+1))
        dw_h_convs[layer]=tf.nn.leaky_relu (batchn,name= 'relu1_lay%d'%layer)
        #MAIN CHANGE: instead of compress only trans, I also need to compare the axial direction
        conv2 = tf.layers.conv3d(dw_h_convs[layer], features, filter_size,strides=(1, 2, 2),
                                padding='same', name='conv2_%d'%layer)
        batchn = batch_norm(inputs=conv2, center=False, decay = 0.9,
                        updates_collections=None, zero_debias_moving_mean=True,
                        is_training=phase,scope='bn%d_2'%(layer+1))
        tmp_h_conv=tf.nn.leaky_relu (batchn,name= 'relu2_lay%d'%layer)    
        if layer < layers-1:
            in_node =tmp_h_conv
    in_node = dw_h_convs[layers-1]
    print(in_node)    
    # up layers
    for layer in range(layers-2, -1, -1):
        features = 2**(layer+1)*features_root
        in_node = tf.squeeze(in_node, [0])
        #MAIN CHANGE:change [depth, height, width, channell] into [depth, 2*height, 2*width, channell]
        upsample1 = tf.image.resize_images(in_node, size=[in_node.get_shape().as_list()[1]*2,
                                                        in_node.get_shape().as_list()[1]*2],
                                        method=tf.image.ResizeMethod.BILINEAR)
        print(upsample1)

    #    #MAIN CHANGE:previous is [depth, 2*height, 2*width, channell], change it to  [2*height,depth,2*width, channell]
    #    upsample1 = tf.transpose(upsample1,[1,0,2,3])
    #    print(upsample1)
        #MAIN CHANGE:resize into [2*height,2*depth,2*width, channell]
    #    upsample1 = tf.image.resize_images(upsample1, size=[upsample1.get_shape().as_list()[1]*2,
    #                                                      upsample1.get_shape().as_list()[2]],
    #                                      method=tf.image.ResizeMethod.BILINEAR)
    #    print(upsample1)
        #MAIN CHANGE:change back into [2*depth,2*height,2*width, channell]
    #    upsample1 = tf.transpose(upsample1,[1,0,2,3])
    #    print(upsample1)
    #    #MAIN CHANGE:reshape it into [1, 2*depth,2*height,2*width, channell]
    #    upsample1 = tf.reshape(upsample1, [1, in_node.get_shape().as_list()[0]*2,
    #                                       in_node.get_shape().as_list()[1]*2,
    #                                       in_node.get_shape().as_list()[2]*2, features])
    #    print(upsample1)

        #MAIN CHANGE:reshape it into [1, depth,2*height,2*width, channell]
        upsample1 = tf.reshape(upsample1, [1, depth,in_node.get_shape().as_list()[1]*2,in_node.get_shape().as_list()[2]*2, features])
        print(upsample1)
        upsample1 = tf.layers.conv3d(upsample1, features//2, filter_size, padding='same', name='down_conv1_%d'%layer)
        batchn =batch_norm(inputs=upsample1, center=False, decay = 0.9,
                        updates_collections=None, zero_debias_moving_mean=True,
                        is_training=phase,scope='up0_bn%d'%(layer+1))
        h_deconv = tf.nn.leaky_relu (batchn,name = 'down_relu1_lay%d'%layer)
        h_deconv_concat = tf.add(dw_h_convs[layer], h_deconv, name='add%d'%(layer+1))
        print("layer is %d"%layer)
        print(in_node)    
        deconv[layer] = h_deconv_concat
        conv1 = tf.layers.conv3d(h_deconv_concat, features//2, filter_size, padding='same', name='down_conv2_%d'%layer)
        batchn =batch_norm(inputs=conv1, center=False, decay = 0.9,
                        updates_collections=None, zero_debias_moving_mean=True, is_training=phase,scope='up1_bn%d'%(layer+1))
        h_conv = tf.nn.leaky_relu (batchn,name = 'down_relu2_lay%d'%layer)
        conv2 = tf.layers.conv3d(h_conv, features//2, filter_size, padding='same', name='down_conv3_%d'%layer)
        batchn =batch_norm(inputs=conv2, center=False, decay = 0.9,
                        updates_collections=None, zero_debias_moving_mean=True, is_training=phase,scope='up2_bn%d'%(layer+1))
        in_node = tf.nn.leaky_relu (batchn,name = 'down_relu3_lay%d'%layer)
        up_h_convs[layer] = in_node


    # Output Map
    output_map = tf.layers.conv3d(in_node, n_class, filter_size, padding='same', name='final_conv', activation = tf.nn.relu)


    # In[ ]:

    # now have the reconstruction through the network
    y_out = output_map
    # cost function measures pixel-wise difference
    cost = tf.reduce_sum(tf.square(y_out - Y))
    num_epoches =700
    update_ops = tf.get_collection(tf.GraphKeys.UPDATE_OPS)
    with tf.control_dependencies(update_ops):
        train_step = tf.contrib.opt.ScipyOptimizerInterface(cost,method='L-BFGS-B',options={'maxiter': num_epoches,'disp':1,'ftol':1e-25})
        train_step_nesterov = tf.train.MomentumOptimizer(learning_rate = 1e-9, momentum=0.9, use_nesterov=True).minimize(cost)
    # Create a saver for writing training checkpoints.
    evaluate=tf.reduce_sum(tf.square(y_out - Y))
    saver = tf.train.Saver(max_to_keep=30)
    config = tf.ConfigProto()
    config.gpu_options.allow_growth=True
    sess = tf.Session(config=config)
    #myiter = int(sys.argv[1]);
    myiter = 1
    myrealization=1

    ###########################################################################
    ### Below is to load the data for training
    ###########################################################################
    #fp=open('/Users/c-ten/Desktop/STall/github/AIMedicalPrivate/DeepImagePriorCode/training.mr.simulation.img','rb')
    fp=open(fname_a,'rb')
    tempx= np.fromfile(fp,dtype=np.float32).reshape((depth,s1,s2,channels))
    tempzn=np.zeros((depth, s1, s2,channels), dtype = np.float32)
    tempzn = tempx
    tempzn = np.reshape(tempzn, (1,depth,s1,s2,channels))

    #fp=open('/Users/c-ten/Desktop/STall/github/AIMedicalPrivate/DeepImagePriorCode/training.bp.init.img','rb')
    fp=open(fname_b,'rb')
    temp=np.fromfile(fp,dtype=np.float32).reshape( (depth,s1,s2))
    Truth=np.zeros((depth, s1, s2,1), dtype = np.float32)
    Truth= temp
    Truth = np.reshape(Truth, (1,depth,s1,s2,1))

    ###########################################################################
    ### Below is to train the network
    ###########################################################################

    sess.run(tf.initialize_all_variables())
    for epoch_i in range(30):
        _, c= sess.run([train_step_nesterov, cost], feed_dict={X: tempzn, Y: Truth,phase:1})
        sys.__stdout__.write('(%d, %d): loss = %f\n'%(epoch_i, 0, c))  
    train_step.minimize(sess, feed_dict={X: tempzn, Y: Truth,phase:1})
    recon= sess.run([y_out], feed_dict={X: tempzn, Y: Truth,phase:1})
    myrecon = np.array(recon, dtype=np.float32)
    myrecon = np.reshape(myrecon,[1,depth,s1,s2])
    fp=open(fname_c+'/image_output_init'+str(num_epoches)+'.img','w')
    myrecon.tofile(fp)
    saver.save(sess, fname_d+'/BPtraining_it'+str(myiter)+'epochs_'+str(num_epoches))

if '__main__'==__name__:
    testnetwork(str(sys.argv[1]), str(sys.argv[2]), str(sys.argv[3]), str(sys.argv[4]))

