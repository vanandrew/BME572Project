#!/usr/bin/env python3
"""
    Transforms raw data into separate matrices for ease-of-use
"""
import scipy.io as sio
import numpy as np

# load raw data mat file and labels
rawdata = sio.loadmat('raw_resp_GH146_e51_2.mat')
labels = sio.loadmat('labels.mat')

# filter out matlab metadata
rawdata = {meta: rawdata[meta] for meta in rawdata if meta != '__header__' and meta != '__version__' and meta != '__globals__'}
labels = {meta: labels[meta] for meta in labels if meta != '__header__' and meta != '__version__' and meta != '__globals__'}

# parse each slice and roi of each time series
parseddata = dict()
for series in rawdata:
    # parse names
    parsed = series.split('slc')[1].split('_')
    slc = int(parsed[0])
    roi = int(parsed[1].split('roi')[1])

    # assign roi ordering
    order = slc*1000 + roi

    # reorganize with new key
    parseddata[order] = rawdata[series][0]

# construct each oder matrix
matfiledict = dict()
for stim,s_end,s_start,t_end,t_start in zip(*(labels[n] for n in labels)):
    # format start/end times
    stim_start = int(s_start[0])-1
    stim_end = int(s_end[0])
    time_start = int(t_start[0])-1
    time_end = int(t_end[0])

    # create time series for each oder (+ stimulus label)
    timeseries = np.zeros((len(parseddata)+1,time_end-time_start))
    
    # store stimulus in first row
    stimulus = np.zeros((1508))
    stimulus[stim_start:stim_end] = 1
    stimulus[stim_end:] = 2
    timeseries[0,:] = stimulus[time_start:time_end] 

    # for each time series obtain the portion pertaining to oder
    for n,order in enumerate(sorted(parseddata)):
        timeseries[n+1,:] = parseddata[order][time_start:time_end]
    
    # save matrix at oder dict key
    matfiledict['o_'+stim[0][0]] = timeseries

# add order to mat dict
matfiledict['order'] = np.array(sorted(parseddata))

# save dicts to matfile
sio.savemat('oder_matrices.mat',matfiledict)
parseddata = {'t_'+str(name): parseddata[name] for name in parseddata}
sio.savemat('parseddata.mat',parseddata)
